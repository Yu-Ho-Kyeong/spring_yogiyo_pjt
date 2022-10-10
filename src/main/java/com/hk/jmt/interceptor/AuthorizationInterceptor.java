package com.hk.jmt.interceptor;


import javax.servlet.http.*;

import org.springframework.security.core.*;
import org.springframework.security.core.context.*;
import org.springframework.web.servlet.handler.*;
import com.hk.jmt.exception.*;
import com.hk.jmt.member.Vo.MemberVO;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	// 컨트롤러를 실행하기 전
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!auth.getPrincipal().toString().equals("anonymousMember"))
			throw new IllegalAuthorizationException();
		return super.preHandle(request, response, handler);
			
	}
}
