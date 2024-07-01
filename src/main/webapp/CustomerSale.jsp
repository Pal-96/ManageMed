<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.util.*" %>
    <%@ page import = "com.app.dao.*"%>
    <%@ page import= "java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>

body{
background-image: url(images5.jpg);
background-repeat: no-repeat;
background-size: cover;
backgroud-attachment: fixed;
}
</style>
</head>
<div style="color: black">
<body>

<form action="CustomerSale.jsp" method="post">
Search medicine name: <input type="text" name="product">
<input  style ="cursor: pointer ;" type="submit" name="view" value="View">
</form>

<% 
String med=""+session.getAttribute("med");
String quantity=""+session.getAttribute("quan");
System.out.println("added or no?:"+med);
if(med.equals("not added"))
{%>
	<%out.println("Cannot add item to cart due to either of the following reasons \n");%>
	<br>
	<%out.println("1. Medincine not available. Please check stock");%>
	<br>
	<%out.println("2. Invalid value entered as quantity");%>
			
	<br>
<%
session.removeAttribute("med");}



if(med.equals("added"))
{
	out.println(quantity+" items added to cart");
	int ctr=0;
	DAOImpl dao=DAOImpl.getInstance();
	ResultSet rs=dao.viewcart();
%>
<br><br>
CART ITEMS CURRENTLY
<TABLE height="80" width="400" border="3"  bordercolor="white" style="color: white" >
<TR>
<TH><b>SR NO.</b></TH>
<TH><b>PRODUCT</b></TH>
<TH><b>QUANTITY</b></TH>

</TR>

<%	
	while(rs.next())
	{
		ctr++;
%>	
<TR>
<td align="center"><%=ctr %></td>
<td align="center"><%=rs.getString(1) %></td>
<td align="center"><%=rs.getInt(2) %></td>
</TR>


	
<% 
	}

%>
</TABLE>
<%
	session.removeAttribute("med");
	session.removeAttribute("quan");
}

if(session.getAttribute("username")==null)
{
	response.sendRedirect("Login.jsp");
}

System.out.println("Prod:"+request.getParameter("product"));
if(request.getParameter("product")!=null && request.getParameter("view").equals("View"))
{
	int ctr=0;
	DAOImpl dao=DAOImpl.getInstance();
	ResultSet rs=dao.display(request.getParameter("product"));

while(rs.next())
{
	ctr++;	
	System.out.println("Prod:"+rs.getString(1));
	System.out.println(rs.getInt(2));
	
	String product=rs.getString(1);
%>
<br>
<form action="addtocart" method="post">
<b>Product name : </b><%= rs.getString(1)%>
<input type="hidden" value=<%= rs.getString(1)%> name="product">
<br>
<b>Quantity available :</b> <%= rs.getInt(2)%>
<br>
</b>Quantity for Sale : </b><input type="text" size="3" name="cartquan">
</b><input type="Submit" name="addtocart" value="addtocart" style="cursor: pointer;"></b>
</form>

<% }}


%>
<br><br>
<form action="Home.jsp" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" name="Go to Home" value="Home">
</form>
<br>

<form action="logout" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" value="Logout">
</form>
<br>
</body>
</div>
</html>