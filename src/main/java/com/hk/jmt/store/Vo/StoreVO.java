package com.hk.jmt.store.Vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hk.jmt.review.Vo.ReviewVO;

import lombok.Data;

@Data
public class StoreVO {
	private Integer storeNo;
	private Integer categoryId;
	private String storeAddress;
	private String storePostNo;
	private String storeRoadPost;
	private String storeDetailPost;
	private String storeName;
	private double storeStarPoint;
	private Integer storeReviewCnt;
	private	Integer storeReplyCnt;
	private Integer storeMenuCnt;
	private	String storeOpenTime;
	private	String storeCloseTime;
	private	String ownerId;
	private String ownerInfo;
	private	String storeDeliveryTime;
	private	String storeTel;
	private	MultipartFile file;
	private	String storeLogoUrl;
	private	String storePaymentMethod;
	private	String storeMinPrice;
	private	String storeCuponBase;
	private	boolean storeEnabled;
	
	private List<ReviewVO> reviewList;
	private double avgStoreStarPoint; 
}
