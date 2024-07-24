package com.app.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;
import com.app.model.Person;
import com.app.model.Product;
import com.app.security.PasswordUtil;

public class DAOImpl {

	private String result;
	private int row_exist = 0;
	private int price;
	private Connection con;
	private PreparedStatement st;
	private static DAOImpl obj;
	private Properties dbProperties;

	public static DAOImpl getInstance() {
		if (obj == null) {
			obj = new DAOImpl();
		}
		return obj;
	}

	public DAOImpl() {
		try (InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties")) {
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
		} else {
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
			} else
				result = "No Data";
		}
		return result;
	}

	public String Register(Person person, String role) throws ClassNotFoundException {
		String hashPwd = person.getUser().getPassword();
		String username = person.getUser().getUsername();
		String frstname = person.getFrstname();
		String lastname = person.getLastname();
		String query1 = "select role_id from roles where role_name = ?";
		try {
			st = con.prepareStatement(query1);
			st.setString(1, role);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				int role_id = rs.getInt(1);
				String query2 = "{call add_user(?,?,?,?,?)}";
				CallableStatement st = con.prepareCall(query2);
				st.setString(1, username);
				st.setString(2, frstname);
				st.setString(3, lastname);
				st.setString(4, hashPwd);
				st.setInt(5, role_id);
				st.execute();
				result = "User Registered";
			}
		} catch (SQLException e) {
			if (e.getErrorCode() == 20001) {
				result = e.getMessage();
			}
		}
		return result;
	}

	public int insert(Product product) throws SQLException {
		int result = 0;
		try {
			String query1 = "{call add_stock(?,?,?,?,?)}";
			CallableStatement st = con.prepareCall(query1);
			st.setString(1, product.getProduct());
			st.setInt(2, product.getQuantity());
			st.setInt(3, product.getUnitprice());
			st.setString(4, product.getDescription());
			st.registerOutParameter(5, java.sql.Types.NUMERIC);
			st.execute();
			result = st.getInt(5);
		} catch (SQLException e) {
			if (e.getErrorCode() == 20002) {
				result = 0;
			}
		}
		return result;
	}

	public ResultSet displayAll() throws SQLException {
		String query1 = "select * from stock where quantity>0";
		st = con.prepareStatement(query1);
		ResultSet rs = st.executeQuery();
		return rs;
	}

	public ResultSet display(String product) throws SQLException {
		String query1 = "select product, quantity, unitprice, description from stock where UPPER(product) like ?";
		st = con.prepareStatement(query1);
		st.setString(1, "%" + product.toUpperCase() + "%");
		ResultSet rs = st.executeQuery();
		return rs;
	}

	public int addcart(String product, int quantity, String username) throws SQLException {
		String query2 = "select unitprice from stock where UPPER(product)=?";
		st = con.prepareStatement(query2);
		st.setString(1, product.toUpperCase());
		ResultSet rs = st.executeQuery();
		int result = 0;
		if (rs.next()) {
			price = rs.getInt(1);
			String query3 = "select product from cart where UPPER(product)=? and username=? and order_id is null";
			st = con.prepareStatement(query3);
			st.setString(1, product.toUpperCase());
			st.setString(2, username);
			if (st.executeUpdate() > 0) {
				String query4 = "update cart set quantity=?, price=?*? where UPPER(product)=? and username=? and order_id is null";
				st = con.prepareStatement(query4);
				st.setInt(1, quantity);
				st.setInt(2, quantity);
				st.setInt(3, price);
				st.setString(4, product.toUpperCase());
				st.setString(5, username);
				result = st.executeUpdate();
			} else {
				String query5 = "{call add_cart(?,?,?,?,?)}";
				CallableStatement st = con.prepareCall(query5);
				st.setString(1, product);
				st.setInt(2, quantity);
				st.setInt(3, price * quantity);
				st.setString(4, username);
				st.registerOutParameter(5, java.sql.Types.NUMERIC);
				st.execute();
				result = st.getInt(5);
			}
		}
		return result;
	}

	public ResultSet viewcart(String username) throws SQLException {
		String query1 = "select * from cart where username=? and (cart_status = ? OR cart_status is null) and order_id is null";
		st = con.prepareStatement(query1, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		st.setString(1, username);
		st.setString(2, "RESERVED");
		ResultSet rs = st.executeQuery();
		return rs;
	}

	public int getCartCount(String username) throws SQLException {
		int count = 0;
		ResultSet rs = viewcart(username);
		if (rs.last()) {
			count = rs.getRow();
			rs.beforeFirst();
		}
		return count;
	}

	public int paymentDetails(String username) throws SQLException {
		String query1 = "select SUM(PRICE) from cart where username = ? and order_id is null and cart_status is null";
		int count = 0;
		st = con.prepareStatement(query1);
		st.setString(1, username);
		ResultSet rs = st.executeQuery();
		if (rs.next())
			count = rs.getInt(1);
		return count;
	}

	public int proceedPayment(LocalDate date, String username) throws SQLException {
		String query1 = "select order_id from ORDERTB where order_status=? and username=?";
		int result = 0;
		st = con.prepareStatement(query1);
		st.setString(1, "PENDING");
		st.setString(2, username);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			int order_id = rs.getInt(1);
			String query2 = "select payment_id from payment where order_id = ? and payment_status=?";
			st = con.prepareStatement(query2);
			st.setInt(1, order_id);
			st.setString(2, "PENDING");
			if (st.executeQuery().next()) {
				String query4 = "update payment set payment_date=? where order_id=?";
				st = con.prepareStatement(query4);
				st.setObject(1, date);
				st.setInt(2, order_id);
				result = st.executeUpdate();
			} else {
				String query3 = "{call add_payment(?,?,?,?)}";
				CallableStatement st = con.prepareCall(query3);
				st.setInt(1, order_id);
				st.setString(2, "CARD");
				st.setString(3, "PENDING");
				st.registerOutParameter(4, java.sql.Types.NUMERIC);
				st.execute();
				result = st.getInt(4);
			}
		}

		return result;
	}

	public int proceedSale(String username) throws SQLException {
		String query1 = "{call payment_checkout(?,?)}";
		CallableStatement st = con.prepareCall(query1);
		st.setString(1, username);
		st.registerOutParameter(2, java.sql.Types.NUMERIC);
		st.execute();
		return st.getInt(2);
	}

	public int removecart(String product) throws SQLException {
		String query1 = "select product from cart where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product);
		if (st.executeUpdate() == 0) {
			row_exist = 0;
		} else {
			String query4 = "delete from cart where UPPER(product)=?";
			st = con.prepareStatement(query4);
			st.setString(1, product.toUpperCase());
			if (st.executeUpdate() > 0) {
				row_exist = 1;
			}
		}
		return row_exist;
	}

	public int deletestock(String product) throws SQLException {
		String query1 = "delete from stock where UPPER(product)=?";
		st = con.prepareStatement(query1);
		st.setString(1, product.toUpperCase());
		int count = st.executeUpdate();
		return count;
	}

	public int update(String product, int quantity, int unitprice, String description) throws SQLException {
		String query1 = "select * from stock where upper(product)=?";
		st = con.prepareStatement(query1);
		st.setString(1, product.toUpperCase());
		ResultSet rs = st.executeQuery();
		int count = 0;
		if (rs.next()) {
			String query2 = "update stock set quantity=?, unitprice=?, description=? where upper(product)=?";
			st = con.prepareStatement(query2);
			st.setInt(1, quantity);
			st.setInt(2, unitprice);
			st.setString(3, description);
			st.setString(4, product.toUpperCase());
			count = st.executeUpdate();
		}
		return count;
	}

	public int createOrder(String username, int orderQty, String orderStatus, LocalDate date) throws SQLException {
		int result = 0;
		String query1 = "select * from ordertb where username = ? and order_status=?";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		st.setString(2, "PENDING");
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			String query2 = "update ORDERTB set order_qty=?, order_date=? where username=?";
			st = con.prepareStatement(query2);
			st.setInt(1, orderQty);
			st.setObject(2, date);
			st.setString(3, username);
			result = st.executeUpdate();
		} else {
			String query2 = "{call add_order(?,?,?,?)}";
			CallableStatement st = con.prepareCall(query2);
			st.setString(1, username);
			st.setInt(2, orderQty);
			st.setString(3, orderStatus);
			st.registerOutParameter(4, java.sql.Types.NUMERIC);
			st.execute();
			result = st.getInt(4);
		}
		return result;
	}

	public void reserveCart(String username) throws SQLException {
		String query1 = "select quantity, product from cart where username=? and order_id is null";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		ResultSet rs = st.executeQuery();
		while (rs.next()) {
			int cartQuantity = rs.getInt(1);
			String product = rs.getString(2);
			String query2 = "select quantity from stock where product=?";
			st = con.prepareStatement(query2);
			st.setString(1, product);
			ResultSet rs2 = st.executeQuery();
			if (rs2.next()) {
				int stockQuantity = rs2.getInt(1);
				if (stockQuantity > cartQuantity) {
					String query3 = "update stock set quantity = quantity - ? where product = ?";
					st = con.prepareStatement(query3);
					st.setInt(1, cartQuantity);
					st.setString(2, product);
					st.executeUpdate();
					String query4 = "update cart set cart_status=? where username=? and product=? and cart_status is null";
					st = con.prepareStatement(query4);
					st.setString(1, "RESERVED");
					st.setString(2, username);
					st.setString(3, product);
					st.executeUpdate();
				} else {
					String query5 = "update cart set cart_status=? where username=? and product=? and cart_status is null";
					st = con.prepareStatement(query5);
					st.setString(1, "UNAVAILABLE");
					st.setString(2, username);
					st.setString(3, product);
					st.executeUpdate();
				}
			}
		}
	}

	public void restoreStock(String username) throws SQLException {
		String query1 = "select quantity, product from cart where username=? and order_id is null and cart_status=?";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		st.setString(2, "RESERVED");
		ResultSet rs = st.executeQuery();
		while (rs.next()) {
			int cartQuantity = rs.getInt(1);
			String product = rs.getString(2);
			String query2 = "update stock set quantity = quantity + ? where product=?";
			st = con.prepareStatement(query2);
			st.setInt(1, cartQuantity);
			st.setString(2, product);
			st.executeUpdate();

			String query3 = "update cart set cart_status = null where username = ? and product=? and cart_status in (?,?)";
			st = con.prepareStatement(query3);
			st.setString(1, username);
			st.setString(2, product);
			st.setString(3, "RESERVED");
			st.setString(4, "UNAVAILABLE");
			st.executeUpdate();
		}
	}

	public ResultSet custRpt() throws SQLException {
		String query1 = "select count(username) from usertb where role_id = (select role_id from roles where role_name=?)";
		st = con.prepareStatement(query1);
		st.setString(1, "Customer");
		return st.executeQuery();
	}

	public ResultSet totSalesRpt() throws SQLException {
		String query1 = "select count(order_id) from ordertb where order_status=?";
		st = con.prepareStatement(query1);
		st.setString(1, "COMPLETED");
		return st.executeQuery();
	}

	public ResultSet totProductRpt() throws SQLException {
		String query1 = "select count(product) from stock where quantity>0";
		st = con.prepareStatement(query1);
		return st.executeQuery();
	}

	public ResultSet getRole(String username) throws SQLException {
		String query = "select role_name from roles where role_id = (select role_id from usertb where username = ?)";
		st = con.prepareStatement(query);
		st.setString(1, username);
		return st.executeQuery();
	}

	public ResultSet getUsers() throws SQLException {
		String query = "select username, firstname, lastname, roles.role_name, password \r\n" + "from usertb \r\n"
				+ "left join roles \r\n" + "on usertb.role_id = roles.role_id \r\n" + "where roles.role_name!=?";
		st = con.prepareStatement(query);
		st.setString(1, "Customer");
		return st.executeQuery();
	}

	public ResultSet getRoles() throws SQLException {
		String query = "select * from roles where role_name!=?";
		st = con.prepareStatement(query);
		st.setString(1, "Customer");
		return st.executeQuery();
	}

	public void addRole(String role) throws SQLException {
		String query1 = "{call add_role(?)}";
		CallableStatement st = con.prepareCall(query1);
		st.setString(1, role);
		st.execute();
	}

	public void editRole(String role, int roleId) throws SQLException {
		String query1 = "update roles set role_name = ? where role_id=? ";
		st = con.prepareStatement(query1);
		st.setString(1, role);
		st.setInt(2, roleId);
		st.execute();
	}

	public void deleteRole(int roleId) throws SQLException {
		String query1 = "delete from roles where role_id=? ";
		st = con.prepareStatement(query1);
		st.setInt(1, roleId);
		st.execute();
	}

	public void editUser(String firstname, String lastname, String username, String roleName) throws SQLException {
		String query1 = "update usertb set firstname = ?, lastname=?, role_id = (select role_id from roles where role_name=?) where username=?";
		st = con.prepareStatement(query1);
		st.setString(1, firstname);
		st.setString(2, lastname);
		st.setString(3, roleName);
		st.setString(4, username);
		st.execute();
	}

	public void deleteUser(String username) throws SQLException {
		String query1 = "delete from usertb where username=? ";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		st.execute();
	}

	public ResultSet getOrders(String username) throws SQLException {
		String query = "select product, quantity, price, o.order_date from cart c\r\n" + "inner join ordertb o\r\n"
				+ "on c.order_id = o.order_id\r\n" + "and cart_status='PURCHASED' \r\n" + "and c.username=?";
		st = con.prepareStatement(query);
		st.setString(1, username);
		return st.executeQuery();
	}
	
	public int getPaymentStatus(String username) throws SQLException {
		int payment_id = 0;
		String query1 = "select order_id from ordertb where username=? and order_status=?";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		st.setString(2, "PENDING");
		ResultSet rs1 = st.executeQuery();
		if (rs1.next()) {
			int order_id = rs1.getInt(1);
			String query2 = "select payment_id from payment where order_id=? and payment_status = ?";
			st = con.prepareStatement(query2);
			st.setInt(1, order_id);
			st.setString(2, "PENDING");
			ResultSet rs = st.executeQuery();
			if(rs.next()) {
				payment_id = rs.getInt(1);
			}
		}
		 
		return payment_id;
	}
	
	public void setPaymentStatus(String status, int payment_id) throws SQLException {
		System.out.println("Inside set payment status");
		String query = "update payment set payment_status=? where payment_id=?"; 
		st = con.prepareStatement(query);
		st.setString(1, status);
		st.setInt(2, payment_id);
		st.executeUpdate();
		
	}
	

}
