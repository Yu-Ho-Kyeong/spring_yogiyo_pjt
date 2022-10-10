package com.hk.jmt.review.ServiceImpl;

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
import com.hk.jmt.review.Dao.ReviewDao;
import com.hk.jmt.review.Service.ReviewService;
import com.hk.jmt.review.Vo.ReviewVO;
import com.hk.jmt.store.ServiceImpl.StoreServiceImpl;
import com.hk.jmt.util.Criteria;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao dao;
	@Autowired
	private Tika tika;
	
	@Value("#{config['upload.review.path']}")
	private String reviewFolder;
	@Value("#{config['download.review.uri']}")
	private String reviewPath;
	@Value("#{config['application.bucket.name']}")
	private String bucketName;
	@Value("#{config['cloud.aws.credentials.accessKey']}")
	private String accessKey;
	@Value("#{config['cloud.aws.credentials.secretKey']}")
	private String secretKey;
	@Value("#{config['cloudfront.domain.path']}")
	private String cloudFrontUrl;
	
	// 리뷰 리스트 가져오기
	@Override
	public List<ReviewVO> getReviewList(Criteria cri, Integer storeNo, String memberId) {
		return dao.getReviewList(cri, storeNo, memberId);
	}
	// 회원 리뷰 리스트 가져오기(회원 리뷰관리)
	@Override
	public List<ReviewVO> getMemberReview(Criteria cri, String memberId) {
		return dao.getMemberReview(cri, memberId);
	}
	// 리뷰 등록
	@Override
	public void createReview(ReviewVO review, String name) throws IllegalStateException, IOException {
//		review.setReviewImg("/img/default.jpg");
		review.setReviewDate(LocalDateTime.now());
		System.out.println("서비스 날짜" + review.getReviewDate());
		
		dao.createReview(review);
		
		MultipartFile reviewImg = review.getFile();
		// S3 업로드
		String uploadedPath = awsUpload(reviewImg);
				  
		review.setReviewImg(uploadedPath);
		dao.updateReview(review);
		dao.updateReviewCnt(review);
		dao.updateReviewEnabled(review);
	}
	// 리뷰 삭제
	@Override
	public void deleteReview(Integer reviewNo) {
		dao.deleteReview(reviewNo);
	}
	// 리뷰 count
	@Override
	public int countReview(Integer storeNo) {
		return dao.countReview(storeNo);
	}
	// 맛 별점 평균
	@Override
	public Double avgMatPoint(Integer storeNo) {
		return dao.avgMatPoint(storeNo);
	}
	// 양 별점 평균
	@Override
	public Double avgYangPoint(Integer storeNo) {
		return dao.avgYangPoint(storeNo);
	}
	// 배달 별점 평균
	@Override
	public Double avgBaedalPoint(Integer storeNo) {
		return dao.avgBaedalPoint(storeNo);
	}
	// 전체 별점 평균
	@Override
	public Double avgStarPoint(Integer storeNo) {
		return dao.avgStarPoint(storeNo);
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
		String uploadedPath = reviewFolder + "/" + uploadFileName;
		
		// 업로드 봎더에 업로드할 파일 복사
		// 파일을 바이트코드로 
		byte[] fileData = file.getBytes();
		// service\storeLogoUrl\20220812162030_가게로고.png
		File target = new File(reviewFolder, uploadFileName);
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
		String uploadedPath = cloudFrontUrl + reviewFolder + "/" + uploadFileName;
		
		String fileName = reviewFolder + "/" + uploadFileName;
		
		
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
