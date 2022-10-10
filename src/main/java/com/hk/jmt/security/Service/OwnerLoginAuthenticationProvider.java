package com.hk.jmt.security.Service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hk.jmt.security.Vo.MemberDetailsVO;
import com.hk.jmt.security.Vo.OwnerDetailsVO;

@Service("owenrLoginAuthenticationProvider")
public class OwnerLoginAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	OwnerLoginService loginService;
	@Autowired
	BCryptPasswordEncoder bPasswordEncoder;
	@Autowired
	SessionRegistry sessionRegistry; 
	
public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		//DB에서 유저 레코드를 DTO객체로 가져오기
		String ownerId = authentication.getName();
		String ownerPwd = (String) authentication.getCredentials();
		OwnerDetailsVO detailsVO = (OwnerDetailsVO) loginService.loadUserByUsername(ownerId);
		
		//LoginFailHandler로 오류를 던짐
		if (detailsVO == null || !ownerId.equals(detailsVO.getUsername())
				|| !bPasswordEncoder.matches(ownerPwd, detailsVO.getPassword())) {
			throw new BadCredentialsException(ownerId); //아이디, 비밀번호 불일치
		} else if(!detailsVO.isEnabled()) {
			throw new DisabledException(ownerId); //계정 비활성화
		} else if(!detailsVO.isAccountNonLocked()) {
			throw new LockedException(ownerId); //계정 잠김
		} else if (!detailsVO.isAccountNonExpired()) {
			throw new AccountExpiredException(ownerId); //계정 만료
		} else if (!detailsVO.isCredentialsNonExpired()) {
			throw new CredentialsExpiredException(ownerId); //비밀번호 만료
		}
		
		checkLogin(sessionRegistry, authentication); // 중복로그인 체크
		
		detailsVO.setPassword(null); 
		
		return new UsernamePasswordAuthenticationToken(detailsVO, null, detailsVO.getAuthorities());
	}
	
	//반환 객체 타입 검사
	@Override
	public boolean supports(Class<?> authentication) {
		return true;
	}
	
	private void checkLogin(SessionRegistry sessionRegistry, Authentication authentication) {
		List<SessionInformation> activeSessions = new ArrayList<SessionInformation>();
		System.out.println(sessionRegistry.getAllPrincipals());
		for(final Object principal : sessionRegistry.getAllPrincipals()) {
			for(SessionInformation information : sessionRegistry.getAllSessions(principal, false)) {
				System.out.println("information : " + information.getPrincipal());
				OwnerDetailsVO detailsVo = (OwnerDetailsVO) information.getPrincipal();
				if(detailsVo.getUsername().equals(authentication.getName())) {
					information.expireNow();
				}
			}
		}
	}
}