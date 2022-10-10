package com.hk.jmt.review.Service;

import java.io.IOException;
import java.util.List;

import com.hk.jmt.review.Vo.ReviewVO;
import com.hk.jmt.util.Criteria;

public interface ReviewService {
	
	// 리뷰 등록
	public void createReview(ReviewVO review, String name)throws IllegalStateException, IOException;
	// 리뷰 리스트 가져오기
	public List<ReviewVO> getReviewList(Criteria cri, Integer storeNo, String memberId);
	// 회원 리뷰 리스트 가져오기(회원 리뷰관리)
	public List<ReviewVO> getMemberReview(Criteria cri, String memberId);
	// 리뷰 삭제
	public void deleteReview(Integer reviewNo);
	// 리뷰 count
	public int countReview(Integer storeNo);
	// 맛 별점 평균
	public Double avgMatPoint(Integer storeNo);
	// 양 별점 평균
	public Double avgYangPoint(Integer storeNo);
	// 배달 별점 평균
	public Double avgBaedalPoint(Integer storeNo);
	// 전체 별점 평균
	public Double avgStarPoint(Integer storeNo);
}
