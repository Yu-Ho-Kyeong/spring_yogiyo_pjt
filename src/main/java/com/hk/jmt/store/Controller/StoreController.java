package com.hk.jmt.store.Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.hk.jmt.category.Service.CategoryService;
import com.hk.jmt.menu.Service.MenuService;

import com.hk.jmt.menu.Vo.MenuVO;
import com.hk.jmt.order.Service.OrderService;

import com.hk.jmt.owner.Service.OwnerService;
import com.hk.jmt.owner.Vo.OwnerVO;
import com.hk.jmt.ownerReply.Service.OwnerReplyService;
import com.hk.jmt.ownerReply.Vo.OwnerReplyVO;
import com.hk.jmt.review.Service.ReviewService;

import com.hk.jmt.review.Vo.ReviewVO;
import com.hk.jmt.store.Service.StoreService;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;
import com.hk.jmt.util.MediaUtils;
import com.hk.jmt.util.PageMaker;

@Controller
public class StoreController {
	
	@Autowired
	private StoreService sservice; // 스토어
	@Autowired
	private MenuService mservice; // 메뉴
	@Autowired
	private ReviewService rservice; //리뷰 
	@Autowired
	private OwnerService oservice; // 오너
	@Autowired
	private OwnerReplyService orservice; //owner 댓글
	@Autowired
	private CategoryService cservice; // 카테고리
	@Autowired
	private OrderService orderservice; // 카테고리
	@Autowired
	private Gson gson;
	private static final Logger log = LoggerFactory.getLogger(StoreController.class);
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	// 가게 등록
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/store/createStore", method = RequestMethod.GET)
	public String createStoreGET() {
		return "/store/createStore";
	}
	// 가게 등록 POST
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/store/createStore", method=RequestMethod.POST)
	public ResponseEntity<String> createStorePOST(StoreVO store, BindingResult result, Authentication authentication) throws IllegalStateException, IOException {
		
		log.info("넘어옴...");
		log.info("가게등록 : " + store);
		store.setStoreAddress(store.getStorePostNo()+" " + store.getStoreRoadPost() + " " + store.getStoreDetailPost());
		store.setOwnerId(authentication.getName());
		store.setStoreMinPrice(store.getStoreMinPrice());//+"원"
		sservice.createStore(store, authentication.getName());
			
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	// 스토어 상세보기
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/store/storeDetail", method = RequestMethod.GET)
	public ModelAndView getStoreDetail(Criteria cri, Integer orderNo, Integer storeNo, String memberId, OwnerReplyVO reply,
			Integer reviewNo, Integer menuNo, Authentication aithentication, Model model, HttpSession session) throws Exception {

		ModelAndView mv = new ModelAndView();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(rservice.countReview(storeNo));
		
		sservice.updateReviewCnt(storeNo); // 리뷰개수 반영
		sservice.updateMenuCnt(storeNo); // 메뉴개수 반영
		sservice.updateReplyCnt(storeNo); // 사장댓글 개수 반영
		sservice.avgStorePoint(storeNo);
		List<StoreVO> getStoreDetail = sservice.getStoreDetail(storeNo);
		List<MenuVO> getMenuList = mservice.getMenuList(cri, storeNo);
		List<ReviewVO> getReviewList = rservice.getReviewList(cri, storeNo, memberId);
		List<OwnerReplyVO> getOwnerReply = orservice.getOwnerReply(storeNo);
		int ownerReplyNo = orservice.countReplyNo(storeNo, reviewNo);
		Double avgStarPoint = rservice.avgStarPoint(storeNo); // 리뷰 전체 평균 평점 
		Double avgMatPoint = rservice.avgMatPoint(storeNo);  // 리뷰 맛 평균 평점
		Double avgYangPoint = rservice.avgYangPoint(storeNo); // 리뷰 양 평균 평점
		Double avgBaedalPoint = rservice.avgBaedalPoint(storeNo);//리뷰 배달 평균평점
		Double avgStorePoint = sservice.avgStorePoint(storeNo);// 스토어 전체 평균 평점
		ReviewVO reviewAVG = new ReviewVO();
		StoreVO storeAVG = new StoreVO();
		reviewAVG.setAvgReviewStarPoint(avgStarPoint);
		reviewAVG.setAvgReviewMatPoint(avgMatPoint);
		reviewAVG.setAvgReviewYangPoint(avgYangPoint);
		reviewAVG.setAvgReviewBaedalPoint(avgBaedalPoint);
		storeAVG.setAvgStoreStarPoint(avgStorePoint); 

		mv.setViewName("/store/storeDetail.slimSearchLayout");
		mv.addObject("getStoreDetail", getStoreDetail); // 해당 store 상세정보
		mv.addObject("getMenuList", getMenuList); // 해당 store의 menu 리스트
		mv.addObject("getReviewList", getReviewList); // 해당 store의 review 리스트
		mv.addObject("storeNo", storeNo);
		mv.addObject("menuNo", menuNo);
		mv.addObject("pageMaker", pageMaker); //
		mv.addObject("reviewAVG", reviewAVG); //
		mv.addObject("storeAVG", storeAVG); //
		mv.addObject("map", orderservice.orderInfo(orderNo));
		model.addAttribute("menu", mservice.getMenuList(cri, storeNo));
		mv.addObject("getOwnerReply", getOwnerReply); // 해당 store의 owner 댓글 리스트
		mv.addObject("ownerReplyNo", ownerReplyNo); // 해당 store의 owner 댓글 리스트
			 		 		 		
		return mv;
	}
	// 스토어 상세보기
	@Secured("ROLE_OWNER")
	@RequestMapping(value = "/store/storeDetail/{memberId}", method = RequestMethod.GET)
	public ModelAndView getStoreDetailMemberId(Criteria cri, Integer storeNo, @PathVariable("memberId") String memberId, OwnerReplyVO reply,
			Integer reviewNo, Integer menuNo, Authentication aithentication, Model model) {
		
		ModelAndView mv = new ModelAndView();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(rservice.countReview(storeNo));
		
		sservice.updateReviewCnt(storeNo); // 리뷰개수 반영
		sservice.updateMenuCnt(storeNo); // 메뉴개수 반영
		sservice.updateReplyCnt(storeNo); // 사장댓글 개수 반영
		sservice.avgStorePoint(storeNo);
		List<StoreVO> getStoreDetail = sservice.getStoreDetail(storeNo);
		List<MenuVO> getMenuList = mservice.getMenuList(cri, storeNo);
		List<ReviewVO> getReviewList = rservice.getReviewList(cri, storeNo, memberId);
		List<OwnerReplyVO> getOwnerReply = orservice.getOwnerReply(storeNo);
		int ownerReplyNo = orservice.countReplyNo(storeNo, reviewNo);
		 
		double avgStarPoint = rservice.avgStarPoint(storeNo); 
		double avgMatPoint = rservice.avgMatPoint(storeNo); 
		double avgYangPoint = rservice.avgYangPoint(storeNo);
		double avgBaedalPoint = rservice.avgBaedalPoint(storeNo);
		double avgStorePoint = sservice.avgStorePoint(storeNo);
		ReviewVO reviewAVG = new ReviewVO();
		StoreVO storeAVG = new StoreVO();
		reviewAVG.setAvgReviewStarPoint(avgStarPoint);
		reviewAVG.setAvgReviewMatPoint(avgMatPoint);
		reviewAVG.setAvgReviewYangPoint(avgYangPoint);
		reviewAVG.setAvgReviewBaedalPoint(avgBaedalPoint);
		storeAVG.setAvgStoreStarPoint(avgStorePoint);

		mv.setViewName("/store/storeDetail.slimSearchLayout");
		mv.addObject("getStoreDetail", getStoreDetail); // 해당 store 상세정보
		mv.addObject("getMenuList", getMenuList); // 해당 store의 menu 리스트
		mv.addObject("getReviewList", getReviewList); // 해당 store의 review 리스트
		mv.addObject("storeNo", storeNo);
		mv.addObject("menuNo", menuNo);
		mv.addObject("pageMaker", pageMaker); //
		mv.addObject("reviewAVG", reviewAVG); //
		mv.addObject("storeAVG", storeAVG); //
		model.addAttribute("menu", mservice.getMenuList(cri, storeNo));
		mv.addObject("getOwnerReply", getOwnerReply); // 해당 store의 owner 댓글 리스트
		mv.addObject("ownerReplyNo", ownerReplyNo); // 해당 store의 owner 댓글 리스트
		 		 		 		
		return mv;
	}
	// 가게 삭제하기(myStore)
	@Secured("ROLE_OWNER")
	@ResponseBody
	@RequestMapping(value="/store/deleteStore", method=RequestMethod.GET)
	public ModelAndView deleteStoreGET(Authentication authentication, Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		OwnerVO loginOwner = oservice.ownerMyPage(authentication.getName());
		StoreVO myStore = oservice.ownerMyStoreDetail(storeNo);
		mv.setViewName("/store/deleteStore.noSearchLayout");
		mv.addObject("owner", gson.toJson(loginOwner));	
		mv.addObject("myStore", myStore);	
		return mv;
	}
	// 가게 삭제하기(myStore)
	@Secured("ROLE_OWNER")
	@PostMapping("/store/deleteStore")
	public ResponseEntity<?> deleteStore(Integer storeNo, Authentication authentication){
		return ResponseEntity.ok(sservice.deleteStore(storeNo, authentication.getName()));
	}
	/* 검색 결과 */
	@GetMapping("/store/listSearch")
	public String listSearchGET(Criteria cri, Model model) throws Exception{
		log.info("listSearchGET.......");
		List<StoreVO> getSearchList = cservice.getSearchList(cri);
		
		if(!getSearchList.isEmpty()) {
			model.addAttribute("list", getSearchList);
		} else {
			model.addAttribute("listcheck", "empty");
			return "/store/listSearch.slimSearchLayout";
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.getTotal(cri));
		model.addAttribute("pageMaker", pageMaker);
	
		return "/store/listSearch.slimSearchLayout";
	} 
	/* 검색 결과 */
	@GetMapping("/store/listStarSort")
	public String listStarGET(Criteria cri, Model model) throws Exception{
		log.info("listStarGET.......");
		List<StoreVO> getStarSort = cservice.getStarList(cri);
		
		if(!getStarSort.isEmpty()) {
			model.addAttribute("list", getStarSort);
		} else {
			model.addAttribute("listcheck", "empty");
			return "/store/listStarSort.slimSearchLayout";
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.getTotal(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		return "/store/listStarSort.slimSearchLayout";
	} 
	/* 검색 결과 */
	@GetMapping("/store/listReviewSort")
	public String listReviewGET(Criteria cri, Model model) throws Exception{
		log.info("listReviewGET.......");
		List<StoreVO> getReviewSort = cservice.getReviewList(cri);
		
		if(!getReviewSort.isEmpty()) {
			model.addAttribute("list", getReviewSort);
		} else {
			model.addAttribute("listcheck", "empty");
			return "/store/listReviewSort.slimSearchLayout";
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.getTotal(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		return "/store/listReviewSort.slimSearchLayout";
	} 
	// 가게 리뷰 페이지
	@RequestMapping(value = "/store/reviewAjax", method = RequestMethod.GET)
	public String reviewAjaxPage(Model model, Criteria cri, Integer storeNo, String memberId) {
		
		int page = cri.getPage();
		cri = new Criteria(page);
		log.info("cri : " + cri);
		
		List<StoreVO> getStoreDetail = sservice.getStoreDetail(storeNo);
		List<ReviewVO> getReviewList = rservice.getReviewList(cri, storeNo, memberId);
		model.addAttribute("getReviewList", getReviewList);
		model.addAttribute("getStoreDetail", getStoreDetail);
		
		return "/store/reviewAjax";
	}
	
	// 로고 썸네일 보여주기
	@ResponseBody
	@RequestMapping("/store/img")
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
