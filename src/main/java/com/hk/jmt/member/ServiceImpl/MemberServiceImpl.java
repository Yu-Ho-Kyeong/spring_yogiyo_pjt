package com.hk.jmt.member.ServiceImpl;

import org.apache.commons.lang3.RandomStringUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hk.jmt.member.Dao.MemberDao;
import com.hk.jmt.member.Service.MemberService;
import com.hk.jmt.member.Vo.MemberVO;
import com.hk.jmt.util.MailUtil;

import java.io.IOException;

import javax.mail.*;
import javax.servlet.http.HttpSession;

import com.hk.jmt.common.Vo.Mail;
import com.hk.jmt.constant.*;
import com.hk.jmt.exception.*;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao dao;
	@Autowired
	private PasswordEncoder pwdEncoder;
	@Autowired
	private MailUtil mailUtil;
	
	@Override
	public int idCheck(String memberId) throws Exception {
		int result = dao.idCheck(memberId);
		return result; 
	}
	@Override
	public int nameCheck(String memberName) throws Exception {
		int result = dao.nameCheck(memberName);
		return result;
	}
	@Override
	public boolean memberPwdCheck(String memberId, String memberPwd) throws Exception {
		String encodedPwd = dao.findPwdById(memberId);
		System.out.println("encodedPwd: " + encodedPwd);
		System.out.println("memberPwd: " + memberPwd);
		return pwdEncoder.matches(memberPwd, encodedPwd);
	}
	@Override
	public String memberFindId(String memberName, String memberMail) throws Exception {		
		String result = dao.memberFindId(memberName, memberMail);
		return result;
	}
	@Override
	public String memberFindPwd(String memberId, String memberMail) throws Exception {
		// 회원 가입여부,  검색에 실패하면 예외 처리
		String result = dao.memberFindPwd(memberId, memberMail);
		String newPwd = RandomStringUtils.randomAlphanumeric(10);
		String encodedPwd = pwdEncoder.encode(newPwd);
		
		if(result == null) {
			throw new MemberNotFoundException("가입된 정보를 찾을 수 없습니다.");
		
		}else { // 일치하는 정보가 없다면 임시비밀 번호 이메일로 발송 
			
			RandomStringUtils.randomAlphanumeric(10);
			dao.memberFindPwd(memberId, memberMail);
			dao.memberChangePwd(memberId, newPwd);
			String text = "<h2>비밀번호 재설정 안내 </h2>";
				   text += "<p>안녕하세요. 요기냐?입니다.<p>";
				   text += "<p>고객님의 요청으로 비밀번호 재설정 안내 메일을 발송했습니다.<p>";
				   text += "<p>새로운 비밀번호: " + newPwd + "</p>";
				   text += "<p>사용자 보안을 위해 로그인 후 비밀번호를 변경해주시기 바랍니다.</p>";
				   text += "로그인 하기 : <a href='http://localhost:8081/member/login></a>"; 
			Mail mail = Mail.builder().sender("kos12753@gmail.com").receiver(memberMail).title("비밀번호 재설정 안내 메일 www.yogiyo.co.kr").content(text).build();
			mailUtil.sendMail(mail);
			System.out.println("newPwd : " + newPwd);
		} 
		return memberMail;
	}
	public int memberChangePwd(String memberId, String memberPwd) throws Exception {
		return dao.memberChangePwd(memberId, pwdEncoder.encode(memberPwd));
	}
	@Override
	public MemberVO memberMyPage(String memberId) throws Exception {
		MemberVO member = dao.memberMyPage(memberId);
		System.out.println(member);
		return member;
	}	
	@Override
	public int memberUpdateName(String memberId, String memberName) throws Exception {
		return dao.memberUpdateName(memberId, memberName);
	}
	
	public int memberUpdatePwd(String memberPwd, String newPwd, String memberId) throws Exception {
		String encodedPwd = dao.findPwdById(memberId);
		if (!pwdEncoder.matches(memberPwd, encodedPwd)) {
			throw new JobFailException(JOB.PASSWORD_CHCEK_FAILURE);
		}
		dao.memberChangePwd(memberId, pwdEncoder.encode(newPwd));
		return dao.memberChangePwd(memberId, pwdEncoder.encode(newPwd));
	}
	@Override
	public int memberUpdateAddr(String memberAddress, String memberId) throws Exception {
		return dao.memberUpdateAddr(memberAddress, memberId);
	}
	@Override
	public int memberUpdate(MemberVO member) throws Exception {
		// 비번을 변경할 경우 ChagnePwd()를 호출해 처리
		if(member.getMemberPwd() != null && member.getNewPwd() != null) {
			memberChangePwd(member.getMemberPwd(), member.getNewPwd());
		}
		return dao.memberUpdate(member);
	}
	@Override
	public void memberDelete(String memberId) throws Exception {
		dao.memberDelete(memberId);
	}
	@Override
	public void authDelete(String memberId) throws Exception {
		dao.authDelete(memberId);
	}
	@Override
	public MemberVO findMember(String memberId) throws Exception {
		return dao.findMember(memberId);
	}	
	
}

