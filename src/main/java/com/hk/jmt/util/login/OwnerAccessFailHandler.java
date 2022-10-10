package com.hk.jmt.util.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Service;
@Service("ownerAccessFailHandler")
public class OwnerAccessFailHandler implements AccessDeniedHandler {
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			org.springframework.security.access.AccessDeniedException accessDeniedException)
			throws IOException, ServletException {
		
		if(accessDeniedException instanceof AccessDeniedException) {
			request.setAttribute("LoginFailMessage", "접근 권한이 없는 계정입니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/owner/ownerLogin");
		dispatcher.forward(request, response);
	}
}