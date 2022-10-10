package com.hk.jmt.review.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.review.Vo.ReviewVO;
import com.hk.jmt.util.Criteria;

@Repository
public class ReviewDao {
	
	@Autowired
	private SqlSessionTemplate sql;
	private String ns = "reviewSql";
	
	// 리뷰 등록
	public void createReview(ReviewVO review){
		sql.selectOne(ns + ".createReview", review);
	}
	// 리뷰 리스트 가져오기
	public List<ReviewVO> getReviewList(Criteria cri, Integer storeNo, String memberId){
		Map<String, Object> params = new HashMap<>();
		params.put("cri", cri);
		params.put("rowStart", cri.getRowStart());
		params.put("rowEnd", cri.getRowEnd());
		params.put("storeNo", storeNo);
		params.put("memberId", memberId);
		return sql.selectList(ns + ".getReviewList", params);
	}
	// 리뷰리스트 가져오기(회원 리뷰 모아보기)
	public List<ReviewVO> getMemberReview(Criteria cri, String memberId){
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("rowStart", cri.getRowStart());
		params.put("rowEnd", cri.getRowEnd());
		return sql.selectList(ns + ".getMemberReview", params);
	}
	// 리뷰  업데이트
	public void updateReview(ReviewVO review) {
		sql.update(ns + ".updateReview", review);
	}
	// 리뷰 등록시 스토어 테이블의 reviewCnt 업데이트
	public void updateReviewCnt(ReviewVO review) {
		sql.update(ns + ".updateReviewCnt", review);
	}
	// 리뷰 중복등록 방지
	public void updateReviewEnabled(ReviewVO review) {
		sql.update(ns + ".updateReviewEnabled", review);
	}
	// 리뷰 삭제
	public void deleteReview(Integer reviewNo) {
		sql.delete(ns + ".deleteReview", reviewNo);
	}
	
	// 리뷰 count
	public int countReview(Integer storeNo) {
		return sql.selectOne(ns + ".countReview", storeNo);
	}
	public int countMemberReview(Integer storeNo, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("storeNo", storeNo);
		params.put("memberId", memberId);
		return sql.selectOne(ns + ".countMemberReview", params);
	}
	// 맛 별점 평균
	public Double avgMatPoint(Integer storeNo) {
		return sql.selectOne(ns + ".avgMatPoint", storeNo);
	}
	// 맛 별점 평균
	public Double avgYangPoint(Integer storeNo) {
		return sql.selectOne(ns + ".avgYangPoint", storeNo);
	}
	// 맛 별점 평균
	public Double avgBaedalPoint(Integer storeNo) {
		return sql.selectOne(ns + ".avgBaedalPoint", storeNo);
	}
	// 리뷰 전체 별점 평균
	public Double avgStarPoint(Integer storeNo) {
		return sql.selectOne(ns + ".avgStarPoint", storeNo);
	}
}
