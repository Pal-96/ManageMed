package com.app.service;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Login")
public class Login extends HttpServlet {

	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
//		String username=request.getParameter("username");
//		String password=request.getParameter("password");
//
//		HttpSession session=request.getSession();
//		
//		session.setAttribute("username", username);
//		session.setAttribute("password", password);
//		
		response.sendRedirect("Home.jsp");
		
		
		
	}
}
