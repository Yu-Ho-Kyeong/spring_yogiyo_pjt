package com.hk.jmt.cart.Service;

import java.util.List;

import com.hk.jmt.cart.Vo.CartVO;

public interface CartService {
	
	/* 카트 목록 */
	public List<CartVO> getCartList(String memberId);
	/* 새로운 카트 생성 */
	public int getNewCartList();
	/* 카트 담기  */
	public int addCart(CartVO cart) throws Exception;
	/* 카트 +1  */
	public int plusCart(CartVO cart) throws Exception;
	/* 카트 -1  */
	public int minusCart(CartVO cart) throws Exception;
	/* 카트 삭제 */
	public int deleteCart(Integer cartNo);
	/* 카트 전체삭제 */
	public int deleteAllCart(String memberId);
	/* 카트 확인 */
	public CartVO checkCart(CartVO cart);
	/* id로 카트 찾기 */
	public CartVO findMemberCart(String memberId);
}
