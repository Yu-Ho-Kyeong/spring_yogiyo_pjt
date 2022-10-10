package com.hk.jmt.order.Controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.cart.Service.CartService;
import com.hk.jmt.cart.Vo.CartVO;
import com.hk.jmt.member.Vo.MemberVO;

import com.hk.jmt.order.Service.OrderService;
import com.hk.jmt.order.Vo.OrderVO;

import com.hk.jmt.util.Criteria;
import com.hk.jmt.util.PageMaker;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {
	@Autowired
	private OrderService oservice;
	@Autowired
	private CartService cservice;
	
	
	// 회원 주문내역 GET
	@Secured("ROLE_MEMBER")
	@GetMapping("/member/memberOrderList")
	public ModelAndView memberOrderList(Criteria cri, Authentication aithentication, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		
		List<OrderVO> memberOrderList = oservice.memberOrderList(cri, aithentication.getName());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(oservice.totalOrderCount(cri, aithentication.getName()));
		
		mv.setViewName("member/memberOrderList.noSearchLayout");
		mv.addObject("memberOrderList", memberOrderList);
		mv.addObject("pageMaker", pageMaker); // cri total이 담긴 pageaMaker
		return mv;	
	}
	// 주문 페이지 GET
	@Secured("ROLE_MEMBER")
	@GetMapping("/order/checkout/{memberId}")
	public ModelAndView checkoutGET(@PathVariable("memberId") String memberId, Integer storeNo, HttpSession session) throws Exception {
		// List<CartVO> cartList = (List<CartVO>) session.getAttribute("cartList");
		
		ModelAndView mv = new ModelAndView();
		storeNo = (Integer) session.getAttribute("storeNo"); 
		System.out.println("session storeNo: " + storeNo);

		List<CartVO> cartList = oservice.getCartList(memberId); // 
		MemberVO memberInfo = oservice.getMemberInfo(memberId);
		CartVO store = oservice.findStoreName(memberId);
		Integer totalPrice = 0;

		if( !cartList.isEmpty() ) {
			for(CartVO cart : cartList) {
				totalPrice += cart.getMenuPrice()*cart.getCartAmount();	
			}
		}
		memberInfo.setMemberPhoneNo(memberInfo.getMemberPhoneNo());
		mv.setViewName("/order/checkout.noSearchLayout");
		mv.addObject("cartList", cartList);
		mv.addObject("memberInfo", memberInfo);
		mv.addObject("totalPrice", totalPrice);
		mv.addObject("store", store); 
	
		return mv;	
	}
	// 결제모듈창 이동 
	@PostMapping("/order/pay")
	public ModelAndView checkOutPOST(OrderVO order, MemberVO member) throws Exception{
		ModelAndView mv = new ModelAndView();
		MemberVO memberInfo = oservice.getMemberInfo(member.getMemberId());
		mv.addObject("order", order);
		mv.addObject("memberInfo", memberInfo);
		log.info("order : " + order);
		mv.setViewName("/order/pay");//아임포트 결제 페이지로 이동
		return mv;
	}
	// 주문내역 insert
	@GetMapping("/order/insertOrderList")//결제가 완료될경우 ajax를 통해 넘어옴
	public ModelAndView insertOrderList(OrderVO order, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();	
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("memberId");
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(order.getMemberId());
		oservice.insertOrderList(order);
		cservice.deleteAllCart(memberId);
		return mv;
	}

}
