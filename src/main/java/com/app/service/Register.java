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

	private String firstname = null;
	private String lastname = null;
	private String username = null;
	private String password = null;
	private String roleName = null;
	private DAOImpl dao = null;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String result = null;
		HttpSession session = request.getSession();
		String action = request.getParameter("action");
		dao = DAOImpl.getInstance();

		if (action.equals("register")) {
			firstname = request.getParameter("firstname");
			lastname = request.getParameter("lastname");
			username = request.getParameter("username");
			password = request.getParameter("password");

			// Instantiate Person and User
			Person person = new Person();
			User user = new User();
			person.setFrstname(firstname);
			person.setLastname(lastname);
			user.setUsername(username);
			user.setPassword(PasswordUtil.hashPwd(password));
			person.setUser(user);

			try {
				result = dao.Connection();
				if (result.equals("Connection Established")) {
					result = dao.Register(person, "Customer");
					if (result.equals("User Registered")) {
						response.sendRedirect("Login.jsp");
					} else {
						session.setAttribute("signuperror", true);
						response.sendRedirect("Register.jsp");

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

		else if (action.equals("edit")) {
			firstname = request.getParameter("firstname");
			lastname = request.getParameter("lastname");
			username = request.getParameter("username");
			roleName = request.getParameter("selectedRole");
			try {
				dao.editUser(firstname, lastname, username, roleName);
				response.sendRedirect("ManageUsers.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		else if (action.equals("add")) {
			firstname = request.getParameter("firstname");
			lastname = request.getParameter("lastname");
			username = request.getParameter("username");
			password = request.getParameter("password");
			roleName = request.getParameter("selectedRole");

			// Instantiate Person and User
			Person person = new Person();
			User user = new User();
			person.setFrstname(firstname);
			person.setLastname(lastname);
			user.setUsername(username);
			user.setPassword(PasswordUtil.hashPwd(password));
			person.setUser(user);

			try {

				result = dao.Register(person, roleName);
				if (result.equals("User Registered")) {
					response.sendRedirect("ManageUsers.jsp");
				} else {
					session.setAttribute("signuperror", true);
					response.sendRedirect("Register.jsp");

				}

			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		else if (action.equals("delete")) {
			username = request.getParameter("username");
			try {
				dao.deleteUser(username);
				response.sendRedirect("ManageUsers.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
