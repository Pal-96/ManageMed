<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<body>
<div style="color: white">
<%
String action=""+session.getAttribute("action");


if(session.getAttribute("username")==null)
{
	response.sendRedirect("Login.jsp");
}

if(session.getAttribute("quantity")==null && action.equals("") )
{
	out.println("Please enter valid number");
}
if (session.getAttribute("quantity")!=null) {
	
	int quantity = (Integer) session.getAttribute("quantity");


if(action!=null && action.equals("add") && quantity>0)
{
 	System.out.println("Inside");
	out.println(session.getAttribute("quantity")+" items added to stock");
	session.removeAttribute("quantity");
	session.removeAttribute("action");
} 
 	
	
if(action!=null && action.equals("remove") && quantity>0)
{
 	System.out.println("Inside");
	System.out.println(session.getAttribute("quantity")+" items removed from stock");
	session.removeAttribute("quantity");
	session.removeAttribute("action");
} 

if(quantity<0 )
{
	out.println("Please enter valid number");
}
}
%>

<form action="addrem" method="post">

Product <input type="text" name="product">    

Quantity <input type="text" name="quantity">

Action <select id="action" name="action">
<option value="add">Add</option> 
<option value="remove">Remove</option>
</select>


<input type="submit" value="Submit">

</form>

<br>


<form action="Home.jsp" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" name="Go to Home" value="Home">
</form>
<br>

<form action="logout" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" value="Logout">
</form>
</div>
</body>
</html>