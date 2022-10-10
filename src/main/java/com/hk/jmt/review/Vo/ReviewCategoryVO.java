package com.hk.jmt.review.Vo;

import lombok.Data;

@Data
public class ReviewCategoryVO {
	
	private int reviewNo;
	private int storeNo;
	private String memberId; 
	private int reviewStarPoint; 
	private String reviewCategory;
}
