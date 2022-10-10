package com.hk.jmt.store.ServiceImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.hk.jmt.constant.JOB;
import com.hk.jmt.exception.JobFailException;
import com.hk.jmt.store.Dao.StoreDao;
import com.hk.jmt.store.Service.StoreService;
import com.hk.jmt.store.Vo.StoreVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StoreServiceImpl implements StoreService{


	@Value("#{config['upload.storeLogoUrl.path']}")
	private String storeLogoFolder;
	@Value("#{config['download.storeLogoUrl.uri']}")
	private String storeLogoPath;
	
	@Value("#{config['application.bucket.name']}")
	private String bucketName;
	@Value("#{config['cloud.aws.credentials.accessKey']}")
	private String accessKey;
	@Value("#{config['cloud.aws.credentials.secretKey']}")
	private String secretKey;
	@Value("#{config['cloudfront.domain.path']}")
	private String cloudFrontUrl;
	

	@Autowired
	private StoreDao dao;
	
	@Autowired
	private Tika tika;
	
//	@Autowired
//	private AmazonS3 s3Client;
	
	
	// 가게 상세보기
	@Override
	public List<StoreVO> getStoreDetail(Integer storeNo) {
		return dao.getStoreDetail(storeNo);
	}
	// 가게 등록
	@Override
	public void createStore(StoreVO store, String name) throws IllegalStateException, IOException {
		System.out.println(store);
		store.setStoreLogoUrl("default_restaurant_logo.png");
		
		MultipartFile storeLogoUrl = store.getFile();
		
		dao.createStore(store);// 사진을 첨부하지 않으면 디폴트이미지 등록
		// 파일 스니핑검사, 여러 유효성 검사 추가
		if(storeLogoUrl != null) {
//			int lastIndexOfDot = storeLogoUrl.getOriginalFilename().lastIndexOf('.');
//			String extension = storeLogoUrl.getOriginalFilename().substring(lastIndexOfDot);
//			File file = new File(storeLogoFolder, store.getStoreNo() + extension);
//			storeLogoUrl.transferTo(file);
//			String fileType = tika.detect(file).substring(0, 5);
//			// log level 설정가능한 slf4j, logback 고려
//			System.out.println(storeLogoUrl.getOriginalFilename());
//			System.out.println("@@@@@@@@@@ fileType: " + fileType);
//			System.out.println("@@@@@@@@@@ fileType: " + fileType);
//			
//			if(!fileType.equals("image"))
//				throw new JobFailException(JOB.NOT_IMAGE_FILE);
//			store.setStoreLogoUrl(file.getName());
		}
		
		// 로컬 업로드 
		// String uploadedPath = localUpload(storeLogoUrl);
		
		// S3 업로드
		String uploadedPath = awsUpload(storeLogoUrl);
		
		   
		store.setStoreLogoUrl(uploadedPath);
		dao.updateStore(store);
	}
	// 가게 삭제
	@Override
	public int deleteStore(Integer storeNo, String ownerId) {
		System.out.println("ownerId: " + ownerId);
		return dao.deleteStore(storeNo);
	}
	// 리뷰개수 반영하기
	@Override
	public int updateReviewCnt(Integer storeNo) {
		return dao.updateReviewCnt(storeNo);
	}
	// 메뉴개수 반영하기
	@Override
	public int updateMenuCnt(Integer storeNo) {
		return dao.updateMenuCnt(storeNo);
	}
	// 댓글 개수 반영
	@Override
	public int updateReplyCnt(Integer storeNo) {
		return dao.updateReplyCnt(storeNo);
	}
	// 가게 전체 평균 별점 
	@Override
	public double avgStorePoint(Integer storeNo) {
		return dao.avgStorePoint(storeNo);
	}
	
	/**
	 * 로컬 업로드
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public String localUpload(MultipartFile file) throws IOException {
		
		// 실제 파일 업로드
		// 파일명 중복 방지를 위한 날짜시간 생성
		LocalDateTime now = LocalDateTime.now();
		String fmtNow = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		
		// 20220812162030_가게로고.png
		String uploadFileName = fmtNow + "_" + file.getOriginalFilename();
		String uploadedPath = storeLogoFolder + "/" + uploadFileName;
		
		// 업로드 봎더에 업로드할 파일 복사
		// 파일을 바이트코드로 
		byte[] fileData = file.getBytes();
		// D:\service\storeLogoUrl\20220812162030_가게로고.png
		File target = new File(storeLogoFolder, uploadFileName);
		FileCopyUtils.copy(fileData, target);
		
		return uploadedPath;
	}
	
	
	/**
	 * AWS S3 Upload
	 * @param file
	 * @return
	 * @throws IOException
	 */
	public String awsUpload(MultipartFile file) throws IOException {
		
		BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
								.withRegion(Regions.AP_NORTHEAST_2)
								.withCredentials(new AWSStaticCredentialsProvider(awsCreds))
		                        .build();

		File fileObj = convertMultipartFileToFile(file);
		
		LocalDateTime now = LocalDateTime.now();
		String fmtNow = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		
		// 20220812162030_가게로고.png
		String uploadFileName = fmtNow + "_" + file.getOriginalFilename();
		String uploadedPath = cloudFrontUrl + storeLogoFolder + "/" + uploadFileName;
		
		String fileName = storeLogoFolder + "/" + uploadFileName;
		
		
		// 버킷이름, 파일이름, 파일객체
		s3Client.putObject(new PutObjectRequest(bucketName, fileName, fileObj));
		fileObj.delete();
		
		return uploadedPath;
	}
	
	
	/**
	 * MultipartFile -> File
	 * @param file
	 * @return
	 */
	private File convertMultipartFileToFile(MultipartFile file) {
		File convertedFile = new File(file.getOriginalFilename());
		try(FileOutputStream fos = new FileOutputStream(convertedFile)) {
			fos.write(file.getBytes());
		} catch (Exception e) {
			log.error("Error : 파일 변환 중 에러...");
		}
		return convertedFile;
	}
	
	/**
	 * AWS S3 Delete
	 * @param fileName
	 * @return
	 */
	// service/storeLogoUrl/(fileName.jpg)
//	public String deleteFile(String fileName) {
//		s3Client.deleteObject(bucketName, fileName);
//		return fileName +  " removed...";
//	}
//	
//	@Override
//	public void deleteLogoFile(String storeLogoUrl) {
//		deleteFile(storeLogoUrl);
//	}
	
	
	
}


















