<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.awt.Button"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="Formstyle.css">
<style>
body {
	background-color: rgb(0, 0, 0);
	color: white;
}

#title {
	color: rgb(255, 255, 255);
	align-content: center;
	font: Cursive;
	font-size: 45px;
}

p, b, body {
	font-family: "Times New Roman", Times, serif;
	font-size: 18px;
}

button {
	align-items: center;
	background-clip: padding-box;
	background-color: #fa6400;
	border: 1px solid transparent;
	border-radius: .25rem;
	box-shadow: rgba(0, 0, 0, 0.02) 0 1px 3px 0;
	box-sizing: border-box;
	color: #fff;
	cursor: pointer;
	display: inline-flex;
	font-size: 16px;
	font-weight: 600;
	justify-content: center;
	line-height: 1.25;
	margin: 0;
	min-height: 3rem;
	position: relative;
	width: 250px;
}

#cart_space #dates{
	width: 100%;
	/* 	display:flex;
 */
	justify-content: space-between;
	/* align-items:center; */
	flex-wrap: wrap;
}

button:hover, button:focus {
	background-color: #fb8332;
}
</style>
<title>E_Store : For all Your Needs</title>
</head>
<body>
	<div id="head" style="color: black;">
		<%@ include file="header.html"%>
		<%@ page import="java.util.*,java.io.*,java.sql.*,javax.servlet.*"%>
	</div>

	<br>
	<br>
	<hr>


	<div align="center" id="cart_space">
		<h1 align="center">
			<i> -- Transactions will be displayed here -- </i>
		</h1>
		<%
		//out.println("<div align=\"center\" id=\"cart_space\">");
		if (session.getAttribute("user") == null) {
			out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
			out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/E_Store/Main_Interface.jsp\"");
			//return;
		}
		int count = 0;
		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template = "SELECT * FROM TRANSACTIONS WHERE VENDOR_EMAIL=\"" + (String) session.getAttribute("user") + "\"";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template, ResultSet.TYPE_SCROLL_SENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
			//query.setString(1, request.getParameter("email"));

			ResultSet rs = query.executeQuery();
			String str = "";
			if (!rs.next()) {
				out.println(
				"<h1 align=\"center\"><I>No Transactions yet.</I></h1>");
			} else {
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				rs.beforeFirst();

				str = "<TABLE BORDER=1 ALIGN=CENTER><TR BGCOLOR=\"#FF0000\">\n";
				str = str
				+ "<TH> ITEM_ID </TH><TH> ITEM NAME </TH><TH> QUANTITY </TH><TH> BUYER_EMAIL </TH><TH> DATE OF PURCHASE </TH></TR>\n";
				String columnValue;
				
				while (rs.next()) {
			str = str + "<TR>\n";
			for (int i = 1; i <= columnsNumber; i++) {
				columnValue = rs.getString(i);
				if (rsmd.getColumnName(i).equals("VENDOR_EMAIL")) {
					continue;
				}
				str = str + "<td> " + columnValue + " </td>";
			}
			
			
			str = str + "</TR>\n";
			}
				str = str + "</TABLE>";
				out.println(str);
				out.println("<form method=\"post\" action=\"\"><br>");
				out.println("<input type=\"date\" id=\"start\" name=\"start\" >");
				out.println("<input type=\"date\" id=\"end\" name=\"end\" >");
				out.println("<button name=\"bt1\" onclick=\"return test4()\" > Find Purchases between Dates </button>");
				out.println("</form>");
				con.close();
			}

		} catch (Exception ex) 
		{
			out.println(ex);
		}
		
		
		%>
		</div>
		
		<div align="center" id="dates">
		<% 
		if ("POST".equalsIgnoreCase(request.getMethod()))
		{
			String str;
			String template1 = "SELECT * FROM TRANSACTIONS WHERE DOP BETWEEN ? AND ?";
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, user, password);
				PreparedStatement query = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				
				String temp1 = request.getParameter("start");
				String temp2 = request.getParameter("end");
				query.setString(1, temp1);
				query.setString(2, temp2);
				
				ResultSet rs = query.executeQuery();
				
				if (!rs.next()) {
					out.println(
					"<h1 align=\"center\"><I>NO TRANSACTIONS FOUND</I></h1>");
				}
				rs.beforeFirst();
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
					

				str = "<TABLE BORDER=1 ALIGN=CENTER><TR BGCOLOR=\"#FF0000\">\n";
				str = str + "<TH> ITEM_ID </TH><TH> ITEM NAME </TH><TH> QUANTITY </TH><TH> BUYER_EMAIL </TH><TH> DATE OF PURCHASE </TH></TR>\n";
				String columnValue;
					
				while (rs.next()) 
				{
					str = str + "<TR>\n";
					for (int i = 1; i <= columnsNumber; i++) {
						columnValue = rs.getString(i);
						if (rsmd.getColumnName(i).equals("VENDOR_EMAIL")) 
						{
							continue;
						}
						str = str + "<td> " + columnValue + " </td>";
					}
					str = str + "</TR>\n";
				}
				str = str + "</TABLE>";
				out.println(str);					
				con.close();
			}
			catch(Exception ex){
				out.println(ex);
			}
		}
		%>
		</div>

	<br>
	<br>
	<hr>
	<div id="foot" style="color: black;">
		<%@ include file="footer.html" %>
	</div>
	
	<script>
		function test4() 
		{
			var d1 = document.getElementById("start").value;
			var d2 = document.getElementById("end").value;
			if(d1 == "" || d2 == "")
			{
				alert("ALL Fields are Required");
				return false;
			}
			return true;
		}
	</script>
	
</body>

</html>