package com.hk.jmt.store.Service;

import java.io.IOException;

import java.util.List;

import com.hk.jmt.store.Vo.StoreVO;

public interface StoreService {
	// 가게 상세보기
	public List<StoreVO> getStoreDetail(Integer storeNo);
	// 가게등록
	public void createStore(StoreVO store, String name)throws IllegalStateException, IOException;
	// 가게 삭제
	public int deleteStore(Integer storeNo, String ownerId);
	// 리뷰 개수 반영
	public int updateReviewCnt(Integer storeNo);
	// 메뉴 개수 반영
	public int updateMenuCnt(Integer storeNo);
	// 댓글 개수 반영
	public int updateReplyCnt(Integer storeNo);
	// 가게 전체 평균 별점 
	public double avgStorePoint(Integer storeNo);
	
//	public void deleteLogoFile(String storeLogoUrl);
}
