package com.app.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class JWTFilter implements Filter {
	private boolean isFirstTime = true;
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
	   


		String token = null;
		Cookie[] cookies = httpRequest.getCookies();

		if (cookies != null) {
			System.out.println(cookies);
			for (Cookie cookie : cookies) {
				if ("token".equals(cookie.getName())) {
					token = cookie.getValue();
					System.out.println(token);
				}
			}

			if (token != null) {
				chain.doFilter(request, response);

			} else if (token == null && isFirstTime) {
				System.out.println("Inside FirstTime");
				chain.doFilter(request, response);
				isFirstTime=false;
				
			}
			else if (token==null && !isFirstTime) {
				System.out.println("Inside Subsequent times");
				httpResponse.sendRedirect("Login.jsp");
				
			}

		}
	}
}

	

//    public void init(FilterConfig filterConfig) throws ServletException {}
//
//    public void destroy() {}

