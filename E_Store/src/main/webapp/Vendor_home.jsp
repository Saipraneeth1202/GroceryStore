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

#items_space{
	width:100%;
	display:flex;
	justify-content:space-between; 
	/* align-items:center; */
	flex-wrap:wrap;
}

#bt1, #bt2{
	background-color: #00ffaa; /* Green */
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;	
}


</style>

<title>E_Store : For all Your Needs</title>
</head>
<body>
	<div id="head" style="color: black;">
		<%@ include file="header.html"%>
	</div>
	<hr>
	<div class="privileges">
		<h1>Actions that can be performed</h1>
		<button onclick="add_item()">Create a New item</button>
		&emsp; &emsp; &emsp;
		<button onclick="produce_reports()">Produce Reports</button>
		<br> <br>
	</div>
	<hr>
	<hr>
	<br>
	<div id="form_space">
		<h1 align="center">
			<i> -- Forms / Reports will be displayed here -- </i>
		</h1>
	</div>
	<br>
	<br>
	<hr>
	<hr>
	<br>
	<h1 align="center">
			<i> -- Your items will be displayed here. You can also update the
				stock -- </i>
		</h1>
	<div align="center" id="items_space">
		
		

		<%@ page import="java.util.*,java.io.*,java.sql.*,javax.servlet.*"%>
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
		String template1 = "SELECT * FROM ITEMS WHERE VENDOR_EMAIL=?";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
			query.setString(1, (String) session.getAttribute("user"));

			ResultSet rs = query.executeQuery();

			if (!rs.next()) {
				out.println(
				"<h1 align=\"center\"><I>No items added yet. You can add items by clicking on Create a New Item</I></h1>");
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
			for (int i = 1; i <= columnsNumber - 1; i++) {
				columnValue = rs.getString(i);
				if (rsmd.getColumnName(i).equals("IMAGE")) {
					continue;
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
					"<form  onsubmit=\"test()\" method=\"post\" action=\"Update_Delete\"><input type=\"number\" min=\"1\" name=\"number1\" value=\"1\" /><input name=\"bt1\" id=\"bt1\" type=\"submit\" value=\"Update Stock\" ><input name=\"bt2\" id=\"bt2\" type=\"submit\" value=\"Delete Item\" > <input type=\"hidden\" name=\"Id\" value=\"" + rs.getString(1) +"\"> </form>");
			out.print("</div>");
			// out.println("<br><hr><br>");
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
	<div id="foot" style="color: black;">
		<%@ include file="footer.html"%>
	</div>

	<script>
	
	function test()
	{
		alert("Items Updated Successfully");
	}
	
	function adding()
	{
		alert("Item Added Successfully");
	}
	
	function add_item()
	{
		   document.getElementById("form_space");
		   var str = `<div align="center" class="form">
			      <h2> Welcome </h2>
			      <h3> Form to add a New Item! </h3>
			      <form method="post" align="center" action="Add_item" onsubmit="adding()">
			      <input readonly="readonly" type="text" value ="ADD_ITEM" name="whattype"><br>
			      <%
			      out.println("<label for=\"itemid\" > Item ID &emsp; &emsp; </label>\n<input readonly=\"readonly\" name=\"itemid\" value=\""
		+ (count + 1) + "\"" + "type=\"text\"/><br>");
		%>
			      <label for="name" >Name of the Item </label>
			      <input id="name" name="name" type="text"><br>
			      <label for="category">Choose a Category </label>
			      <select id="category" name="category">
			        <option value="Fruit"> Fruits </option>
			        <option value="Vegetable"> Vegetables </option>
			        <option value="Eatable"> Eatables </option>
			        <option value="FastFood"> Fast Food </option>
			        <option value="Daily_Essentials"> Daily Essentials </option>
			        <option value="Grocery"> Grocery </option>
			        <option value="Drinks"> Cool drinks </option>
			      </select><br>
			      <label for="price">Price &emsp; &emsp; &emsp;</>
			      <input id="price" name="price" type="text" ><br>
			      <label for="image">Image &emsp; &emsp; &emsp;</>
				  <input id="image" name="image" type="text" ><br>
			      <label for="quantity" >Quantity &emsp; &emsp;</label>
				  <input min="1" value="1" id="quantity" name="quantity" type="number"><br>
				  <label for="desc" > Short Description </label>
				  <input id="desc" name="desc" type="textarea"><br>
			      
			      <button onclick="return is_valid()" type="text" class="submit">Add Item</button><br>
			      </form>
			    </div>`
		   document.getElementById("form_space").innerHTML = str;
	}
	
	function produce_reports()
	{
		location.href="Reports.jsp"
	}
	function is_valid()
	{
		var name = document.getElementById("name").value;
		  var price = document.getElementById("price").value;
		  // var quantity = document.getElementById("quantity").value;
		  var image = document.getElementById("image").value;
		  var desc = document.getElementById("desc").value;
		  
		  var label = "";

		  if(name == "" || price == "" || image == "" || desc == "")
		  {
		    label = "All Fields are Required";
		  }
		  else if (! (new RegExp("^[a-zA-Z-' ]*$")).test(name) || !(new RegExp("^[a-zA-Z-' ]*$")).test(desc)) 
		  {
		    label = "Name and Description Should contain only Characters";
		  }
		  else if (! (new RegExp("^[+-]?([0-9]*[.])?[0-9]+$")).test(price)) 
		  {
		    label = "Invalid Price";
		  } 
		  else
		  {
		    label = "All fields are valid";
		    // alert(label);
		    return true;
		  }
		  alert(label);
		  return false;
	}

</script>


</body>

</html>