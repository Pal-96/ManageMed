package com.app.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.mindrot.jbcrypt.BCrypt;

import com.app.model.Person;
import com.app.model.Product;
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

	public int insert(Product product) throws SQLException {
		System.out.println("Inside DAO");
		String query1 = "select * from stock where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product.getProduct().toUpperCase());

		if (st.executeUpdate() > 0) {
			String query2 = "update stock set quantity=quantity+? where product=?";
			st = con.prepareStatement(query2);
			st.setInt(1, product.getQuantity());
			st.setString(2, product.getProduct().toUpperCase());
		} else {
			String query3 = "insert into stock values (?,?,?,?)";

			st = con.prepareStatement(query3);
			st.setString(1, product.getProduct().toUpperCase());
			st.setInt(2, product.getQuantity());
			st.setInt(3, product.getUnitprice());
			st.setString(4, product.getDescription());
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

	public int addcart(String product, int quantity, String username) throws SQLException {
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

			String query1 = "select product from cart where product=? and username=? and order_id is null";
			st = con.prepareStatement(query1);
			st.setString(1, product.toUpperCase());
			st.setString(2, username);

			if (st.executeUpdate() > 0) {
				System.out.println("Quan:" + quantity);
				System.out.println("Price:" + price);
				String query2 = "update cart set quantity=?, price=?*? where product=? and username=? and order_id is null";
				st = con.prepareStatement(query2);
				st.setInt(1, quantity);
				st.setInt(2, quantity);
				st.setInt(3, price);
				st.setString(4, product.toUpperCase());
				st.setString(5, username);

			} else {
				String query3 = "insert into cart (product, quantity, price, username) values (?,?,?,?)";
				System.out.println("Loged in:"+username);
				st = con.prepareStatement(query3);
				st.setString(1, product.toUpperCase());
				st.setInt(2, quantity);
				st.setInt(3, price * quantity);
				st.setString(4, username);
			}

			return st.executeUpdate();
		}
	}

	public ResultSet viewcart(String username) throws SQLException {
		System.out.println("Inside viewcart");

		System.out.println("Inside DAO logged in by:"+username);
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
	
	public int getCheckoutPrice(String username) throws SQLException {
		int count = 0;
		ResultSet rs = paymentDetails(username);
		if (rs.next()) {
			count = rs.getInt(1);
		}
		return count;
	}

	public ResultSet paymentDetails(String username) throws SQLException {
		System.out.println("Inside payment");

		System.out.println("Inside DAO");
		String query1 = "select SUM(PRICE) from cart where username = ? and order_id is null and cart_status is null";
		st = con.prepareStatement(query1);
		st.setString(1, username);

		ResultSet rs = st.executeQuery();

		return rs;

	}
	
	public int proceedPayment(LocalDate date, String username) throws SQLException {
		String query1 = "select order_id from ORDERTB where order_status=? and username=?";
		st = con.prepareStatement(query1);
		st.setString(1, "PENDING");
		st.setString(2, username);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			int order_id = rs.getInt(1);
			String query2 = "select payment_id from payment where order_id = ?";
			st=con.prepareStatement(query2);
			st.setInt(1, order_id);
			if (st.executeQuery().next()) {
				String query4 = "update payment set payment_date=? where order_id=?";
				st = con.prepareStatement(query4);
				st.setObject(1, date);
				st.setInt(2, order_id);
			}
			
			else {
			String query3 = "insert into payment (order_id, payment_mode, payment_date, payment_status) values (?,?,?,? )";
			st = con.prepareStatement(query3);
			st.setInt(1, order_id);
			st.setString(2, "CARD");
			st.setObject(3, date);
			st.setString(4, "PENDING");
			}
		}
		
		return st.executeUpdate();
	}

	public int proceedSale(String username) throws SQLException {
		System.out.println("Inside proceed sale");

		System.out.println("Inside DAO");
		String query1 = "{call payment_checkout(?,?)}";
		CallableStatement st = con.prepareCall(query1);
		st.setString(1, username);
		st.registerOutParameter(2, java.sql.Types.NUMERIC);
		
		st.execute();

		System.out.println(st.getInt(2));
		return st.getInt(2);

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

	public int deletestock(String product) throws SQLException {
		System.out.println("Inside delete stock");
		String query2 = "delete from stock where product=?";
		st = con.prepareStatement(query2);
		st.setString(1, product.toUpperCase());
		int count = st.executeUpdate();

		return count;

	}
	
	public int update(String product, int quantity, int unitprice, String description) throws SQLException {
		System.out.println("Inside Update DAO");
		System.out.print(product);
		String query1 = "select * from stock where product=?";
		st = con.prepareStatement(query1);
		st.setString(1, product);
		ResultSet rs = st.executeQuery();
		System.out.println(rs);
		int count = 0;

		if (rs.next()) {
			System.out.println("Update medicine in stock");
			String query2 = "update stock set quantity=?, unitprice=?, description=? where product=?";
			st = con.prepareStatement(query2);
			st.setInt(1, quantity);
			st.setInt(2, unitprice);
			st.setString(3, description);
			st.setString(4, product);
			count = st.executeUpdate();
			System.out.print("Count of update:" + count);
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
		}
		else {
		String query3 = "insert into ORDERTB (username, order_qty, order_status, order_date) values (?,?,?,?)";
		st = con.prepareStatement(query3);
		st.setString(1, username);
		st.setInt(2, orderQty);
		st.setString(3, orderStatus);
		st.setObject(4, date);
		result = st.executeUpdate();
		}
		
		return result;
		
	}
	
	public void reserveCart(String username) throws SQLException {
		System.out.println("Inside reserve cart");

		System.out.println("Inside DAO");
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
				if (stockQuantity>cartQuantity) {
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
					
				}
				
				else {
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
		System.out.println("Inside restore stock");
		System.out.println("Inside DAO");
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
	
	public ResultSet checkAvail(String username ) throws SQLException {
		String query1 = "select product, quantity from cart where username=? and cart_status=?";
		st = con.prepareStatement(query1);
		st.setString(1, username);
		st.setString(2, "UNAVAILABLE");
		ResultSet rs = st.executeQuery();
		return rs;
	}
		

}


