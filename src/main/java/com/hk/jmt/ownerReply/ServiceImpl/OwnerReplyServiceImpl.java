package com.hk.jmt.ownerReply.ServiceImpl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.jmt.ownerReply.Dao.OwnerReplyDao;
import com.hk.jmt.ownerReply.Service.OwnerReplyService;
import com.hk.jmt.ownerReply.Vo.OwnerReplyVO;
@Service
public class OwnerReplyServiceImpl implements OwnerReplyService{
	
	@Autowired
	private OwnerReplyDao dao;
	
	// 사장 댓글 조회
	@Override
	public List<OwnerReplyVO> getOwnerReply(Integer storeNo) {
		return dao.getOwnerReply(storeNo);
	}
	@Override
	public int countReplyNo(Integer storeNo, Integer reviewNo) {
		return dao.countReplyNo(storeNo, reviewNo);
	}
	// 사장 댓글 달기
	@Override
	public void createReply(OwnerReplyVO reply, String ownerId) {
		reply.setOwnerReplyDate(LocalDateTime.now());
		dao.createReply(reply);
		dao.updateReplyCnt(reply);
	}
	// 사장 댓글 개수 반영
	@Override
	public int updateReplyCnt(OwnerReplyVO reply) {
		return dao.updateReplyCnt(reply);
	}
}
