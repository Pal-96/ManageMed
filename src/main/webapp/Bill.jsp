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
<% 
String med=""+session.getAttribute("med");
if(med.equals("removed"))
{
	out.println("Removed from cart");
}
%>
<form action="Bill.jsp" method="post">
<input type="submit" name="view cart" value="View Cart" align="right" >
</form>
<form action="Bill.jsp" method="post" style=" ">
<input type="submit" name="bill" value="Generate Bill">
</form>
<% 
if(request.getParameter("view cart")!=null && request.getParameter("view cart").equals("View Cart"))
{
	int ctr=0;
	DAOImpl dao=DAOImpl.getInstance();
	ResultSet rs=dao.viewcart();
%>
<br><br>
<b style="color: black;">CART ITEMS </b>
<br>
<TABLE height="80" width="400" border="3"  bordercolor="black" style="color: black" >
<TR>
<TH><b>SR NO.</b></TH>
<TH><b>PRODUCT</b></TH>
<TH><b>QUANTITY</b></TH>
</TR>
<%	
	while(rs.next())
	{
		ctr++;
		String product=rs.getString(1);
%>	
<TR>
<td align="center"><%=ctr %></td>
<td align="center"><%=rs.getString(1) %></td>
<td align="center"><%=rs.getInt(2) %></td>
<td align="center"><form action="addtocart" method="post">
</b><input type="Submit" name="Remove from Cart" value="REMOVE" style="cursor: pointer;"></b>
<input type="hidden" name="product" value=<%= rs.getString(1)%>>
</form></td>

</TR>
<% }%>
</TABLE>
<%}%>

<% 
if((request.getParameter("bill")!=null && request.getParameter("bill").equals("Generate Bill"))|| session.getAttribute("generate bill")!=null)
{
	session.setAttribute("generate bill", "yes");
	int ctr=0;
	DAOImpl dao=DAOImpl.getInstance();
	ResultSet rs1=dao.bill();

%>

<br><br>
<b style="color: black;">ORDER SUMMARY </b>
<br>
<TABLE height="80" width="400" border="3"  bordercolor="black" style="color: black" >
<TR>
<TH><b>SR NO.</b></TH>
<TH><b>PRODUCT</b></TH>
<TH><b>QUANTITY</b></TH>
<TH><b>PRICE</b></TH>
</TR>
<%	
	while(rs1.next())
	{
		ctr++;
%>	
<TR>
<td align="center"><%=ctr %></td>
<td align="center"><%=rs1.getString(1) %></td>
<td align="center"><%=rs1.getInt(2) %></td>
<td align="center"><%="Rs. "+rs1.getInt(3) %></td>
</TR>
<% }%>
</TABLE>
<%
ResultSet rs2=dao.paymentDetails();
%>
<br><br>
<b style="color: black;">PAYMENT DETAILS </b>
<br>
<TABLE height="80" width="400" border="3"  bordercolor="black" style="color: black" >
<TR>
<TH><b>MRP TOTAL</b></TH>
<TH><b>TOTAL AMOUNT</b></TH>
</TR>
<%	
	while(rs2.next())
	{		
%>	
<TR>
<td align="center"><%="Rs. "+rs2.getInt(1) %></td>
<td align="center"><%="Rs. "+rs2.getInt(1) %></td>
</TR>
<% }%>
</TABLE>
<br><br>
<form action="Bill.jsp" method="post">
<input type="submit" name="proceed sale" value="PROCEED SALE">
</form>


<% 
System.out.println("Sale:" +request.getParameter("proceed sale"));

if(request.getParameter("proceed sale")!=null && request.getParameter("proceed sale").equals("PROCEED SALE"))
{

	int result=dao.proceedSale();
	
	if(result>0)
	{%>
		<b style="color: black;"><%out.println("Successful Sale"); %></b>
	<%}
	
	else if (result==0)
	{%>
		<b style="color: black;"><%out.println("Un Successful Sale"); %></b>
	<%}
	
session.removeAttribute("generate bill");
}}%>
<br><br>
<form action="Home.jsp" method="post" style="display: inline-block;">
<input style="cursor:pointer; font-style: inherit;" type="Submit" name="Go to Home" value="Home">
</form>
<br>

<form action="logout" method="post" ">
<input style="cursor:pointer;" type="Submit" value="Logout" align="right" >
</form>


</body>
</div>
</html>