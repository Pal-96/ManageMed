package com.app.service;

import java.awt.Window;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.dao.DAOImpl;
import com.app.security.JWTUtil;

/**
 * Servlet implementation class PaymentStatus
 */
@WebServlet("/checkpaymentstatus")
public class PaymentStatus extends HttpServlet {
	private DAOImpl dao;
	String token = null;
	String username = null;
	private int payment_id;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		dao = DAOImpl.getInstance();
		token = test.getCookie(request);
		username = JWTUtil.getUsername(token);
		try {
			payment_id = dao.getPaymentStatus(username);
			if (payment_id>0) {
				dao.setPaymentStatus("FAILED", payment_id);
				//response.sendRedirect("PaymentError.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
