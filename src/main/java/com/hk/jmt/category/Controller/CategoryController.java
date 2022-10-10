package com.hk.jmt.category.Controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hk.jmt.category.Service.CategoryService;
import com.hk.jmt.store.Service.StoreService;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;
import com.hk.jmt.util.PageMaker;

// Controller - 화면단위, RestController = Controller + @ResponseBody

@Controller
public class CategoryController {
	
	// todo 생성자 주입으로 바꿀것
	private CategoryService cservice;
	private StoreService sservice; // 스토어
	
	@Autowired
	public CategoryController(CategoryService cservice, StoreService sservice) {
		this.cservice = cservice;
		this.sservice = sservice;
	}

	private static final Logger log = LoggerFactory.getLogger(CategoryController.class);
	
	// 카테고리 메뉴 import
	@RequestMapping(value="/include/categoryMenu", method= RequestMethod.GET)
	public String categoryMenu() {
		return "/include/categoryMenu";	
	}
	// 전체보기 리스트
	@RequestMapping(value="/category/all", method= RequestMethod.GET)
	public ModelAndView listAll(Criteria cri, Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listAll = cservice.listAll(cri);
		double avgStorePoint = sservice.avgStorePoint(storeNo);
		StoreVO storeAVG = new StoreVO();
		storeAVG.setAvgStoreStarPoint(avgStorePoint);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countAll(cri));
		mv.setViewName("/category/all.slimSearchLayout");
		mv.addObject("listAll", listAll); // cri가 담긴 list
		mv.addObject("pageMaker", pageMaker); // cri total이 담긴 pageaMaker
		mv.addObject("storeAVG", storeAVG);
		return mv;
	}
	// 1인분주문 리스트
	@RequestMapping(value="/category/oneOrder", method= RequestMethod.GET)
	public ModelAndView listOneOrder(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listOneOrder = cservice.listOneOrder(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countOneOrder(categoryId));
		mv.setViewName("/category/oneOrder.slimSearchLayout");
		mv.addObject("listOneOrder", listOneOrder);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 프렌차이즈 리스트
	@RequestMapping(value="/category/franchise", method= RequestMethod.GET)
	public ModelAndView listFranchise(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listFranchise = cservice.listFranchise(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countFranchise(categoryId));
		mv.setViewName("/category/franchise.slimSearchLayout");
		mv.addObject("listFranchise", listFranchise);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 치킨 리스트
	@RequestMapping(value="/category/chicken", method= RequestMethod.GET)
	public ModelAndView listChicken(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChicken = cservice.listChicken(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChicken(categoryId));
		mv.setViewName("/category/chicken.slimSearchLayout");
		mv.addObject("listChicken", listChicken);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 양식 리스트
	@RequestMapping(value="/category/yangsik", method= RequestMethod.GET)
	public ModelAndView listYangsik(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYangsik = cservice.listYangsik(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYangsik(categoryId));
		mv.setViewName("/category/yangsik.slimSearchLayout");
		mv.addObject("listYangsik", listYangsik);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 중식 리스트
	@RequestMapping(value="/category/china", method= RequestMethod.GET)
	public ModelAndView listChina(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChina = cservice.listChina(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChina(categoryId));
		mv.setViewName("/category/china.slimSearchLayout");
		mv.addObject("listChina", listChina);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 한식 리스트
	@RequestMapping(value="/category/korea", method= RequestMethod.GET)
	public ModelAndView listKorea(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listKorea = cservice.listKorea(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countKorea(categoryId));
		mv.setViewName("/category/korea.slimSearchLayout");
		mv.addObject("listKorea", listKorea);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 일식 리스트
	@RequestMapping(value="/category/japan", method= RequestMethod.GET)
	public ModelAndView listJapan(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJapan = cservice.listJapan(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJapan(categoryId));
		mv.setViewName("/category/japan.slimSearchLayout");
		mv.addObject("listJapan", listJapan);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 족발 리스트
	@RequestMapping(value="/category/jokbal", method= RequestMethod.GET)
	public ModelAndView listJokbal(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJokbal = cservice.listJokbal(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJokbal(categoryId));
		mv.setViewName("/category/jokbal.slimSearchLayout");
		mv.addObject("listJokbal", listJokbal);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 야식 리스트
	@RequestMapping(value="/category/yasik", method= RequestMethod.GET)
	public ModelAndView listYasik(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYasik = cservice.listYasik(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYasik(categoryId));
		mv.setViewName("/category/yasik.slimSearchLayout");
		mv.addObject("listYasik", listYasik);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 분식 리스트
	@RequestMapping(value="/category/boonsik", method= RequestMethod.GET)
	public ModelAndView listBoonsik(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listBoonsik = cservice.listBoonsik(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countBoonsik(categoryId));
		mv.setViewName("/category/boonsik.slimSearchLayout");
		mv.addObject("listBoonsik", listBoonsik);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 디저트 리스트
	@RequestMapping(value="/category/desert", method= RequestMethod.GET)
	public ModelAndView listDesert(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listDesert = cservice.listDesert(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countDesert(categoryId));
		mv.setViewName("/category/desert.slimSearchLayout");
		mv.addObject("listDesert", listDesert);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 편의점 리스트
	@RequestMapping(value="/category/mart", method= RequestMethod.GET)
	public ModelAndView listMart(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listMart = cservice.listMart(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countMart(categoryId));
		mv.setViewName("/category/mart.slimSearchLayout");
		mv.addObject("listMart", listMart);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	
	
	
	
	
	
	
	// 전체보기 리스트
	@RequestMapping(value="/category/allReviewSort", method= RequestMethod.GET)
	public ModelAndView listAllReviewSort(Criteria cri, Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listAllReviewSort = cservice.listAllReviewSort(cri);
		double avgStorePoint = sservice.avgStorePoint(storeNo);
		StoreVO storeAVG = new StoreVO();
		storeAVG.setAvgStoreStarPoint(avgStorePoint);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countAll(cri));
		mv.setViewName("/category/allReviewSort.slimSearchLayout");
		mv.addObject("listAllReviewSort", listAllReviewSort); // cri가 담긴 list
		mv.addObject("pageMaker", pageMaker); // cri total이 담긴 pageaMaker
		mv.addObject("storeAVG", storeAVG);
		return mv;
	}
	// 1인분주문 리스트
	@RequestMapping(value="/category/oneOrderReviewSort", method= RequestMethod.GET)
	public ModelAndView listOneOrderReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listOneOrderReviewSort = cservice.listOneOrderReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countOneOrder(categoryId));
		mv.setViewName("/category/oneOrderReviewSort.slimSearchLayout");
		mv.addObject("listOneOrderReviewSort", listOneOrderReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 프렌차이즈 리스트
	@RequestMapping(value="/category/franchiseReviewSort", method= RequestMethod.GET)
	public ModelAndView listFranchiseReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listFranchiseReviewSort = cservice.listFranchiseReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countFranchise(categoryId));
		mv.setViewName("/category/franchiseReviewSort.slimSearchLayout");
		mv.addObject("listFranchiseReviewSort", listFranchiseReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 치킨 리스트
	@RequestMapping(value="/category/chickenReviewSort", method= RequestMethod.GET)
	public ModelAndView listChickenReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChickenReviewSort = cservice.listChickenReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChicken(categoryId));
		mv.setViewName("/category/chickenReviewSort.slimSearchLayout");
		mv.addObject("listChickenReviewSort", listChickenReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 양식 리스트
	@RequestMapping(value="/category/yangsikReviewSort", method= RequestMethod.GET)
	public ModelAndView listYangsikReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYangsikReviewSort = cservice.listYangsikReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYangsik(categoryId));
		mv.setViewName("/category/yangsikReviewSort.slimSearchLayout");
		mv.addObject("listYangsikReviewSort", listYangsikReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 중식 리스트
	@RequestMapping(value="/category/chinaReviewSort", method= RequestMethod.GET)
	public ModelAndView listChinaReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChinaReviewSort = cservice.listChinaReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChina(categoryId));
		mv.setViewName("/category/chinaReviewSort.slimSearchLayout");
		mv.addObject("listChinaReviewSort", listChinaReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 한식 리스트
	@RequestMapping(value="/category/koreaReviewSort", method= RequestMethod.GET)
	public ModelAndView listKoreaReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listKoreaReviewSort = cservice.listKoreaReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countKorea(categoryId));
		mv.setViewName("/category/koreaReviewSort.slimSearchLayout");
		mv.addObject("listKoreaReviewSort", listKoreaReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 일식 리스트
	@RequestMapping(value="/category/japanReviewSort", method= RequestMethod.GET)
	public ModelAndView listJapanReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJapanReviewSort = cservice.listJapanReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJapan(categoryId));
		mv.setViewName("/category/japanReviewSort.slimSearchLayout");
		mv.addObject("listJapanReviewSort", listJapanReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 족발 리스트
	@RequestMapping(value="/category/jokbalReviewSort", method= RequestMethod.GET)
	public ModelAndView listJokbalReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJokbalReviewSort = cservice.listJokbalReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJokbal(categoryId));
		mv.setViewName("/category/jokbalReviewSort.slimSearchLayout");
		mv.addObject("listJokbalReviewSort", listJokbalReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 야식 리스트
	@RequestMapping(value="/category/yasikReviewSort", method= RequestMethod.GET)
	public ModelAndView listYasikReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYasikReviewSort = cservice.listYasikReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYasik(categoryId));
		mv.setViewName("/category/yasikReviewSort.slimSearchLayout");
		mv.addObject("listYasikReviewSort", listYasikReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 분식 리스트
	@RequestMapping(value="/category/boonsikReviewSort", method= RequestMethod.GET)
	public ModelAndView listBoonsikReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listBoonsikReviewSort = cservice.listBoonsikReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countBoonsik(categoryId));
		mv.setViewName("/category/boonsikReviewSort.slimSearchLayout");
		mv.addObject("listBoonsikReviewSort", listBoonsikReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 디저트 리스트
	@RequestMapping(value="/category/desertReviewSort", method= RequestMethod.GET)
	public ModelAndView listDesertReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listDesertReviewSort = cservice.listDesertReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countDesert(categoryId));
		mv.setViewName("/category/desertReviewSort.slimSearchLayout");
		mv.addObject("listDesertReviewSort", listDesertReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 편의점 리스트
	@RequestMapping(value="/category/martReviewSort", method= RequestMethod.GET)
	public ModelAndView listMartReviewSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listMartReviewSort = cservice.listMartReviewSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countMart(categoryId));
		mv.setViewName("/category/martReviewSort.slimSearchLayout");
		mv.addObject("listMartReviewSort", listMartReviewSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	
	
	
	
	
	
	// 전체보기 리스트
	@RequestMapping(value="/category/allStarSort", method= RequestMethod.GET)
	public ModelAndView listAllStarSort(Criteria cri, Integer storeNo) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listAllStarSort = cservice.listAllStarSort(cri);
		double avgStorePoint = sservice.avgStorePoint(storeNo);
		StoreVO storeAVG = new StoreVO();
		storeAVG.setAvgStoreStarPoint(avgStorePoint);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countAll(cri));
		mv.setViewName("/category/allStarSort.slimSearchLayout");
		mv.addObject("listAllStarSort", listAllStarSort); // cri가 담긴 list
		mv.addObject("pageMaker", pageMaker); // cri total이 담긴 pageaMaker
		mv.addObject("storeAVG", storeAVG);
		return mv;
	}
	// 1인분주문 리스트
	@RequestMapping(value="/category/oneOrderStarSort", method= RequestMethod.GET)
	public ModelAndView listOneOrderStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listOneOrderStarSort = cservice.listOneOrderStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countOneOrder(categoryId));
		mv.setViewName("/category/oneOrderStarSort.slimSearchLayout");
		mv.addObject("listOneOrderStarSort", listOneOrderStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 프렌차이즈 리스트
	@RequestMapping(value="/category/franchiseStarSort", method= RequestMethod.GET)
	public ModelAndView listFranchiseStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listFranchiseStarSort = cservice.listFranchiseStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countFranchise(categoryId));
		mv.setViewName("/category/franchiseStarSort.slimSearchLayout");
		mv.addObject("listFranchiseStarSort", listFranchiseStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 치킨 리스트
	@RequestMapping(value="/category/chickenStarSort", method= RequestMethod.GET)
	public ModelAndView listChickenStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChickenStarSort = cservice.listChickenStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChicken(categoryId));
		mv.setViewName("/category/chickenStarSort.slimSearchLayout");
		mv.addObject("listChickenStarSort", listChickenStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 양식 리스트
	@RequestMapping(value="/category/yangsikStarSort", method= RequestMethod.GET)
	public ModelAndView listYangsikStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYangsikStarSort = cservice.listYangsikStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYangsik(categoryId));
		mv.setViewName("/category/yangsikStarSort.slimSearchLayout");
		mv.addObject("listYangsikStarSort", listYangsikStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 중식 리스트
	@RequestMapping(value="/category/chinaStarSort", method= RequestMethod.GET)
	public ModelAndView listChinaStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listChinaStarSort = cservice.listChinaStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countChina(categoryId));
		mv.setViewName("/category/chinaStarSort.slimSearchLayout");
		mv.addObject("listChinaStarSort", listChinaStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 한식 리스트
	@RequestMapping(value="/category/koreaStarSort", method= RequestMethod.GET)
	public ModelAndView listKoreaStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listKoreaStarSort = cservice.listKoreaStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countKorea(categoryId));
		mv.setViewName("/category/koreaStarSort.slimSearchLayout");
		mv.addObject("listKoreaStarSort", listKoreaStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 일식 리스트
	@RequestMapping(value="/category/japanStarSort", method= RequestMethod.GET)
	public ModelAndView listJapanStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJapanStarSort = cservice.listJapanStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJapan(categoryId));
		mv.setViewName("/category/japanStarSort.slimSearchLayout");
		mv.addObject("listJapanStarSort", listJapanStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 족발 리스트
	@RequestMapping(value="/category/jokbalStarSort", method= RequestMethod.GET)
	public ModelAndView listJokbalStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listJokbalStarSort = cservice.listJokbalStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countJokbal(categoryId));
		mv.setViewName("/category/jokbalStarSort.slimSearchLayout");
		mv.addObject("listJokbalStarSort", listJokbalStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 야식 리스트
	@RequestMapping(value="/category/yasikStarSort", method= RequestMethod.GET)
	public ModelAndView listYasikStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listYasikStarSort = cservice.listYasikStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countYasik(categoryId));
		mv.setViewName("/category/yasikStarSort.slimSearchLayout");
		mv.addObject("listYasikStarSort", listYasikStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 분식 리스트
	@RequestMapping(value="/category/boonsikStarSort", method= RequestMethod.GET)
	public ModelAndView listBoonsikStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listBoonsikStarSort = cservice.listBoonsikStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countBoonsik(categoryId));
		mv.setViewName("/category/boonsikStarSort.slimSearchLayout");
		mv.addObject("listBoonsikStarSort", listBoonsikStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 디저트 리스트
	@RequestMapping(value="/category/desertStarSort", method= RequestMethod.GET)
	public ModelAndView listDesertStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listDesertStarSort = cservice.listDesertStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countDesert(categoryId));
		mv.setViewName("/category/desertStarSort.slimSearchLayout");
		mv.addObject("listDesertStarSort", listDesertStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
	// 편의점 리스트
	@RequestMapping(value="/category/martStarSort", method= RequestMethod.GET)
	public ModelAndView listMartStarSort(Criteria cri, String categoryId) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<StoreVO> listMartStarSort = cservice.listMartStarSort(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(cservice.countMart(categoryId));
		mv.setViewName("/category/martStarSort.slimSearchLayout");
		mv.addObject("listMartStarSort", listMartStarSort);
		mv.addObject("pageMaker", pageMaker);
		return mv;
	}
}
