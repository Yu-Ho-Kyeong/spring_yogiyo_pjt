package com.hk.jmt.review.Vo;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import com.hk.jmt.order.Vo.OrderVO;

import lombok.Data;

@Data
public class ReviewVO {
	
	private Integer reviewNo;
	private String memberId; 
	private String reviewMenuName; 
	private String reviewContent; 
	private LocalDateTime reviewDate; 
	private Integer reviewStarPoint; 
	private Integer reviewMatPoint; 
	private Integer reviewYangPoint; 
	private Integer reviewBaedalPoint;  
	private String reviewRecommendCnt; 
	private String reviewImg; 
	private Integer orderNo; 
	private Integer storeNo;
	private	MultipartFile file;
	
	private Double avgReviewStarPoint; 
	private Double avgReviewMatPoint; 
	private Double avgReviewYangPoint; 
	private Double avgReviewBaedalPoint; 
	private OrderVO order;
	
}
