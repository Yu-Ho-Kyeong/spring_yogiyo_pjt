package com.hk.jmt.order.Vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderList {
	private Integer orderListNo;
	private Integer menuNo;
	private Integer orderNo;
	private Integer orderListAmount;
	
	private List <OrderVO> orders;

}
