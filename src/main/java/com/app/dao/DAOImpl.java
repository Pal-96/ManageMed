package com.app.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.mindrot.jbcrypt.BCrypt;

import com.app.model.Person;
import com.app.security.PasswordUtil;

import oracle.jdbc.driver.*;
import oracle.sql.NUMBER;

public class DAOImpl {

	private String result;
	private int row_exist = 0;;
	private int quantity;
	private int price;
	private Connection con;
	private PreparedStatement st;
	private static DAOImpl obj;
	private Properties dbProperties;

	public static DAOImpl getInstance() {
		System.out.println("Inside get instance");

		if (obj == null) {
			obj = new DAOImpl();
		}

		return obj;

	}

	public DAOImpl() {
		System.out.println("Inside constructor");
		try (InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties")) {
			System.out.println(input);
			dbProperties = new Properties();
			dbProperties.load(input);
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}

	public String Connection() throws ClassNotFoundException, SQLException {
		Class.forName(dbProperties.getProperty("db.Driver"));
		String dbURL = dbProperties.getProperty("db.URL");
		String user = dbProperties.getProperty("db.User");
		String pwd = dbProperties.getProperty("db.Pwd");

		con = DriverManager.getConnection(dbURL, user, pwd);

		if (con == null) {
			result = "Connection Error";
		}
		else {
			result = "Connection Established";
		}
		return result;
	}

	public String login(String username, String password) throws SQLException {

		String query = "select password from USERTB where username=?";
		st = con.prepareStatement(query);
		st.setString(1, username);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			String storedPwd = rs.getString("password");
			boolean isPwdValid = PasswordUtil.verifyPassword(password, storedPwd);

			if (isPwdValid) {
				result = "Login Succssful";
			}
		}

		else
			result = "No Data";

		return result;
	}

	public String Register(Person person) throws ClassNotFoundException, SQLException {
		String hashPwd = person.getUser().getPassword();
		String username = person.getUser().getUsername();
		String frstname = person.getFrstname();
		String lastname = person.getLastname();
		String query = "insert into USERTB values (?,?,?,?)";
		st = con.prepareStatement(query);
		st.setString(1, username);
		st.setString(2, frstname);
		st.setString(3, lastname);
		st.setString(4, hashPwd);

		if (st.executeUpdate() > 0) {
			result = "User Registered";
		}

		else
			result = "User registration failed. Please try again";

		return result;
	}

	public int insert(String product, int quantity, int unitprice) throws SQLException {
		System.out.println("Inside DAO");
		String query1 = "select * from stock where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product.toUpperCase());

		if (st.executeUpdate() > 0) {
			String query2 = "update stock set quantity=quantity+? where product=?";
			st = con.prepareStatement(query2);
			st.setInt(1, quantity);
			st.setString(2, product.toUpperCase());
		} else {
			String query3 = "insert into stock values (?,?,?)";

			st = con.prepareStatement(query3);
			st.setString(1, product.toUpperCase());
			st.setInt(2, quantity);
			st.setInt(3, unitprice);
		}

		return st.executeUpdate();

	}

	public int remove(String product, int quantity) throws SQLException {
		System.out.println("Inside DAO");
		String query1 = "select quantity from stock where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product.toUpperCase());

		ResultSet rs = st.executeQuery();

		if (rs.next()) {
			this.quantity = rs.getInt(1);

			if (this.quantity <= quantity)
				return 0;

			else if (this.quantity > quantity) {
				String query2 = "update stock set quantity=quantity-? where product=?";
				st = con.prepareStatement(query2);
				st.setInt(1, quantity);
				st.setString(2, product.toUpperCase());
			}
		}

		return st.executeUpdate();

	}

	public ResultSet displayAll() throws SQLException {
		System.out.println("Inside Display All");

		System.out.println("Inside DAO");
		String query1 = "select * from stock";
		st = con.prepareStatement(query1);
		// st.setString(1, "%"+product.toUpperCase()+"%");

		ResultSet rs = st.executeQuery();
		return rs;

	}

	public ResultSet display(String product) throws SQLException {
		System.out.println("Inside Display");

		System.out.println("Inside DAO");
		String query1 = "select * from stock where product like ?";
		st = con.prepareStatement(query1);
		st.setString(1, "%" + product.toUpperCase() + "%");

		ResultSet rs = st.executeQuery();
		return rs;

	}

	public int addcart(String product, int quantity) throws SQLException {
		System.out.println("Inside add cart");

		System.out.println("Inside DAO");
		String query5 = "select quantity from stock where product=?";
		st = con.prepareStatement(query5);
		st.setString(1, product);
		ResultSet rs1 = st.executeQuery();
		rs1.next();
		System.out.println("no stock:" + rs1.getInt(1));
		if (rs1.getInt(1) == 0) {
			return 0;
		}

		else {
			String query4 = "select unitprice from stock where product=?";
			st = con.prepareStatement(query4);
			st.setString(1, product.toUpperCase());

			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				price = rs.getInt(1);
			}

			String query1 = "select product from cart where product=?";
			st = con.prepareStatement(query1);
			st.setString(1, product.toUpperCase());

			if (st.executeUpdate() > 0) {
				System.out.println("Quan:" + quantity);
				System.out.println("Price:" + price);
				String query2 = "update cart set quantity=?, price=?*? where product=?";
				st = con.prepareStatement(query2);
				st.setInt(1, quantity);
				st.setInt(2, quantity);
				st.setInt(3, price);
				st.setString(4, product.toUpperCase());

			} else {
				String query3 = "insert into cart values (?,?,?)";
				st = con.prepareStatement(query3);
				st.setString(1, product.toUpperCase());
				st.setInt(2, quantity);
				st.setInt(3, price * quantity);
			}

			return st.executeUpdate();
		}
	}

	public ResultSet viewcart() throws SQLException {
		System.out.println("Inside viewcart");

		System.out.println("Inside DAO");
		String query1 = "select * from cart";
		st = con.prepareStatement(query1, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

		ResultSet rs = st.executeQuery();

		return rs;

	}

	public int getCartCount() throws SQLException {
		int count = 0;
		ResultSet rs = viewcart();
		if (rs.last()) {
			count = rs.getRow(); // Get the row number which is the count of rows
			rs.beforeFirst(); // Move the cursor back to the beginning
		}
		return count;
	}

	public ResultSet bill() throws SQLException {
		System.out.println("Inside bill");

		System.out.println("Inside DAO");
		String query1 = "select * from cart";
		st = con.prepareStatement(query1);

		ResultSet rs = st.executeQuery();

		return rs;

	}

	public ResultSet paymentDetails() throws SQLException {
		System.out.println("Inside payment");

		System.out.println("Inside DAO");
		String query1 = "select SUM(PRICE) from cart";
		st = con.prepareStatement(query1);

		ResultSet rs = st.executeQuery();

		return rs;

	}

	public int proceedSale() throws SQLException {
		System.out.println("Inside proceed sale");

		System.out.println("Inside DAO");
		String query1 = "{call checkout(?)}";
		CallableStatement st = con.prepareCall(query1);
		st.registerOutParameter(1, java.sql.Types.NUMERIC);
		st.execute();

		System.out.println(st.getInt(1));
		return st.getInt(1);

	}

	public int removecart(String product) throws SQLException {
		System.out.println("Inside remove cart");
		System.out.println("Inside DAO");
		String query1 = "select product from cart where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product);
		if (st.executeUpdate() == 0) {
			row_exist = 0;
		}

		else {

			String query4 = "delete from cart where product=?";
			st = con.prepareStatement(query4);
			st.setString(1, product.toUpperCase());

			if (st.executeUpdate() > 0) {
				row_exist = 1;
			}
		}

		return row_exist;
	}

	public ResultSet deletestock(String product) throws SQLException {
		System.out.println("Inside delete stock");
		String query2 = "delete from stock where product=?";
		st = con.prepareStatement(query2);
		st.setString(1, product.toUpperCase());
		ResultSet rs = st.executeQuery();

		return rs;

	}

}
