package com.hk.jmt.ownerReply.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.ownerReply.Vo.OwnerReplyVO;

@Repository
public class OwnerReplyDao extends AbstractDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	private String ns = "ownerReplySql"; 
	
	// 사장댓글 조회
	public List<OwnerReplyVO> getOwnerReply(Integer storeNo){
		return sql.selectList(ns + ".getOwnerReply", storeNo);
	}
	// 댓글번호 찾기
	public int countReplyNo(Integer storeNo, Integer reviewNo) {
		Map<String, Object> params = new HashMap<>();
		params.put("storeNo", storeNo);
		params.put("reviewNo", reviewNo);
		return sql.selectOne(ns + ".countReplyNo", params);
	}
	// 사장님 댓글 달기
	public void createReply(OwnerReplyVO reply) {
		sql.selectOne(ns + ".createReply", reply);
	}
	// 사장님 댓글 수정횟수
	public int updateReplyCnt(OwnerReplyVO reply) {
		return sql.update(ns + ".updateReplyCnt", reply);
	}
}
