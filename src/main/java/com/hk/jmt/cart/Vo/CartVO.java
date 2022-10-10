package com.hk.jmt.cart.Vo;

import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.store.Vo.StoreVO;

import lombok.Data;

@Data
public class CartVO {
	 // cart
	 private Integer cartNo; 
	 private String memberId;  // member
	 private Integer menuNo; // menu
	 private Integer cartAmount;
	 private Integer storeNo; //store
	 // menu	 
	 private String menuName;
	 private Integer menuPrice;
	 //추가
	 private Integer totalPrice;
	 private String storeName;
	 private StoreVO store;
	 private MenuVO menu;
	 //합계금액 계산
	 public void initTotal() {
		if( cartAmount == null ) cartAmount = 0;
		if( menuPrice == null ) menuPrice = 0;
		this.totalPrice = this.menuPrice*this.cartAmount;
	} 	 
}
