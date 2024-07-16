package com.app.service;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		Cookie tokenCookie = new Cookie("token", "");
        tokenCookie.setMaxAge(0);
        response.addCookie(tokenCookie);
		 
		response.sendRedirect("Login.jsp");
		
	}
}
