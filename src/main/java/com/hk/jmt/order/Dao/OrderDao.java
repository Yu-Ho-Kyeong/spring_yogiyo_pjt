package com.hk.jmt.order.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.cart.Vo.CartVO;
import com.hk.jmt.member.Vo.MemberVO;

import com.hk.jmt.order.Vo.OrderVO;
import com.hk.jmt.util.Criteria;

@Repository
public class OrderDao {

	@Autowired
	private SqlSessionTemplate sql;
	String ns = "orderSql";

	//회원 주문내역 
	public List<OrderVO> memberOrderList(Criteria cri, String memberId) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("rowStart", cri.getRowStart());
		params.put("rowEnd", cri.getRowEnd());
		
		return sql.selectList(ns + ".memberOrderList", params);
	}
	//회원 주문내역 count
	public int totalOrderCount(Criteria cri, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("cri", cri);
		return sql.selectOne(ns + ".totalOrderCount", params);
	}
	// 주문 정보 가져오기
	public Object orderInfo(Integer orderNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("orderNo", orderNo);
		return sql.selectList(ns + ".orderInfo", map);
	}
	//주문자 회원 정보
	public MemberVO getMemberInfo(String memberId) {
		return sql.selectOne(ns + ".getMemberInfo", memberId);
	}
	// 주문자가 담은 카트 가져오기
	public List<CartVO> getCartList(String memberId) throws Exception {
		return sql.selectList(ns + ".getCartList", memberId);
	}
	// 주문정보 등록
	public int insertOrderList(OrderVO order) throws Exception {
		return sql.insert(ns + ".insertOrderList", order);
	}
	// 가게 이름 찾기
	public CartVO findStoreName(String memberId) {
		return sql.selectOne(ns + ".findStoreName", memberId);
	}
	 
}
