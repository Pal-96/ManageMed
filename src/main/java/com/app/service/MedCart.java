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
import com.app.security.JWTUtil;

/**
 * Servlet implementation class MedCart
 */
@WebServlet("/addtocart")
public class MedCart extends HttpServlet {
	private int quantity;
	private String product;
	private int result;
	HttpSession session;
	private String token;
	private String username; 
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("Inside MedCart");
		System.out.println("Inside Med Cart Product:"+request.getParameter("product"));
		System.out.println("Added?:"+request.getParameter("addtocart"));
		if(request.getParameter("addtocart")!=null && (!request.getParameter("cartquan").isEmpty()))
		{
			System.out.println("Med added:"+request.getParameter("product"));
			product=request.getParameter("product");
			quantity=Integer.parseInt(request.getParameter("cartquan"));
			token = test.getCookie(request);
			username = JWTUtil.getUsername(token);
			System.out.println("Inside Med Cart logged in by:"+username);
			DAOImpl dao=DAOImpl.getInstance();
			try {
				result=dao.addcart(product, quantity, username);
				System.out.println("no stock:"+ result);
				if(result>0)
				{
					int cartcount = dao.getCartCount(username);
					
					session=request.getSession();
					session.setAttribute("med", "added");
					session.setAttribute("quan", quantity);
					session.setAttribute("cartcount", cartcount);
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
			
			response.sendRedirect("DisplayAll.jsp");
			
		}
		 
		else if(request.getParameter("addtocart")!=null 
				&& (request.getParameter("cartquan").isEmpty()))
		{
			
			
			session=request.getSession();			
			session.setAttribute("med", "not added");
			response.sendRedirect("DisplayAll.jsp");
			
		}
		
		
		else if(request.getParameter("removecart")!=null)
		{
			
			
			System.out.println("Removed Med added:"+request.getParameter("product"));
			product=request.getParameter("product");
			
			DAOImpl dao=DAOImpl.getInstance();
			try {
				result=dao.removecart(product);
				System.out.println("no stock:"+ result);
				if(result>0)
				{
					int cartcount = dao.getCartCount(username);
					session=request.getSession();
					session.setAttribute("med", "removed");
					session.setAttribute("cartcount", cartcount);

					
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			response.sendRedirect("ViewCart.jsp");
			
		}
		
	}
}

