package com.app.service;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.security.JWTUtil;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/HomeController")
public class HomeController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String token = test.getCookie(request);		

			if (token != null) {
				JWTUtil.getUsername(token);
				response.sendRedirect("Home.jsp");

			} else if (token == null) {
				response.sendRedirect("Login.jsp");
			} 

		}
	}

