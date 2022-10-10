package com.hk.jmt.security.Service;

import java.util.ArrayList;
import java.util.List;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hk.jmt.security.Dao.OwnerAuthorityDao;
import com.hk.jmt.security.Vo.MemberDetailsVO;
import com.hk.jmt.security.Vo.OwnerDetailsVO;

@Service("ownerLoginService")
public class OwnerLoginService implements UserDetailsService {
	
	@Autowired
	private OwnerAuthorityDao dao;
	@Autowired
	private BCryptPasswordEncoder bPasswordEncoder;
	private Logger log = Logger.getLogger(this.getClass());
	
	// owner 로그인시 loadUserByUsername
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		List<String> authList = new ArrayList<String>();	
		OwnerDetailsVO detailsVo = dao.findOwner(username);
		authList = dao.findAuth(username);
		
		if (detailsVo == null) { //User을 찾지 못했을 경우
			throw new UsernameNotFoundException(username);
		}
		else {
			detailsVo.setAuthority(authList);
		}
		
		return detailsVo; //완전한 UserDetails 객체
	}
	// owner 회원가입시 insert
	public boolean insert(String username, String password, String ownerName, String ownerMail) {
		OwnerDetailsVO detailsVo = dao.findOwner(username);
		if (detailsVo != null) {
			return false;
		}else {
			dao.insertOwner(username, bPasswordEncoder.encode(password), ownerName, ownerMail, '1'); //오너 등록
			dao.insertAuth(username, "ROLE_OWNER"); //기본 권한 부여
			return true;
		}
	}
	
}