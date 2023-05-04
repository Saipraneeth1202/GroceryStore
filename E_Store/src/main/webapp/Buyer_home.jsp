<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page import="java.awt.Button"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="Formstyle.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
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

button:hover, button:focus {
	background-color: #fb8332;
}

.error {
	color: #FF0000;
}

.container {
	border: solid 2px white;
	max-height: 600px;
	/* max-height: 100%; */
	padding: 10px;
	width:31%;
}

.container img {
	width: 100%;
	height: 250px;
}


#items_space, #cart_space{
	width:100%;
	display:flex;
	justify-content:space-between; 
	/* align-items:center; */
	flex-wrap:wrap;
}

#bt1, #next, #left, #buy, #rem{
	background-color: #00ffaa; /* Green */
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;	
}

#pageitems, #search{
	background-color: #00ffaa;
	color: black;
	font-size: 15px;
	width:70px;
	heifht:18px;
	text-align: left;
}
</style>

<title>E_Store : For all Your Needs</title>
</head>
<body>
	<div id="head" style="color: black;">
		<%@ include file="header.html"%>
		<%@ page import="java.util.*,java.io.*,java.sql.*,javax.servlet.*" %>
	</div>
	<hr>
	<div class="privileges">
		<h1>Actions that can be performed</h1>
		<form onsubmit="test1()" method="post" action="SearchItem">
		<input id="search1" name="search1" type="text" placeholder="Search for an Item">
		<input id="search" name="search" type="submit" value="GO">
		&emsp; &emsp; &emsp;
		</form>
		
		<input onclick="openpage()" id="buy" name="buy" type="submit" value="Buy Items in Cart" >
		
		<button style='font-size:40px; width:40px; height:40px; background-color: black;'> <i class='fas fa-cart-arrow-down'></i></button>
		
		<br> <br>
	</div>
	<hr>
	<hr>
	<br>
	<h1 align="center">
			<i> -- Cart Items Will be displayed here -- </i>
		</h1>
		
	<div align="center" id="cart_space">
		
		<%
		if (session.getAttribute("user") == null) {
			out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
			out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/E_Store/Main_Interface.jsp\"");
			//return;
		}
		int count = 0;
		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template = "SELECT * FROM CART WHERE BUYER_EMAIL=\"" + (String) session.getAttribute("user") + "\"" ;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template, ResultSet.TYPE_SCROLL_SENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
			//query.setString(1, request.getParameter("email"));

			ResultSet rs = query.executeQuery();

			if (!rs.next()) 
			{
				out.println(
				"<h1 align=\"center\"><I>No items added yet. You can add items by clicking on Add to Cart</I></h1>");
			} else {
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				rs.beforeFirst();
				while (rs.next()) {
			count = count + 1;
			out.print("<div class=\"container\">");
			String columnValue = rs.getString(6);
			//out.println("<br><br>");
			out.println("<img align=\"center\" src=\"" + columnValue + "\">");
			out.println("<br><br>");
			String TEMP = "";
			for (int i = 1; i <= columnsNumber - 1; i++) {
				columnValue = rs.getString(i);
				if (rsmd.getColumnName(i).equals("IMAGE")) {
					continue;
				}
				if (rsmd.getColumnName(i).equals("NAME")) {
					TEMP = columnValue;
				}
				if (rsmd.getColumnName(i).equals("DESCRIPTION")) {
					out.print(rsmd.getColumnName(i) + " : <br>" + columnValue);
					out.println("<br>");
					continue;
				}
				out.print(rsmd.getColumnName(i) + " : " + columnValue);
				out.println("<br>");
			}
			out.println("<BR><form  onsubmit=\"test2()\" method=\"post\" action=\"DelFromCart\"><input name=\"rem\" id=\"rem\" type=\"submit\" value=\"Remove From Cart\" > <input type=\"hidden\" name=\"Id\" value=\"" + rs.getString(1) +"\"> <input type=\"hidden\" name=\"NAME\" value=\"" + TEMP + "\"> </form>");
			out.print("</div>");
			//out.println("<br><hr><br>");
			}
			}

			con.close();
		} catch (Exception ex) {
			out.println(ex);
		}
		%>

	</div>
	<br>
	<br>
	<hr>
	<hr>
	<h1 align="center" style="font-size:50px;">Shop Items</h1>
	<%
	out.println("<div align=\"center\"  id=\"items_space\">");
		
		if (session.getAttribute("user") == null) {
			out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
			out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/E_Store/Main_Interface.jsp\"");
			//return;
		}
		int count1 = 0;
		int pgcount = 0;
		String x = (String) session.getAttribute("pagecount");
		pgcount = Integer.parseInt(x);
		String y = (String) session.getAttribute("search");
		String z = (String) session.getAttribute("numpg");
		int num_inpg = Integer.parseInt(z);
		String encodedURL = response.encodeRedirectURL("Buyer_home.jsp");

		try {
			String template1 = "SELECT * FROM ITEMS WHERE CATEGORY LIKE ? OR NAME LIKE ? LIMIT ?, ?" ;
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
			
			query.setString(1, "%" + y + "%");
			query.setString(2, "%" + y + "%");
			query.setInt(3, pgcount);
			query.setInt(4, num_inpg);
			
			//query.setInt(2, Integer.parseInt(request.getParameter("pgno")));
			
			//query.setString(1, request.getParameter("email"));

			ResultSet rs = query.executeQuery();

			if (!rs.next()) {
				out.println(
				"<h1 align=\"center\"><I>No items found for that search.</I></h1>");
			} 
			else 
			{
				java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				int columnsNumber = rsmd.getColumnCount();
				rs.beforeFirst();
				while (rs.next()) {
			count1 = count1 + 1;
			out.print("<div class=\"container\">");
			String columnValue = rs.getString(6);
			//out.println("<br><br>");
			out.println("<img align=\"center\" src=\"" + columnValue + "\">");
			out.println("<br><br>");
			String TEMP = "";
			for (int i = 1; i <= columnsNumber - 1; i++) {
				columnValue = rs.getString(i);
				if (rsmd.getColumnName(i).equals("IMAGE")) {
					continue;
				}
				if (rsmd.getColumnName(i).equals("NAME")) {
					TEMP = columnValue;
				}
				if (rsmd.getColumnName(i).equals("DESCRIPTION")) {
					out.print(rsmd.getColumnName(i) + " : <br>" + columnValue);
					out.println("<br>");
					continue;
				}
				out.print(rsmd.getColumnName(i) + " : " + columnValue);
				out.println("<br>");
			}
			
			out.println(
					"<form  onsubmit=\"test()\" method=\"post\" action=\"Add_Cart\"><input type=\"number\" min=\"1\" name=\"number1\" value=\"1\" /> <input name=\"bt1\" id=\"bt1\" type=\"submit\" value=\"Add to Cart\" > <input type=\"hidden\" name=\"Id\" value=\"" + rs.getString(1) +"\"> <input type=\"hidden\" name=\"NAME\" value=\"" + TEMP + "\"> </form>");
			//out.println("<br><button> Add to Cart </button>");
			//out.println("<br><br><hr><br>");
			out.print("</div>");
			
			}
			}
			out.print("</div>");
			if(pgcount == 0)
			{
				out.println(
						"<h2> Choose Number of Items Per Page : </h2><form action=\"Page10\" method=\"post\" ><select name=\"pgno\"><option value=\"10\" selected> 10 </option><option value=\"5\"> 5 </option><option value=\"15\"> 15 </option><option value=\"20\"> 20 </option></select><input id=\"pageitems\" name=\"go\" type=\"submit\" value=\"GO\"><br><br><input type=\"submit\" style=\"float:right;\" id=\"next\" name=\"next\" value=\"Next Page\" > </form>");	
			}
			else
			{
				out.println("<h2> Choose Number of Items Per Page : </h2><form action=\"Page10\" method=\"post\"> <select name=\"pgno\"><option value=\"10\" selected> 10 </option><option value=\"5\"> 5 </option><option value=\"15\"> 15 </option><option value=\"20\"> 20 </option></select><input id=\"pageitems\" name=\"go\" type=\"submit\" value=\"GO\"><br><br><input type=\"submit\" style=\"float:left;\" id=\"left\" name=\"left\" value=\"Previous Page\" > <input type=\"submit\" style=\"float:right;\" id=\"next\" name=\"next\" value=\"Next Page\" > </form>");	
			}
			
			con.close();
		} catch (Exception ex) {
			out.println(ex);
		}
		%>
		
	<br>
	<br>
	<br>
	
	<hr>
	<div id="foot" style="color: black;">
		<%@ include file="footer.html"%>
	</div>

	<script>
	
	function test()
	{
		alert("Item(s) Added to CART ");
	}
	
	function test1()
	{
		alert("Scroll to view the Search Results ");
	}
	
	function test2()
	{
		alert("Item Deleted From Cart");
	}
	function openpage()
	{
		location.href="Checkout.jsp"
	}
	</script>
		
</body>

</html>