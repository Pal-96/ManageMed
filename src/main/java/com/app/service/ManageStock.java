package com.app.service;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.app.dao.DAOImpl;

/**
 * Servlet implementation class ManageStock
 */
@WebServlet("/managestock")
public class ManageStock extends HttpServlet {
	
	private DAOImpl dao;
	HttpSession session;
    public ManageStock() {
        super();
        // TODO Auto-generated constructor stub
        dao = DAOImpl.getInstance();
    }

//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		session=request.getSession();
//		String action = request.getParameter("deletestock");
//		System.out.println("Action:"+action);
//		
//		if (action.equals("deletestock")) {
//			try {
//				ResultSet rs = dao.deletestock(action);
//				if (rs.next()) {
//					session.setAttribute("deletestock", action);
//					response.sendRedirect("DisplayAll.jsp");
//				}
//			} catch (SQLException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
//		
//	}

}
