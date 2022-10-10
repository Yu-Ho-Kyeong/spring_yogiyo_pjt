package com.hk.jmt.cart.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.jmt.cart.Service.CartService;
import com.hk.jmt.cart.Vo.CartVO;

@Controller
public class CartController {
	
	@Autowired
	private CartService cservice; //카트
	private static final Logger log = LoggerFactory.getLogger(CartController.class);

	/*
	 * 0: 등록실패
	 * 1: 등록 성공
	 * 2: 등록된 데이터 존재 (기존의 데이터를 삭제하고 새로 담을 것인지)
	 * 5: 로그인 필요
	 */
	 
	/* 장바구니 목록 불러오기 */
	@Secured("ROLE_MEMBER")
	@GetMapping("/store/cartOrder")
	public String cartOrderGET(HttpServletRequest request, Model model) {
		//세션에 저장된 멤버 아이디 확인
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		//db에 저장된 cartList
		List<CartVO> cartList = cservice.getCartList(memberId);
		
		System.out.println("############# cartList : " + cartList);
        
		model.addAttribute("cartList", cartList);
		return "/store/cartOrder";
    }
	
	
	@Secured("ROLE_MEMBER")
	@GetMapping("/cart/list")
	public String cartOrderList(HttpServletRequest request, Model model) {
		//세션에 저장된 멤버 아이디 확인
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		//db에 저장된 cartList
		List<CartVO> cartList = cservice.getCartList(memberId);
		
		System.out.println("cartList : " + cartList);
		
		model.addAttribute("cartList", cartList);
		return "/cart/list";
	}

	@PostMapping("/cart/add")
	@ResponseBody
	public String addCartPOST(CartVO cart, HttpServletRequest request) throws Exception{
		//세션에 저장된 멤버 아이디 확인
		HttpSession session = request.getSession();
        String memberId = (String)session.getAttribute("memberId");
        
        if(memberId == null) { //로그인되지 않았다면
            return "5";
        }
		int result = cservice.addCart(cart); // 카트 등록
     	return result + ""; // addCart의 반환타입: int -> string 변환
    }
	
	@PostMapping("/cart/plus")
	@ResponseBody
	public String plusCart(CartVO cart, HttpServletRequest request) throws Exception{
		//세션에 저장된 멤버 아이디 확인
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		if(memberId == null) { //로그인되지 않았다면
			return "5";
		}
		int result = cservice.plusCart(cart); // 카트 +1
		return result + ""; // addCart의 반환타입: int -> string 변환
	}
	
	
	@PostMapping("/cart/minus")
	@ResponseBody
	public String minusCart(CartVO cart, HttpServletRequest request) throws Exception{
		//세션에 저장된 멤버 아이디 확인
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		if(memberId == null) { //로그인되지 않았다면
			return "5";
		}
		int result = cservice.minusCart(cart); // 카트 +1
		return result + ""; // addCart의 반환타입: int -> string 변환
	}
	/* 카트 개별삭제 */
	@PostMapping("/cart/delete")
	@ResponseBody
	public void deleteCart(@RequestParam Integer cartNo) {
        cservice.deleteCart(cartNo);
    }
	/* 카트 전체비우기GET */
	@GetMapping("/cart/deleteAll")
	@ResponseBody
    public void deleteAllGET(HttpSession session) {
        String memberId = (String)session.getAttribute("memberId");
        if(memberId!=null) {
        	cservice.deleteAllCart(memberId);
        }
	}	
	/* 카트 전체비우기POST */
	@PostMapping("/cart/deleteAll")
	@ResponseBody
	public void deleteAllPOST(HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		if(memberId!=null) {
			cservice.deleteAllCart(memberId);
		}
	}	
}

