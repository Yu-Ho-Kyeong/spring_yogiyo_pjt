package com.hk.jmt.menu.Vo;

import java.util.List;

import lombok.Data;

@Data
public class MenuCategoryVO {
	
	private Integer menuCategoryNo; 
	private String menuCategoryName;
	private String menuCategoryInfo;
	private Integer storeNo;
	private List<MenuVO> menu;
}
