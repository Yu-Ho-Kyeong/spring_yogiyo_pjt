package com.hk.jmt.category.Service;

import java.util.List;

import com.hk.jmt.main.Vo.mainCategoryVo;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;

public interface CategoryService {
	
	// 카테고리메뉴 이름 list 
	public List<mainCategoryVo> getCategoryMenu() throws Exception;
	// 전체보기 count
	public int countAll(Criteria cri) throws Exception;
	// 1인분 count
	public int countOneOrder(String categoryId) throws Exception;
	// 프렌차이즈 count
	public int countFranchise(String categoryId) throws Exception;
	// 치킨 count
	public int countChicken(String categoryId) throws Exception;
	// 양식 count
	public int countYangsik(String categoryId) throws Exception;
	// 중식 count
	public int countChina(String categoryId) throws Exception;
	// 한식 count
	public int countKorea(String categoryId) throws Exception;
	// 일식 count
	public int countJapan(String categoryId) throws Exception;	
	// 족발 count
	public int countJokbal(String categoryId) throws Exception;	
	// 야식 count
	public int countYasik(String categoryId) throws Exception;
	// 분식 count
	public int countBoonsik(String categoryId) throws Exception;		
	// 디저트 count
	public int countDesert(String categoryId) throws Exception;	
	// 편의점 count
	public int countMart(String categoryId) throws Exception;
	/*게시물 총 개수(검색용)*/
	public int getTotal(Criteria cri) throws Exception;
		
	// 전체보기 리스트
	public List<StoreVO> listAll(Criteria cri) throws Exception;
	// 1인분 리스트
	public List<StoreVO> listOneOrder(Criteria cri) throws Exception;	
	// 프렌차이즈 리스트
	public List<StoreVO> listFranchise(Criteria cri) throws Exception;	
	// 치킨 리스트
	public List<StoreVO> listChicken(Criteria cri) throws Exception;
	// 양식 리스트
	public List<StoreVO> listYangsik(Criteria cri) throws Exception;
	// 중식 리스트
	public List<StoreVO> listChina(Criteria cri) throws Exception;	
	// 한식 리스트
	public List<StoreVO> listKorea(Criteria cri) throws Exception;	
	// 일식 리스트
	public List<StoreVO> listJapan(Criteria cri) throws Exception;	
	// 족발 리스트
	public List<StoreVO> listJokbal(Criteria cri)throws Exception;
	// 야식 리스트
	public List<StoreVO> listYasik(Criteria cri) throws Exception;
	// 분식 리스트
	public List<StoreVO> listBoonsik(Criteria cri) throws Exception;	
	// 디저트 리스트
	public List<StoreVO> listDesert(Criteria cri) throws Exception;
	// 편의점 리스트
	public List<StoreVO> listMart(Criteria cri) throws Exception;
	
	
	
	
	// 전체보기 리스트
	public List<StoreVO> listAllReviewSort(Criteria cri) throws Exception;
	// 1인분 리스트
	public List<StoreVO> listOneOrderReviewSort(Criteria cri) throws Exception;	
	// 프렌차이즈 리스트
	public List<StoreVO> listFranchiseReviewSort(Criteria cri) throws Exception;	
	// 치킨 리스트
	public List<StoreVO> listChickenReviewSort(Criteria cri) throws Exception;
	// 양식 리스트
	public List<StoreVO> listYangsikReviewSort(Criteria cri) throws Exception;
	// 중식 리스트
	public List<StoreVO> listChinaReviewSort(Criteria cri) throws Exception;	
	// 한식 리스트
	public List<StoreVO> listKoreaReviewSort(Criteria cri) throws Exception;	
	// 일식 리스트
	public List<StoreVO> listJapanReviewSort(Criteria cri) throws Exception;	
	// 족발 리스트
	public List<StoreVO> listJokbalReviewSort(Criteria cri)throws Exception;
	// 야식 리스트
	public List<StoreVO> listYasikReviewSort(Criteria cri) throws Exception;
	// 분식 리스트
	public List<StoreVO> listBoonsikReviewSort(Criteria cri) throws Exception;	
	// 디저트 리스트
	public List<StoreVO> listDesertReviewSort(Criteria cri) throws Exception;
	// 편의점 리스트
	public List<StoreVO> listMartReviewSort(Criteria cri) throws Exception;
	
	
	
	
	
	// 전체보기 리스트
	public List<StoreVO> listAllStarSort(Criteria cri) throws Exception;
	// 1인분 리스트
	public List<StoreVO> listOneOrderStarSort(Criteria cri) throws Exception;	
	// 프렌차이즈 리스트
	public List<StoreVO> listFranchiseStarSort(Criteria cri) throws Exception;	
	// 치킨 리스트
	public List<StoreVO> listChickenStarSort(Criteria cri) throws Exception;
	// 양식 리스트
	public List<StoreVO> listYangsikStarSort(Criteria cri) throws Exception;
	// 중식 리스트
	public List<StoreVO> listChinaStarSort(Criteria cri) throws Exception;	
	// 한식 리스트
	public List<StoreVO> listKoreaStarSort(Criteria cri) throws Exception;	
	// 일식 리스트
	public List<StoreVO> listJapanStarSort(Criteria cri) throws Exception;	
	// 족발 리스트
	public List<StoreVO> listJokbalStarSort(Criteria cri)throws Exception;
	// 야식 리스트
	public List<StoreVO> listYasikStarSort(Criteria cri) throws Exception;
	// 분식 리스트
	public List<StoreVO> listBoonsikStarSort(Criteria cri) throws Exception;	
	// 디저트 리스트
	public List<StoreVO> listDesertStarSort(Criteria cri) throws Exception;
	// 편의점 리스트
	public List<StoreVO> listMartStarSort(Criteria cri) throws Exception;
	
	
	/* 검색 리스트 */
	public List<StoreVO> getSearchList(Criteria cri) throws Exception;
	/* 검색 별점 정렬 */
	public List<StoreVO> getStarList(Criteria cri) throws Exception;
	/* 검색 리뷰 정렬 */
	public List<StoreVO> getReviewList(Criteria cri) throws Exception;
}