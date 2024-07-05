package com.app.service;


import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.app.dao.DAOImpl;


@WebServlet("/addrem")
public class AddRemoveImpl extends HttpServlet {
	private String product;
	private String action;
	private int quantity;
	private int count;
	private int unitprice;
	HttpSession session;
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		session=request.getSession();
		
		product=request.getParameter("product");
		quantity=Integer.parseInt(request.getParameter("quantity"));
		unitprice = Integer.parseInt(request.getParameter("unitprice"));
		action=request.getParameter("action");
		
		DAOImpl dao=DAOImpl.getInstance();
		try {
			session.setAttribute("action", action);
			if(action.equals("add") && quantity>0)
			{
			count=dao.insert(product, quantity, unitprice);
			System.out.println("Inside add");
			session.setAttribute("quantity", quantity);
			response.sendRedirect("DisplayAll.jsp");
			}
			
			else if(action.equals("remove") && quantity>0)
			{
			count=dao.remove(product, quantity);
			System.out.println(count);
			if(count==0)
			{
				quantity=(Integer) null;
			}
			session.setAttribute("quantity", quantity);
			
			response.sendRedirect("DisplayAll.jsp");
			}
			
			else if (quantity<=0) {
				System.out.println(quantity);
				session.setAttribute("quantity", quantity);
				response.sendRedirect("DisplayAll.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
