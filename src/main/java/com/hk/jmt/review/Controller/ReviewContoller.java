package com.hk.jmt.review.Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.member.Vo.MemberVO;
import com.hk.jmt.order.Service.OrderService;
import com.hk.jmt.review.Service.ReviewService;
import com.hk.jmt.review.Vo.ReviewVO;
import com.hk.jmt.util.Criteria;
import com.hk.jmt.util.MediaUtils;
import com.hk.jmt.util.PageMaker;

@Controller
public class ReviewContoller {
	
	@Autowired
	private ReviewService rservice;
	@Autowired
	private OrderService oservice;
	private static final Logger log = LoggerFactory.getLogger(ReviewContoller.class);
	
	// 회원 리뷰관리
	@Secured("ROLE_MEMBER")
	@GetMapping("/member/memberReviewList")
	public ModelAndView memberReviewList(Criteria cri, Authentication authentication, Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<ReviewVO> getMemberReview = rservice.getMemberReview(cri, authentication.getName());
		
		mv.addObject("getMemberReview", getMemberReview);
	 
		return mv;
	}
	// 리뷰 작성 GET
	@Secured("ROLE_MEMBER")
	@GetMapping("/review/createReview")
	public ModelAndView createReview(Integer orderNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.addObject("map", oservice.orderInfo(orderNo));
		mv.setViewName("/review/createReview");
		return mv;
	}
	// 리뷰작성 POST
	@Secured("ROLE_MEMBER")
	@PostMapping("/review/createReview")
	public String createReview(Integer storeNo, ReviewVO review, BindingResult result,
							   Authentication authentication) throws IllegalStateException, IOException{
		review.setMemberId(authentication.getName());
		// 스토어 넘버를 jsp에서 가져옴
		review.setStoreNo(storeNo);
		System.out.println("storeNo" + storeNo);
		rservice.createReview(review, authentication.getName());
		System.out.println(authentication.getName());
		return "redirect:/member/memberOrderList";
	}
	// 리뷰 삭제
	@Secured("ROLE_MEMBER")
	@ResponseBody
	@PostMapping("/review/deleteReview")
	public void deleteStore(@RequestParam Integer reviewNo){
		rservice.deleteReview(reviewNo);	
	}
	// 로고 썸네일 보여주기
	@ResponseBody
	@RequestMapping("/review/img")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
				
		log.info("FILE NAME: " + fileName);
				
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			log.info("FILE FORMAT: " + formatName);
					
			MediaType mType = MediaUtils.getMediaType(formatName);
					
			HttpHeaders headers = new HttpHeaders();
					
			in = new FileInputStream(fileName);
					
			if( mType != null) {
				headers.setContentType(mType);
			} else {
				fileName = fileName.substring(fileName.lastIndexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859") + "\"");
			}
					
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
					
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}
}
