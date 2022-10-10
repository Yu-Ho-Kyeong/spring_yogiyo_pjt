package com.hk.jmt.util.login;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;

import com.hk.jmt.member.Vo.MemberVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service("ownerLoginSuccessHandler")
public class OwnerLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	private RequestCache cache = new HttpSessionRequestCache();
	// 리다이렉트 처리를 담당할 객체
	private RedirectStrategy s = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		String ownerId = request.getParameter("ownerId");
		session.setAttribute("ownerId", ownerId);
		
		log.info("ownerId : " + ownerId);
		log.warn("login success");

		SavedRequest savedRequest = cache.getRequest(request, response);
		if(savedRequest != null) {
			s.sendRedirect(request, response, savedRequest.getRedirectUrl());
		}else {
			s.sendRedirect(request, response, "/");
		}
		
	}
}