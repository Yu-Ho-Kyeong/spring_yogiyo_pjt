package com.hk.jmt.order.Vo;

import java.util.List;

import javax.mail.Store;

import com.hk.jmt.store.Vo.StoreVO;

import lombok.Data;

@Data
public class OrderVO {
	
	private Integer orderNo;
	private String orderDate;
	private String orderPaymentMethod;
	private String orderMenu;
	private Integer orderAmount;
	private Integer orderTotalPrice;
	private String orderTel;
	private String orderAddress;
	private String orderRequest;
	private Integer storeNo;
	private String memberId;
	private Integer orderEnabled;
	private String orderStoreName;
	private StoreVO store;
}
