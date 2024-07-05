package com.app.service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.app.model.User;
import com.app.security.PasswordUtil;
import com.app.dao.DAOImpl;
import com.app.model.Person;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class Register extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String result = null;
		HttpSession session = request.getSession();
		String frstname = request.getParameter("frstname");
		String lastname = request.getParameter("lastname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Instantiate Person and User
		Person person = new Person();
		User user = new User();
		person.setFrstname(frstname);
		person.setLastname(lastname);
		user.setUsername(username);
		user.setPassword(PasswordUtil.hashPwd(password));
		person.setUser(user);

		DAOImpl dao = DAOImpl.getInstance();

		try {
			result = dao.Connection();
			if (result.equals("Connection Established")) {
				result = dao.Register(person);
				if (result.equals("User Registered")) {
					response.sendRedirect("Login.jsp");
				} else {
					session.setAttribute("signuperror", true);

				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
