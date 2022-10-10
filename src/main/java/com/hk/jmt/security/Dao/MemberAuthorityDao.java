package com.hk.jmt.security.Dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.member.Vo.MemberAuthVO;
import com.hk.jmt.security.Vo.MemberDetailsVO;

@Repository
public class MemberAuthorityDao extends AbstractDAO {
	@Autowired
	private SqlSessionTemplate sql;
	private Logger log = Logger.getLogger(this.getClass());
	private String ns = "authoritySql";
	
	//회원 권한 부여
	 public void insertAuthority(String username, String authorityName) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("memberId", username);
		 params.put("authorityName", authorityName);
		 sql.insert(ns + ".insertAuthority", params);
	  }
	// member info insert
	public void insertMember(String username, String password, String memberName, String memberAddress, String memberPhoneNo, String memberMail, char memberEnabled) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", username);
		params.put("memberPwd", password);
		params.put("memberName", memberName);
		params.put("memberAddress", memberAddress);
		params.put("memberPhoneNo", memberPhoneNo);
		params.put("memberMail", memberMail);
		params.put("memberEnabled", memberEnabled);
		sql.insert(ns + ".insertMember", params);
	} 
	//회원 권한 조회
	public List<String> findAuth(String username){
		log.info("회원 권한 찾기");
		List<String> findAuth = null;
		findAuth = sql.selectList(ns + ".findAuth", username); 
		return findAuth;
	}	
	// 멤버 로그인
	public MemberDetailsVO findMember(String username) {
		MemberDetailsVO detailsVo = null;
		detailsVo = sql.selectOne(ns + ".findMember", username);
		return detailsVo;	
	}
	
}