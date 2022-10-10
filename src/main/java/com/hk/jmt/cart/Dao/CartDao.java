package com.hk.jmt.cart.Dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.cart.Vo.CartVO;

@Repository
public class CartDao {

	@Autowired
	private SqlSessionTemplate sql;
	String ns = "cartSql";
	
	//카트 목록 불러오기
	public List<CartVO> getCartList(String memberId){ 
		return sql.selectList(ns + ".getCartList", memberId);	
	}
	//새로운 카트 생성
	public int getNewCartList() {
		// 현재 카트 num 의 최댓값을 받아와 +1 값으로 리턴하여
		// 새로운 cart row 생성 
		int result = sql.selectOne(ns + ".getNewCartList");
		return result+1;
	}
	//카트 체크 (카트에 담기전)
	public int checkStore(CartVO cart) {
		return sql.selectOne(ns + ".checkStore", cart);
	}
	//카트 체크 (카트에 담기전)
	public CartVO checkCart(CartVO cart) {
		return sql.selectOne(ns + ".checkCart", cart);
	}
	//카트 담기 
	public int addCart(CartVO cart) throws Exception {
		return sql.insert(ns + ".addCart", cart);
	}
	//카트 담기 
	public int addPlusCart(CartVO cart) throws Exception {
		return sql.insert(ns + ".addPlusCart", cart);
	}
	//카트 +1
	public int plusCart(CartVO cart) throws Exception {
		return sql.update(ns + ".plusCart", cart);
	}
	//카트 - 
	public int minusCart(CartVO cart) throws Exception {
		return sql.update(ns + ".minusCart", cart);
	}
	//카트 삭제 
	public int deleteCart(Integer cartNo) {
		return sql.delete(ns + ".deleteCart", cartNo);
	}
	//카트 전체삭제 
	public int deleteAllCart(String memberId) {
		return sql.delete(ns + ".deleteAllCart", memberId);
	}
	// id로 카트 찾기
	public CartVO findMemberCart(String memberId) {
		return sql.selectOne(ns + ".", memberId);
	}
	
}
