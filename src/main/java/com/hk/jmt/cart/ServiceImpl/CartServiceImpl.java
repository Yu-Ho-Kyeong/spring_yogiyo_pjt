package com.hk.jmt.cart.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.jmt.cart.Dao.CartDao;
import com.hk.jmt.cart.Service.CartService;
import com.hk.jmt.cart.Vo.CartVO;
import com.hk.jmt.order.Vo.OrderVO;
@Service
public class CartServiceImpl implements CartService{

	@Autowired
	private CartDao dao;
	
	// 카트목록 불러오기
	@Override
	public List<CartVO> getCartList(String memberId) {
		List<CartVO> cartList = dao.getCartList(memberId);
		
		for(CartVO cart : cartList) {
			cart.initTotal();
		}
		
		return cartList;
	}
	// 새로운 카트 생성
	@Override
	public int getNewCartList() {
		return dao.getNewCartList();
	}
	// 카트 체크 (카트에 담기전)
	@Override
	public CartVO checkCart(CartVO cart) {
		return dao.checkCart(cart);
	}
	// 카트 담기
	@Override
	public int addCart(CartVO cart) throws Exception {
		
		// 1. 다른 가게의 장바구니가 담겼는지?
		// -> result : 2
		// -> 삭제요청
		//     -> 해당 memberId 의 장바구니 데이터 모두 삭제
		// -> 삭제하지 않음
		int otherStoreCount = dao.checkStore(cart);
		
		if( otherStoreCount >= 1 ) { // 카트에 메뉴를 담은 상태에서 다른 가게 메뉴를 담을시
			return 2; 
		}
		
		// 2. 기존에 현재 가게의 메뉴가 담겼는지?
		CartVO checkCart = dao.checkCart(cart); // 카트 데이터 체크
		if(checkCart != null) { // 이미 담은 메뉴인 경우
			System.out.println("########### 이미 담은 메뉴라서 수량 추가함");
			return dao.addPlusCart(cart);
		}
		// 장바구니 등록 & 에러 시 0반환
		try {
			return dao.addCart(cart);
		} catch (Exception e) {
			return 0;
		}
	}
	// 카트 개별삭제
	@Override
	public int deleteCart(Integer cartNo) {
		return  dao.deleteCart(cartNo);
	}
	// 카트 전체삭제
	@Override
	public int deleteAllCart(String memberId) {
		return dao.deleteAllCart(memberId);
	}
	@Override
	public int plusCart(CartVO cart) throws Exception {
		return  dao.plusCart(cart);
	}
	@Override
	public int minusCart(CartVO cart) throws Exception {
		return  dao.minusCart(cart);
	}
	@Override
	public CartVO findMemberCart(String memberId) {
		return dao.findMemberCart(memberId);
	}
}
