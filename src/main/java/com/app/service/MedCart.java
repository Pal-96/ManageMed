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

/**
 * Servlet implementation class MedCart
 */
@WebServlet("/addtocart")
public class MedCart extends HttpServlet {
	private int quantity;
	private String product;
	private int result;
	HttpSession session;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("Inside MedCart");
		//System.out.println(Integer.parseInt(request.getParameter("cartquan")));
		if(request.getParameter("Add to Cart")!=null && (!request.getParameter("cartquan").isEmpty()))
		{
			System.out.println("Med added:"+request.getParameter("product"));
			product=request.getParameter("product");
			quantity=Integer.parseInt(request.getParameter("cartquan"));
			DAOImpl dao=DAOImpl.getInstance();
			try {
				result=dao.addcart(product, quantity);
				System.out.println("no stock:"+ result);
				if(result>0)
				{
					session=request.getSession();
					session.setAttribute("med", "added");
					session.setAttribute("quan", quantity);
				}
				
				else if(result==0||(Integer.parseInt(request.getParameter("cartquan"))<0))
				{
					session=request.getSession();
					session.setAttribute("med", "not added");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			response.sendRedirect("CustomerSale.jsp");
			
		}
		 
		else if(request.getParameter("Add to Cart")!=null 
				&& (request.getParameter("cartquan").isEmpty()))
		{
			
			
			session=request.getSession();			
			session.setAttribute("med", "not added");
			response.sendRedirect("CustomerSale.jsp");
			
		}
		
		
		else if(request.getParameter("Remove from Cart")!=null)
		{
			
			
			System.out.println("Removed Med added:"+request.getParameter("product"));
			product=request.getParameter("product");
			
			DAOImpl dao=DAOImpl.getInstance();
			try {
				result=dao.removecart(product);
				System.out.println("no stock:"+ result);
				if(result>0)
				{
					session=request.getSession();
					session.setAttribute("med", "removed");
					
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			response.sendRedirect("Bill.jsp");
			
		}
		
	}
}

