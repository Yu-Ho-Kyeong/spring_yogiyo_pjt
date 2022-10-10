package com.hk.jmt.cart.Vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class CartListVO {
	private long storeNo;
	private String storeName;
	int cartTotal;
	private int deleveryTip;
	
	List<CartVO> cart;
}