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
import com.app.model.Product;

@WebServlet("/addrem")
public class AddRemoveImpl extends HttpServlet {
	private String productTitle;
	private String action;
	private int quantity;
	private int count;
	private int unitprice;
	private String description;
	HttpSession session;
	private Product product;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		session = request.getSession();

		productTitle = request.getParameter("product");
		if (request.getParameter("quantity") != null && request.getParameter("unitprice") != null
				&& request.getParameter("description") != null) {
			quantity = Integer.parseInt(request.getParameter("quantity"));
			unitprice = Integer.parseInt(request.getParameter("unitprice"));
			description = request.getParameter("description");
		}
		action = request.getParameter("action");
		System.out.println("Action | Quantity: "+ action + " |"+ quantity);

		DAOImpl dao = DAOImpl.getInstance();
		try {
			session.setAttribute("action", action);
			if (action.equals("add") && quantity > 0) {
				product = new Product();
				product.setProduct(productTitle);
				product.setQuantity(quantity);
				product.setUnitprice(unitprice);
				product.setDescription(description);
				count = dao.insert(product);
				System.out.println("Inside add");
				session.setAttribute("quantity", quantity);
				response.setContentType("text/html");
                response.getWriter().write("<script>window.parent.loadContent('DisplayAll.jsp');</script>");
//				response.sendRedirect("DisplayAll.jsp");
			}

			else if (action.equals("edit") && quantity > 0) {
				
				System.out.println("Inside updated RemoveImpl");
				System.out.println("Product being updated:"+ productTitle);
				count = dao.update(productTitle, quantity, unitprice, description);
				response.sendRedirect("DisplayAll.jsp");
			}

			else if (action.equals("remove") && quantity > 0) {
				count = dao.remove(productTitle, quantity);
				System.out.println(count);
				if (count == 0) {
					quantity = (Integer) null;
				}
				session.setAttribute("quantity", quantity);

				response.sendRedirect("DisplayAll.jsp");
			}

			else if (action.equals("deletestock")) {
				System.out.println("Inside delete stock");
				count = dao.deletestock(productTitle);
				session.setAttribute("deletestock", action);
				response.sendRedirect("DisplayAll.jsp");
			}

			else if (quantity <= 0) {
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
