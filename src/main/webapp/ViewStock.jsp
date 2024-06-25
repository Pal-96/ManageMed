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

<div style="color: white">
<body>
<br>
<form action="ViewStock.jsp" method="post">
Enter Medicine to view Stock <input type="text" name="medname">
<input style ="cursor:pointer" type="submit" name="view" value="View">
</form>
<% 
if(session.getAttribute("username")==null)
{
	response.sendRedirect("Login.jsp");
}
System.out.println(request.getParameter("view"));
if(request.getParameter("medname")!=null && request.getParameter("view").equals("View"))
{
	int ctr=0;
	DAOImpl dao=DAOImpl.getInstance();
	ResultSet rs=dao.display(request.getParameter("medname"));

%>

<br>
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
	
	System.out.println(rs.getString(1));
	System.out.println(rs.getInt(2));
%>

<TR>
<td align="center"><%=ctr %></td>
<td align="center"><%=rs.getString(1) %></td>
<td align="center"><%=rs.getInt(2) %></td>
</TR>


<% }} %>

</TABLE>
<br><br>

<form action="Home.jsp" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" name="Go to Home" value="Home">
</form>
<br>

<form action="logout" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" value="Logout">
</form>

     


</body>
</div>
</html>