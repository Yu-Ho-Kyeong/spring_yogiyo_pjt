package com.hk.jmt.member.Service;

import com.hk.jmt.member.Vo.MemberVO;

public interface MemberService {
	
	// 회원 ID 중복체크
	public int idCheck(String memberId) throws Exception;
	// 회원 닉네임 중복 체크
	public int nameCheck(String memberName) throws Exception;
	// 회원 비밀번호 체크
	public boolean memberPwdCheck(String memberId, String memberPwd) throws Exception;
	// 회원 ID 찾기
	public String memberFindId(String memberName, String memberMail) throws Exception;
	// 회원 비밀번호 찾기
	public String memberFindPwd(String memberId, String memberMail) throws Exception;
	// 회원 비밀변호 변경
	public int memberChangePwd(String memberId, String memberPwd) throws Exception;
	// 회원 내 정보 보기
	public MemberVO memberMyPage(String memberId) throws Exception;
	// 회원 닉네임 변경
	public int memberUpdateName(String memberId, String memberName) throws Exception;
	// 회원 닉네임 변경
	public int memberUpdateAddr(String memberAddress, String memberId) throws Exception;
	// 회원 비밀번호 변경
	public int memberUpdatePwd(String memberPwd, String newPwd, String memberId) throws Exception;
	// 회원 정보 변경
	public int memberUpdate(MemberVO member) throws Exception;
	// 회원 탈퇴
	public void memberDelete(String memberId) throws Exception;
	// 회원 탈퇴
	public void authDelete(String memberId) throws Exception;
	// id로 회원 정보 찾기
	public MemberVO findMember(String memberId) throws Exception;
}