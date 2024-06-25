package com.app.service;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.app.dao.DAOImpl;

import java.sql.*;



@WebServlet("/test")
public class test extends HttpServlet {

	
	HttpSession session;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		
		String result=null;
		HttpSession session=request.getSession();
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		
		DAOImpl dao=DAOImpl.getInstance();
		
		try {
			result = dao.Connection(username,password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		if(result.equals("Connection Established"))
		{

		
		
		session.setAttribute("username", username);
		session.setAttribute("password", password);
		
		response.sendRedirect("Home.jsp");
		}
		
		else if(result.equals("No Data"))
		{
			session.setAttribute("attempt", result);
			System.out.println(session.getAttribute("attempt"));
			response.sendRedirect("Login.jsp");
		}
		
		
	}
}
