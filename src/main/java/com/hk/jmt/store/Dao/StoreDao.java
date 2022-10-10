package com.hk.jmt.store.Dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.store.Vo.StoreVO;

@Repository
public class StoreDao extends AbstractDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	String ns = "storeSql";
	
	// 가게 상세보기
	public List<StoreVO> getStoreDetail(Integer storeNo){
		return sql.selectList(ns + ".getStoreDetail", storeNo);
	}
	// 가게 등록
	public int createStore(StoreVO store) {
		return sql.insert(ns + ".createStore", store);
	}
	// 가게 정보 업데이트(가게 등록용)
	public int updateStore(StoreVO store) {
		return sql.update(ns + ".updateStore", store);
	}
	// 가게 삭제
	public int deleteStore(Integer storeNo) {
		return sql.delete(ns + ".deleteStore", storeNo);
	}
	// 가게번호로 onwer 찾기
	public Object findOwnerById(Integer storeNo) {
		return sql.selectList(ns + ".findOwnerById", storeNo);
	} 
	// 리뷰 개수 반영
	public int updateReviewCnt(Integer storeNo) {
		return sql.update(ns + ".updateReviewCnt", storeNo);
	}
	// 메뉴 개수 반영
	public int updateMenuCnt(Integer storeNo) {
		return sql.update(ns + ".updateMenuCnt", storeNo);
	}
	// 댓글 개수 반영
	public int updateReplyCnt(Integer storeNo) {
		return sql.update(ns + ".updateReplyCnt", storeNo);
	}
	// 가게 total 평균 별점 반영
	public double avgStorePoint(Integer storeNo) {
		return sql.update(ns + ".avgStorePoint", storeNo);
	}
}
