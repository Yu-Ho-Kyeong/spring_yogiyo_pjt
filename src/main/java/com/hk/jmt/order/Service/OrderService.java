package com.hk.jmt.order.Service;

import java.util.List;

import com.hk.jmt.cart.Vo.CartVO;
import com.hk.jmt.member.Vo.MemberVO;

import com.hk.jmt.order.Vo.OrderVO;
import com.hk.jmt.util.Criteria;

public interface OrderService {

	/* 회원 주문내역 */
	public List<OrderVO> memberOrderList(Criteria cri, String memberId) throws Exception;
	/* 회원 주문내역 count */
	public int totalOrderCount(Criteria cri, String memberId) throws Exception;
	// 주문 정보 가져오기
	public Object orderInfo(Integer orderNo) throws Exception;
	//주문자 회원 정보 
	public MemberVO getMemberInfo(String memberId) throws Exception;
	// 주문자가 담은 카트 가져오기
	public List<CartVO> getCartList(String memberId) throws Exception;
	// 주문정보 등록
	public int insertOrderList(OrderVO order) throws Exception;
	// 가게 이름 찾기
	public CartVO findStoreName(String memberId) throws Exception;
}
