package com.app.service;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.app.dao.DAOImpl;

/**
 * Servlet implementation class AddRole
 */
@WebServlet("/addrole")
public class AddRole extends HttpServlet {
	private String roleName;
	private int roleId;
	private String action;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		roleName = request.getParameter("role");
		DAOImpl dao = DAOImpl.getInstance();

		if (action.equals("edit")) {
			roleId = Integer.parseInt(request.getParameter("roleId"));
			try {
				dao.editRole(roleName, roleId);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		else if (action.equals("delete")) {
			roleId = Integer.parseInt(request.getParameter("roleId"));
			try {
				dao.deleteRole(roleId);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		else if (action.equals("add")) {
			try {
				dao.addRole(roleName);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("ManageRoles.jsp");

	}

}
