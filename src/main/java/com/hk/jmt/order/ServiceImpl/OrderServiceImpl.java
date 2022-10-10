package com.hk.jmt.order.ServiceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.jmt.cart.Vo.CartVO;
import com.hk.jmt.member.Vo.MemberVO;
import com.hk.jmt.order.Dao.OrderDao;
import com.hk.jmt.order.Service.OrderService;
import com.hk.jmt.order.Vo.OrderList;
import com.hk.jmt.order.Vo.OrderVO;
import com.hk.jmt.util.Criteria;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao dao;

	//회원 주문내역 
	@Override
	public List<OrderVO> memberOrderList(Criteria cri, String memberId) throws Exception {
		return dao.memberOrderList(cri, memberId);
	}
	//회원 주문내역 count
	@Override
	public int totalOrderCount(Criteria cri, String memberId) throws Exception {
		return dao.totalOrderCount(cri, memberId);
	}
	//주문자 회원 정보 
	public MemberVO getMemberInfo(String memberId) throws Exception {
		return dao.getMemberInfo(memberId);
	}
	//주문자 회원 정보
	@Override
	public Object orderInfo(Integer orderNo) throws Exception {
		Object info = dao.orderInfo(orderNo);
		Map<String, Object> map = new HashMap<>();
		map.put("info", info);
		System.out.println("service info : " + info);
		return map;
	}	
	// 주문자가 담은 카트 가져오기
	@Override
	public List<CartVO> getCartList(String memberId) throws Exception {
		return dao.getCartList(memberId);
	}
	// 주문정보 등록
	@Override
	public int insertOrderList(OrderVO order) throws Exception {
		int result = 0;
		result = dao.insertOrderList(order);
		return result;
	}
	// 가게 이름 찾기
	@Override
	public CartVO findStoreName(String memberId) throws Exception {
		return dao.findStoreName(memberId);
	}

}
