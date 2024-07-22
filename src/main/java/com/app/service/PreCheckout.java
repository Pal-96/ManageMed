//package com.app.service;
//
//import java.io.IOException;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.app.dao.DAOImpl;
//import com.app.security.JWTUtil;
//
///**
// * Servlet implementation class PreCheckout
// */
//@WebServlet("/PreCheckout")
//public class PreCheckout extends HttpServlet {
//	
//	private ResultSet rs;
//	private DAOImpl dao;
//	private String username = null;
//	private String token = null;
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		token = test.getCookie(request);
//		username = JWTUtil.getUsername(token);
//		dao = DAOImpl.getInstance();
//		try {
//			dao.reserveCart(username);
//			rs = dao.checkAvail(username);
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}
//
//}
