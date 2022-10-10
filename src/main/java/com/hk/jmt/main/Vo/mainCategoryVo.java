package com.hk.jmt.main.Vo;

import lombok.Data;

@Data
public class mainCategoryVo {
	private int categoryId; //카테고리 식별자	
	private String categoryName; // 카테고리명
	private String categoryClickUrl; // 카테고리 클릭경로
	private String categoryImgUrl; // 카테고리 이미지경로
	private String categoryAlt; // 카테고리 alt
}
