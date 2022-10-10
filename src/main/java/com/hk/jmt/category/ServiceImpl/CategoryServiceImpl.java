package com.hk.jmt.category.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.hk.jmt.category.Dao.CategoryDao;
import com.hk.jmt.category.Service.CategoryService;
import com.hk.jmt.main.Vo.mainCategoryVo;
import com.hk.jmt.store.Vo.StoreVO;
import com.hk.jmt.util.Criteria;

@Service
public class CategoryServiceImpl implements CategoryService{
	
	@Autowired
	private CategoryDao dao;
	@Value("#{config['upload.sajin.path']}")
	private String sajinFolder;
	@Value("#{config['download.sajin.uri']}")
	private String sajinPath;
	@Value("#{config['upload.menu.path']}")
	private String menuFolder;
	@Value("#{config['download.menu.uri']}")
	private String menuPath;
	
	@Override
	public List<mainCategoryVo> getCategoryMenu() {
		return dao.getCategoryMenu();
	}
	// 전체보기 count
	public int countAll(Criteria cri) throws Exception {
		return dao.countAll(cri);
	}
	// 1인분 count
	public int countOneOrder(String categoryId) throws Exception {
		return dao.countOneOrder(categoryId);
	}
	// 프렌차이즈 count
	public int countFranchise(String categoryId) throws Exception {
		return dao.countFranchise(categoryId);
	}
	// 치킨 count
	public int countChicken(String categoryId) throws Exception {
		return dao.countChicken(categoryId);
	}
	// 양식 count
	public int countYangsik(String categoryId) throws Exception {
		return dao.countYangsik(categoryId);
	}
	// 중식 count
	public int countChina(String categoryId) throws Exception {
		return dao.countChina(categoryId);
	}
	// 한식 count
	public int countKorea(String categoryId) throws Exception {
		return dao.countKorea(categoryId);
	}
	// 일식 count
	public int countJapan(String categoryId) throws Exception {
		return dao.countJapan(categoryId);
	}
	// 족발 count
	public int countJokbal(String categoryId) throws Exception {
		return dao.countJokbal(categoryId);
	}
	// 야식 count
	public int countYasik(String categoryId) throws Exception {
		return dao.countYasik(categoryId);
	}
	// 분식 count
	public int countBoonsik(String categoryId) throws Exception {
		return dao.countBoonsik(categoryId);
	}		
	// 디저트 count
	public int countDesert(String categoryId) throws Exception {
		return dao.countDesert(categoryId);
	}	
	// 편의점 count
	public int countMart(String categoryId) throws Exception {
		return dao.countMart(categoryId);
	}
	/*게시물 총 개수(검색용)*/
	public int getTotal(Criteria cri) throws Exception {
		return dao.getTotal(cri);
	}
	
	// 전체보기 리스트
	@Override
	public List<StoreVO> listAll(Criteria cri) throws Exception {
		return dao.listAll(cri);
	}
	// 1인분주문 리스트
	@Override
	public List<StoreVO> listOneOrder(Criteria cri) throws Exception {
		return dao.listOneOrder(cri);
	}
	// 프렌차이즈 리스트
	@Override
	public List<StoreVO> listFranchise(Criteria cri) throws Exception {
		return dao.listFranchise(cri);
	}
	// 치킨 리스트
	@Override
	public List<StoreVO> listChicken(Criteria cri) throws Exception {
		return dao.listChicken(cri);
	}
	// 양식 리스트
	@Override
	public List<StoreVO> listYangsik(Criteria cri) throws Exception {
		return dao.listYangsik(cri);
	}
	// 중식 리스트
	@Override
	public List<StoreVO> listChina(Criteria cri) throws Exception {
		return dao.listChina(cri);
	}
	// 한식 리스트
	@Override
	public List<StoreVO> listKorea(Criteria cri) throws Exception {
		return dao.listKorea(cri);
	}
	// 일식 리스트
	@Override
	public List<StoreVO> listJapan(Criteria cri) throws Exception {
		return dao.listJapan(cri);
	}
	// 족발 리스트
	@Override
	public List<StoreVO> listJokbal(Criteria cri) throws Exception {
		return dao.listJokbal(cri);
	}
	// 야식 리스트
	@Override
	public List<StoreVO> listYasik(Criteria cri) throws Exception {
		return dao.listYasik(cri);
	}
	// 분식 리스트
	@Override
	public List<StoreVO> listBoonsik(Criteria cri) throws Exception {
		return dao.listBoonsik(cri);
	}
	// 디저트 리스트
	@Override
	public List<StoreVO> listDesert(Criteria cri) throws Exception {
		return dao.listDesert(cri);
	}
	// 편의점 리스트
	@Override
	public List<StoreVO> listMart(Criteria cri) throws Exception {
		return dao.listMart(cri);
	}
	
	
	
	
	// 전체보기 리스트
	@Override
	public List<StoreVO> listAllReviewSort(Criteria cri) throws Exception {
		return dao.listAllReviewSort(cri);
	}
	// 1인분주문 리스트
	@Override
	public List<StoreVO> listOneOrderReviewSort(Criteria cri) throws Exception {
		return dao.listOneOrderReviewSort(cri);
	}
	// 프렌차이즈 리스트
	@Override
	public List<StoreVO> listFranchiseReviewSort(Criteria cri) throws Exception {
		return dao.listFranchiseReviewSort(cri);
	}
	// 치킨 리스트
	@Override
	public List<StoreVO> listChickenReviewSort(Criteria cri) throws Exception {
		return dao.listChickenReviewSort(cri);
	}
	// 양식 리스트
	@Override
	public List<StoreVO> listYangsikReviewSort(Criteria cri) throws Exception {
		return dao.listYangsikReviewSort(cri);
	}
	// 중식 리스트
	@Override
	public List<StoreVO> listChinaReviewSort(Criteria cri) throws Exception {
		return dao.listChinaReviewSort(cri);
	}
	// 한식 리스트
	@Override
	public List<StoreVO> listKoreaReviewSort(Criteria cri) throws Exception {
		return dao.listKoreaReviewSort(cri);
	}
	// 일식 리스트
	@Override
	public List<StoreVO> listJapanReviewSort(Criteria cri) throws Exception {
		return dao.listJapanReviewSort(cri);
	}
	// 족발 리스트
	@Override
	public List<StoreVO> listJokbalReviewSort(Criteria cri) throws Exception {
		return dao.listJokbalReviewSort(cri);
	}
	// 야식 리스트
	@Override
	public List<StoreVO> listYasikReviewSort(Criteria cri) throws Exception {
		return dao.listYasikReviewSort(cri);
	}
	// 분식 리스트
	@Override
	public List<StoreVO> listBoonsikReviewSort(Criteria cri) throws Exception {
		return dao.listBoonsikReviewSort(cri);
	}
	// 디저트 리스트
	@Override
	public List<StoreVO> listDesertReviewSort(Criteria cri) throws Exception {
		return dao.listDesertReviewSort(cri);
	}
	// 편의점 리스트
	@Override
	public List<StoreVO> listMartReviewSort(Criteria cri) throws Exception {
		return dao.listMartReviewSort(cri);
	}
	
	
	
	// 전체보기 리스트
	@Override
	public List<StoreVO> listAllStarSort(Criteria cri) throws Exception {
		return dao.listAllStarSort(cri);
	}
	// 1인분주문 리스트
	@Override
	public List<StoreVO> listOneOrderStarSort(Criteria cri) throws Exception {
		return dao.listOneOrderStarSort(cri);
	}
	// 프렌차이즈 리스트
	@Override
	public List<StoreVO> listFranchiseStarSort(Criteria cri) throws Exception {
		return dao.listFranchiseStarSort(cri);
	}
	// 치킨 리스트
	@Override
	public List<StoreVO> listChickenStarSort(Criteria cri) throws Exception {
		return dao.listChickenStarSort(cri);
	}
	// 양식 리스트
	@Override
	public List<StoreVO> listYangsikStarSort(Criteria cri) throws Exception {
		return dao.listYangsikStarSort(cri);
	}
	// 중식 리스트
	@Override
	public List<StoreVO> listChinaStarSort(Criteria cri) throws Exception {
		return dao.listChinaStarSort(cri);
	}
	// 한식 리스트
	@Override
	public List<StoreVO> listKoreaStarSort(Criteria cri) throws Exception {
		return dao.listKoreaStarSort(cri);
	}
	// 일식 리스트
	@Override
	public List<StoreVO> listJapanStarSort(Criteria cri) throws Exception {
		return dao.listJapanStarSort(cri);
	}
	// 족발 리스트
	@Override
	public List<StoreVO> listJokbalStarSort(Criteria cri) throws Exception {
		return dao.listJokbalStarSort(cri);
	}
	// 야식 리스트
	@Override
	public List<StoreVO> listYasikStarSort(Criteria cri) throws Exception {
		return dao.listYasikStarSort(cri);
	}
	// 분식 리스트
	@Override
	public List<StoreVO> listBoonsikStarSort(Criteria cri) throws Exception {
		return dao.listBoonsikStarSort(cri);
	}
	// 디저트 리스트
	@Override
	public List<StoreVO> listDesertStarSort(Criteria cri) throws Exception {
		return dao.listDesertStarSort(cri);
	}
	// 편의점 리스트
	@Override
	public List<StoreVO> listMartStarSort(Criteria cri) throws Exception {
		return dao.listMartStarSort(cri);
	}
	/* 검색 리스트 */
	@Override
	public List<StoreVO> getSearchList(Criteria cri) throws Exception {
		return dao.getSearchList(cri);
	}
	/* 검색 리스트 */
	@Override
	public List<StoreVO> getStarList(Criteria cri) throws Exception {
		return dao.getStarList(cri);
	}
	/* 검색 리스트 */
	@Override
	public List<StoreVO> getReviewList(Criteria cri) throws Exception {
		return dao.getReviewList(cri);
	}

}
