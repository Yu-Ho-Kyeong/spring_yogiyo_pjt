package com.hk.jmt.menu.Vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class MenuVO {
		
	private Integer menuNo;
	private String menuName;
	private String menuUrl;
	private String menuInfo;		
	private Integer menuPrice;
	private String menuType;
	private String menuMain;
	private Integer menuDiscount;
	private String menuPromotion;
	private Integer menuStock;
	private Integer storeNo;
	private String ownerId;
	private Integer menuCategoryNo; 
	private	MultipartFile file;
}
