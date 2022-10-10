package com.hk.jmt.security.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jboss.logging.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hk.jmt.member.Vo.MemberAuthVO;
import com.hk.jmt.member.Vo.MemberVO;
import com.hk.jmt.security.Dao.MemberAuthorityDao;
import com.hk.jmt.security.Vo.MemberDetailsVO;

@Service("memberLoginService")
public class MemberLoginService implements UserDetailsService {

	@Autowired
	private MemberAuthorityDao dao;

	@Autowired
	private BCryptPasswordEncoder bPasswordEncoder;
	private Logger log = Logger.getLogger(this.getClass());

	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		List<String> authList = new ArrayList<String>();	
		MemberDetailsVO detailsVo = dao.findMember(username);
		authList = dao.findAuth(username);
		
		if (detailsVo == null) { //User을 찾지 못했을 경우
			throw new UsernameNotFoundException(username);
		}
		else {
			detailsVo.setAuthority(authList);
		}
		
		return detailsVo; //완전한 UserDetails 객체
	}
	
	public boolean insert(String username, String password, String memberName, String memberAddress, String memberPhoneNo, String memberMail) {
		MemberDetailsVO detailsVo = dao.findMember(username);
		if (detailsVo != null) {
			return false;
		}else {
			dao.insertMember(username, bPasswordEncoder.encode(password), memberName, memberAddress, memberPhoneNo, memberMail,  '1'); //유저 등록
			dao.insertAuthority(username, "ROLE_MEMBER"); //기본 권한 부여
			return true;
		}
	}
}