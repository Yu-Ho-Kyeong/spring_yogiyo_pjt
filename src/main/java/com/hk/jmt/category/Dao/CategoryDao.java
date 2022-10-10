package com.hk.jmt.category.Dao;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.main.Vo.mainCategoryVo;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;

@Repository
public class CategoryDao extends AbstractDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	
	String ns = "categorySql";

	// 카테고리메뉴 이름 list 
	public List<mainCategoryVo> getCategoryMenu() {
		return sql.selectList(ns + ".getCategoryMenu");
	}
	// 전체보기 count
	public int countAll(Criteria cri) {
		return sql.selectOne(ns + ".countAll", cri);
	}
	// 1인분 count
	public int countOneOrder(String categoryId) {
		return sql.selectOne(ns + ".countOneOrder", categoryId);
	}
	// 프렌차이즈 count
	public int countFranchise(String categoryId) {
		return sql.selectOne(ns + ".countFranchise", categoryId);
	}	
	// 치킨 count
	public int countChicken(String categoryId) {
		return sql.selectOne(ns + ".countChicken", categoryId);
	}	
	// 피자 count
	public int countYangsik(String categoryId) {
		return sql.selectOne(ns + ".countYangsik", categoryId);
	}	
	// 중식 count
	public int countChina(String categoryId) {
		return sql.selectOne(ns + ".countChina", categoryId);
	}
	// 한식 count
	public int countKorea(String categoryId) {
		return sql.selectOne(ns + ".countKorea", categoryId);
	}	
	// 일식 count
	public int countJapan(String categoryId) {
		return sql.selectOne(ns + ".countJapan", categoryId);
	}
	// 족발 count
	public int countJokbal(String categoryId) {
		return sql.selectOne(ns + ".countJokbal", categoryId);
	}
	// 야식 count
	public int countYasik(String categoryId) {
		return sql.selectOne(ns + ".countYasik", categoryId);
	}
	// 분식 count
	public int countBoonsik(String categoryId) {
		return sql.selectOne(ns + ".countBoonsik", categoryId);
	}	
	// 디저트 count
	public int countDesert(String categoryId) {
		return sql.selectOne(ns + ".countDesert", categoryId);
	}	
	// 편의점 count
	public int countMart(String categoryId) {
		return sql.selectOne(ns + ".countMart", categoryId);
	}
	/*게시물 총 개수(검색용)*/
	public int getTotal(Criteria cri) {
		return sql.selectOne(ns + ".getTotal", cri);
	}
		
	// 전체보기 list
	public List<StoreVO> listAll(Criteria cri) {	
		return sql.selectList(ns + ".listAll", cri);
	}
	// 일인분주문 list
	public List<StoreVO> listOneOrder(Criteria cri) {
		return sql.selectList(ns + ".listOneOrder", cri);
	}
	// 프렌차이즈 list
	public List<StoreVO> listFranchise(Criteria cri) {
		return sql.selectList(ns + ".listFranchise", cri);
	}
	// 치킨 list
	public List<StoreVO> listChicken(Criteria cri) {
		return sql.selectList(ns + ".listChicken", cri);
	}
	// 양식 list
	public List<StoreVO> listYangsik(Criteria cri) {
		return sql.selectList(ns + ".listYangsik", cri);
	}
	// 중식 list
	public List<StoreVO> listChina(Criteria cri) {
		return sql.selectList(ns + ".listChina", cri);
	}
	// 한식 list
	public List<StoreVO> listKorea(Criteria cri) {
		return sql.selectList(ns + ".listKorea", cri);
	}
	// 일식 list
	public List<StoreVO> listJapan(Criteria cri) {
		return sql.selectList(ns + ".listJapan", cri);
	}
	// 족발 list
	public List<StoreVO> listJokbal(Criteria cri) {
		return sql.selectList(ns + ".listJokbal", cri);
	}
	// 야식 list
	public List<StoreVO> listYasik(Criteria cri) {
		return sql.selectList(ns + ".listYasik", cri);
	}
	// 분식 list
	public List<StoreVO> listBoonsik(Criteria cri) {
		return sql.selectList(ns + ".listBoonsik", cri);
	}
	// 디저트 list
	public List<StoreVO> listDesert(Criteria cri) {
		return sql.selectList(ns + ".listDesert", cri);
	}
	// 편의점 list
	public List<StoreVO> listMart(Criteria cri) {
		return sql.selectList(ns + ".listMart", cri);
	}
	
	
	
	
	// 전체보기 list
	public List<StoreVO> listAllReviewSort(Criteria cri) {	
		return sql.selectList(ns + ".listAllReviewSort", cri);
	}
	// 일인분주문 list
	public List<StoreVO> listOneOrderReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listOneOrderReviewSort", cri);
	}
	// 프렌차이즈 list
	public List<StoreVO> listFranchiseReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listFranchiseReviewSort", cri);
	}
	// 치킨 list
	public List<StoreVO> listChickenReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listChickenReviewSort", cri);
	}
	// 양식 list
	public List<StoreVO> listYangsikReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listYangsikReviewSort", cri);
	}
	// 중식 list
	public List<StoreVO> listChinaReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listChinaReviewSort", cri);
	}
	// 한식 list
	public List<StoreVO> listKoreaReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listKoreaReviewSort", cri);
	}
	// 일식 list
	public List<StoreVO> listJapanReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listJapanReviewSort", cri);
	}
	// 족발 list
	public List<StoreVO> listJokbalReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listJokbalReviewSort", cri);
	}
	// 야식 list
	public List<StoreVO> listYasikReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listYasikReviewSort", cri);
	}
	// 분식 list
	public List<StoreVO> listBoonsikReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listBoonsikReviewSort", cri);
	}
	// 디저트 list
	public List<StoreVO> listDesertReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listDesertReviewSort", cri);
	}
	// 편의점 list
	public List<StoreVO> listMartReviewSort(Criteria cri) {
		return sql.selectList(ns + ".listMartReviewSort", cri);
	}
	
	
	// 전체보기 list
	public List<StoreVO> listAllStarSort(Criteria cri) {	
		return sql.selectList(ns + ".listAllStarSort", cri);
	}
	// 일인분주문 list
	public List<StoreVO> listOneOrderStarSort(Criteria cri) {
		return sql.selectList(ns + ".listOneOrderStarSort", cri);
	}
	// 프렌차이즈 list
	public List<StoreVO> listFranchiseStarSort(Criteria cri) {
		return sql.selectList(ns + ".listFranchiseStarSort", cri);
	}
	// 치킨 list
	public List<StoreVO> listChickenStarSort(Criteria cri) {
		return sql.selectList(ns + ".listChickenStarSort", cri);
	}
	// 양식 list
	public List<StoreVO> listYangsikStarSort(Criteria cri) {
		return sql.selectList(ns + ".listYangsikStarSort", cri);
	}
	// 중식 list
	public List<StoreVO> listChinaStarSort(Criteria cri) {
		return sql.selectList(ns + ".listChinaStarSort", cri);
	}
	// 한식 list
	public List<StoreVO> listKoreaStarSort(Criteria cri) {
		return sql.selectList(ns + ".listKoreaStarSort", cri);
	}
	// 일식 list
	public List<StoreVO> listJapanStarSort(Criteria cri) {
		return sql.selectList(ns + ".listJapanStarSort", cri);
	}
	// 족발 list
	public List<StoreVO> listJokbalStarSort(Criteria cri) {
		return sql.selectList(ns + ".listJokbalStarSort", cri);
	}
	// 야식 list
	public List<StoreVO> listYasikStarSort(Criteria cri) {
		return sql.selectList(ns + ".listYasikStarSort", cri);
	}
	// 분식 list
	public List<StoreVO> listBoonsikStarSort(Criteria cri) {
		return sql.selectList(ns + ".listBoonsikStarSort", cri);
	}
	// 디저트 list
	public List<StoreVO> listDesertStarSort(Criteria cri) {
		return sql.selectList(ns + ".listDesertStarSort", cri);
	}
	// 편의점 list
	public List<StoreVO> listMartStarSort(Criteria cri) {
		return sql.selectList(ns + ".listMartStarSort", cri);
	}
	/* 검색 리스트 */
	public List<StoreVO> getSearchList(Criteria cri) {
		return sql.selectList(ns + ".getSearchList", cri);
	}
	/* 검색 리스트 */
	public List<StoreVO> getStarList(Criteria cri) {
		return sql.selectList(ns + ".getStarList", cri);
	}
	/* 검색 리스트 */
	public List<StoreVO> getReviewList(Criteria cri) {
		return sql.selectList(ns + ".getSearchList", cri);
	}

}
