<%@page import="java.io.PrintWriter"%>
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
<div style="color: white" >
<body>
<h3>
Hello <% out.println(session.getAttribute("username")) ;%>, 
<br>
This is my first working website of Pharmacy Management System.
<br>
We Provide our customers below services:
<br>
<br>

1) Add/Remove Medicine
<br>
2) Medicine sale
<br>
3) To check stock balance
<br>
4) Bill generation

<!-- <video width="320" height="240" controls>
  <source src="Downloads/video.mp4" type="video/mp4">
 
  Your browser does not support the video tag.
</video> -->
<br><br>To know more about us click on the below link!</h3><br><br>
<!-- <a href="https://www.youtube.com/watch?v=Bwd9hr5Fz5E&list=PLsyeobzWxl7pUPF2xjjJiG4BKC9x_GY46&index=8">About Us</a>.
</p> -->

<!-- <iframe width="560" height="315" controls src="https://www.youtube.com/watch?v=gQLQ0t9B5yk&list=PLsyeobzWxl7pUPF2xjjJiG4BKC9x_GY46&index=33"></iframe> -->

<iframe width="1000" height="600" src="https://www.netmeds.com/checkout/cart"></iframe>
<%
int a=1;


//out.println("Inside Video.jsp");
PrintWriter outp=response.getWriter();
//outp.println("Inside Video.jsp");
if(session.getAttribute("username")==null)
{
	response.sendRedirect("Login.jsp");
}


response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
%>

<br><br>

<form action="Home.jsp" method="post">
<input style="cursor:pointer; font-style: inherit;" type="Submit" name="Go to Home" value="Home">
</form>
<br>
<form action="logout" method="post">
<input style ="cursor:pointer" type="Submit" value="Logout">
</form>
</body>
</div>
</html>