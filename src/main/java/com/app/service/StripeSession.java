package com.app.service;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.dao.DAOImpl;
import com.app.security.JWTUtil;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import java.util.Properties;
import java.sql.*;
import java.time.LocalDate;

/**
 * Servlet implementation class StripeSession
 */
@WebServlet("/create-checkout-session")
public class StripeSession extends HttpServlet {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	private Properties dbProperties;
	private String domainUrl;
	private String username = null;
	private String token = null;
	private DAOImpl dao;
	private ResultSet rs;

	public StripeSession() {
		super();
		try (InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties")) {
			dbProperties = new Properties();
			dbProperties.load(input);
		} catch (IOException ex) {
			ex.printStackTrace();
		}

		Stripe.apiKey = dbProperties.getProperty("stripe.sk");
		domainUrl = dbProperties.getProperty("domain.url");

		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			token = test.getCookie(request);
			username = JWTUtil.getUsername(token);
			LocalDate currentDate = LocalDate.now();
			dao = DAOImpl.getInstance();
			dao.reserveCart(username);
			int shippingprice = Integer.parseInt(request.getParameter("shipping"));
			rs = dao.viewcart(username);
			
			
			if (rs !=null) {
				int orderQty = dao.getCartCount(username);
				int orderPrice = dao.getCheckoutPrice(username);
				String orderStatus = "PENDING";
				dao.createOrder(username, orderQty, orderStatus, currentDate);
				dao.proceedPayment(currentDate, username);
				
			}

			SessionCreateParams.Builder paramsBuilder = SessionCreateParams.builder()
					.setMode(SessionCreateParams.Mode.PAYMENT)
					.setSuccessUrl(domainUrl + "/success.jsp")
					.setCancelUrl(domainUrl + "/cancel.jsp");
			while (rs.next()) {
				String productName = rs.getString(1);
				int quantity = rs.getInt(2);
				long productPrice = rs.getInt(3);
				long unitprice = productPrice/quantity;

				paramsBuilder.addLineItem(SessionCreateParams.LineItem.builder()
						.setQuantity((long) quantity)
						.setPriceData(SessionCreateParams.LineItem.PriceData.builder().setCurrency("usd")
								.setUnitAmount(unitprice * 100) // Amount in cents
								.setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder()
										.setName(productName).build())
								.build())
						.build());
			}
			paramsBuilder
					.addLineItem(SessionCreateParams.LineItem
							.builder().setQuantity(
									1L)
							.setPriceData(SessionCreateParams.LineItem.PriceData.builder().setCurrency("usd")
									.setUnitAmount((long) shippingprice * 100) // Amount in cents
									.setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder()
											.setName("Shipping Price").build())
									.build())
							.build());
			
			paramsBuilder.putMetadata("unavailable_items_message",
					"If you see an item missing, it means it's currently unavailable. Please go back and re-check.");
			
			SessionCreateParams params = paramsBuilder.build();
			Session session = Session.create(params);
			response.sendRedirect(session.getUrl());

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
		}

	}

}
