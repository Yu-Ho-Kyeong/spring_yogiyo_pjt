package com.hk.jmt.ownerReply.Service;

import java.util.List;

import com.hk.jmt.ownerReply.Vo.OwnerReplyVO;

public interface OwnerReplyService {
	
	// 사장댓글 조회
	public List<OwnerReplyVO> getOwnerReply(Integer storeNo);
	// 댓글번호 찾기
	public int countReplyNo(Integer storeNo, Integer reviewNo);
	// 사장님 댓글 달기
	public void createReply(OwnerReplyVO reply, String ownerId);
	// 사장님 댓글 개수 업데이트
	public int updateReplyCnt(OwnerReplyVO reply);
}
