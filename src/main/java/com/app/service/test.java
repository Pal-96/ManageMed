package com.app.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.app.dao.DAOImpl;
import com.app.security.JWTUtil;

import java.sql.*;

@WebServlet("/test")
public class test extends HttpServlet {

	HttpSession session = null;
	private Cookie tokenCookie;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String result = null;
		ResultSet rs = null;
		String role = null;
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		session=request.getSession();

		DAOImpl dao = DAOImpl.getInstance();
		try {
			result = dao.Connection();
			if (result.equals("Connection Established"))
			{
				System.out.println(result);
				result = dao.login(username, password);
				if (result.equals("Login Succssful")) {
					System.out.println(result);
					rs = dao.getRole(username);
					if (rs.next())
						role = rs.getString(1);
					String token = JWTUtil.generateToken(username, role);
					response.setHeader("Authorization", "Bearer " + token);

					tokenCookie = new Cookie("token", token);
					tokenCookie.setHttpOnly(true);
					tokenCookie.setMaxAge(1800); // 30 minutes
					response.addCookie(tokenCookie);
					response.sendRedirect("Home.jsp");
				}
				else if (result.equals("No Data")) {
					session.setAttribute("invalidcreds", true);
					response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					response.getWriter().write("Invalid username or password");
					response.sendRedirect("Login.jsp");
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static String getCookie(HttpServletRequest request) {
		String token = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("token".equals(cookie.getName())) {
					token = cookie.getValue();

				}
			}
		}
		return token;
	}
}
