package com.hk.jmt.menu.ServiceImpl;

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

import com.hk.jmt.menu.Dao.MenuDao;
import com.hk.jmt.menu.Service.MenuService;

import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.util.Criteria;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuDao dao;

	@Value("#{config['upload.menu.path']}")
	private String menuFolder;
	@Value("#{config['download.menu.uri']}")
	private String menuPath;
	@Value("#{config['application.bucket.name']}")
	private String bucketName;
	@Value("#{config['cloud.aws.credentials.accessKey']}")
	private String accessKey;
	@Value("#{config['cloud.aws.credentials.secretKey']}")
	private String secretKey;
	@Value("#{config['cloudfront.domain.path']}")
	private String cloudFrontUrl;
	
	
	// 메뉴 리스트
	public List<MenuVO> getMenuList(Criteria cri, Integer storeNo) {
		return dao.getMenuList(cri, storeNo);
	}
	// 메뉴 count
	@Override
	public int countMenu(Criteria cri, Integer storeNo) {
		return dao.countMenu(cri, storeNo);
	}
	// 메뉴등록
	@Override
	public void createMenu(MenuVO menu, String ownerId) throws IllegalStateException, IOException {
		System.out.println(menu);
		menu.setMenuUrl("/img/ic_photomenu_default.png");
		
		MultipartFile menuUrl = menu.getFile();// 사진을 첨부하지 않으면 디폴트이미지 등록
		dao.createMenu(menu);
			
		// S3 업로드
		String uploadedPath = awsUpload(menuUrl);
		
		menu.setMenuUrl(uploadedPath);
		dao.updateMenu(menu);
		dao.findAllBySno(menu.getStoreNo());
	}
	// 메뉴 삭제
	@Override
	public int deleteMenu(Integer menuNo, Integer storeNo) {
		return dao.deleteMenu(menuNo, storeNo);
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
		String uploadedPath = menuFolder + "/" + uploadFileName;
		
		// 업로드 폴더에 업로드할 파일 복사
		// 파일을 바이트코드로 
		byte[] fileData = file.getBytes();
		// service\storeLogoUrl\20220812162030_가게로고.png
		File target = new File(menuFolder, uploadFileName);
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
		String uploadedPath = cloudFrontUrl + menuFolder + "/" + uploadFileName;
		
		String fileName = menuFolder + "/" + uploadFileName;
		
		
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

}
