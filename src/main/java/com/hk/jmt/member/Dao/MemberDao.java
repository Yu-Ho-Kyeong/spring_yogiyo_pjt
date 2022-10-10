package com.hk.jmt.member.Dao;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import com.hk.jmt.common.Dao.AbstractDAO;
import com.hk.jmt.member.Vo.MemberVO;

@Repository
public class MemberDao extends AbstractDAO{
	
	@Autowired
	private SqlSessionTemplate sql;
	
	private String ns = "memberSql";
	
	// 회원 ID 중복체크
	public int idCheck(String memberId) {
		return sql.selectOne(ns + ".idCheck", memberId);
	} 
	// 회원 닉네임 중복 체크
	public int nameCheck(String memberName) {
		return sql.selectOne(ns + ".nameCheck", memberName);
	}
	// 회원 비밀번호 체크(id와 일치하는지)
	public Optional<String> memberPwdCheck(String memberId) {
		return sql.selectOne(ns + "memberPwdCheck", memberId);	
	}
	// 회원 ID 찾기
	public String memberFindId(String memberName, String memberMail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberName", memberName);
		params.put("memberMail", memberMail);
		return sql.selectOne(ns + ".memberFindId", params);
	}
	// 회원 PWD 찾기
	public String memberFindPwd(String memberId, String memberMail) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberMail", memberMail);
		return sql.selectOne(ns + ".memberFindPwd", params);
	}
	// 회원 id로 비밀번호 확인 (myPage)
	public String findPwdById(String memberId) {
		return sql.selectOne(ns + ".findPwdById", memberId);
	}
	// 회원 비밀변호 변경(myPage)
	public int memberChangePwd(String memberId, String memberPwd) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberPwd", memberPwd);
		return sql.update(ns + ".memberChangePwd", params);
	}
	// 회원 정보 조회(myPage)
	public MemberVO memberMyPage(String memberId) {
		MemberVO myPage = sql.selectOne(ns + ".memberMyPage", memberId);
		return myPage;	
	}
	// 회원정보 - 닉네임 변경(myPage)
	public int memberUpdateName(String memberId, String memberName) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("memberName", memberName);
		return sql.update(ns + ".memberUpdateName", params);
	}
	// 회원 정보 = 주소 변경(myPage)
	public int memberUpdateAddr(String memberAddress, String memberId) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberAddress", memberAddress);
		params.put("memberId", memberId);
		return sql.update(ns + ".memberUpdateAddr", params);
	}
	// 회원 정보 변경하기(myPage)
	public int memberUpdate(MemberVO member) {
		return sql.update(ns + ".memberUpdate", member);
	}
	// 회원 탈퇴하기(myPage)
	public void memberDelete(String memberId) {
		sql.delete(ns + ".memberDelete", memberId);
	}
	// 회원 탈퇴하기(myPage)
	public void authDelete(String memberId) {
		sql.delete(ns + ".authDelete", memberId);
	}
	// id로 회원 정보 찾기
	public MemberVO findMember(String memberId) {
		return sql.selectOne(ns + ".findMember", memberId);
	}
	
}
