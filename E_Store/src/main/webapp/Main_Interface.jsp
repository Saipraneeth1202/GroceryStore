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
	width: 150px;
}

button:hover, button:focus {
	background-color: #fb8332;
	box-shadow: rgba(0, 0, 0, 0.1) 0 4px 12px;
}

.error {
	color: #FF0000;
}
</style>

<title>E_Store : For all Your Needs</title>
</head>
<body>
	<div id="head" style="color: black;">
		<%@ include file="header.html"%>
	</div>
	<hr>
	<h2 style="justify-content: center; font-size: 30px;">Order Online</h2>
	<div style="justify-content: center; font-size: 25px;">
		<ul>
			<li>Stay home and order to your doorstep.</li>
			<li>Daily essentials delivered in minutes.</li>
			<li>Here we have whatever you need and can deliver where ever
				you are.</li>
		</ul>
	</div>

	<div align="center" class=image>
		<img style="width: 400px;"
			src="https://media.istockphoto.com/photos/shopping-basket-with-fresh-food-isolated-on-white-grocery-supermarket-picture-id1215516074?k=20&m=1215516074&s=612x612&w=0&h=65csjZjQ147G9t0-D2juS8sfGGx9t9db8DkoAkKkY2w=">
	</div>

	<ul style="justify-content: center; font-size: 25px;">
		<li>Order Multiple items in a single GO.</li>
		<li>We aim to cater to all the food and non-food necessities
			required by households on a daily basis.</li>
		<li>To offer you the best in terms of quality, benefits, flavour,
			and taste we have a well thought out range of products right from
			fresh fruits and Vegetables, Rice and Dals, Spices & Seasonings to
			Snacks & Branded Foods, Beverages, Personal care, Baby care, Home
			care, we have it all.</li>
		<li>We focus on delivering a delightful experience to all our
			customers walking in the store, wherein our highly trained staff will
			not only greet the customers but also assist them regarding any
			queries of the customers.</li>
	</ul>
	<br>
	<hr>
	<hr>
	<br>

	<div style="float: right;" class=image>
		<img style="width: auto; height: 300px; margin-right: 50px;"
			src="https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator.com/article/2020/11/13/online-grocery-shopping-here-to-stay-even-when-normality-returns/11943329-1-eng-GB/Online-grocery-shopping-here-to-stay-even-when-normality-returns.jpg
">
	</div>

	<div class="buyer">
		<h1>Register / Login as a Buyer</h1>
		<button onclick="buyer_register()">Register</button>
		&emsp; &emsp;
		<button onclick="buyer_login()">Login</button>
	</div>
	<div class="shopkeeper">
		<h1>Login as Admin</h1>
		<!-- <button onclick="shopkeeper_register()">Register</button>
		&emsp; -->
		 &emsp; &emsp; &emsp; &emsp; 
		<button onclick="shopkeeper_login()">Login</button>
	</div>
	<br>
	<br>
	<hr>
	<hr>
	<br>
	<div id="form_space">
		<h1 align="center">
			<i> -- Forms will be displayed here -- </i>
		</h1>
	</div>
	<br>
	<br>
	<hr>
	<hr>
	<br>
	<br>
	<div id="foot" style="color: black;">
		<%@ include file="footer.html"%>
	</div>

</body>

<script>

function buyer_register()
{
   document.getElementById("form_space");
   var str = `<div align="center" class="form">
	      <h2> Welcome </h2>
	      <h3> Users form to create an account! </h3>
	      <form  method="post" align="center" action="Buyer_view">
	      <input readonly="readonly" type="text" value ="REGISTER" name="whattype"><br>
	      <label for="name" >Name of the User </label>
	      <input id="name" name="name" type="text"><br>
	      <label for="email">Email &emsp; &emsp; &emsp;</label>
	      <input id="email" name="email" type="email"><br>
	      <label for="password">Password &emsp; &emsp;</>
	      <input id="password" name="password" type="password" ><br>
	      <label for="dob" >Date of Birth &emsp;&emsp;</label>
		  <input id="dob" name="dob" type="date"><br>
	      
	      <button onclick="return is_valid1()" type="text" class="submit">Create Account</button><br>
	      </form>
	    </div>`
   document.getElementById("form_space").innerHTML = str;
}

function buyer_login()
{
	document.getElementById("form_space");
	   var str = `<div align="center" class="form">
		      <h2> Welcome </h2>
		      <h3> Users form to Login into their account! </h3>
		      <form method="post" align="center" action="Buyer_view">
		      <input readonly="readonly" type="text" value ="LOGIN" name="whattype"><br>
		      <label for="email">Email &emsp;</label>
		      <input id="email" name="email" type="email"><br>
		      <label for="password">Password </>
		      <input id="password" name="password" type="password" /><br>
		      
		      <button onclick="return is_valid2()" type="text" class="submit">Login</button><br>
		      </form>
		    </div>`
	   document.getElementById("form_space").innerHTML = str;
}


function shopkeeper_register()
{
   document.getElementById("form_space");
   var str = `<div align="center" class="form">
	      <h2> Welcome </h2>
	      <h3> Vendors form to create an account! </h3>
	      <form method="post" align="center" action="Vendor_view">
	      <input readonly="readonly" type="text" value ="REGISTER" name="whattype"><br>
	      <label for="shop_name" >Name of the Shop / Service </label>
	      <input id="sname" name="shop_name" type="text"><br>
	      <label for="name" >Name of the Vendor &emsp; &emsp;</label>
	      <input id="name" name="name" type="text"><br>
	      <label for="email">Email &emsp; &emsp; &emsp; &emsp; &emsp; </label>
	      <input id="email" name="email" type="email"><br>
	      <label for="password">Password &emsp; &emsp; &emsp; &emsp;</>
	      <input id="password" name="password" type="password" ><br>
	      
	      <button onclick="return is_valid3()" type="text" class="submit">Create Account</button><br>
	      </form>
	    </div>`
   document.getElementById("form_space").innerHTML = str;
}

function shopkeeper_login()
{
   document.getElementById("form_space");
   var str = `<div align="center" class="form">
	      <h2> Welcome </h2>
	      <h3> Vendors form to Login into their account! </h3>
	      <form method="post" align="center" action="Vendor_view">
	      <input readonly="readonly" type="text" value ="LOGIN" name="whattype"><br>
	      <label for="email">Email &nbsp;&nbsp;&nbsp;</label>
	      <input id="email" name="email" type="email"><br>
	      <label for="password">Password </>
	      <input id="password" name="password" type="password" ><br>
	      
	      <button onclick="return is_valid2()" type="text" class="submit">Log in</button><br>
	      </form>
	    </div>`
   document.getElementById("form_space").innerHTML = str;
}

function is_valid1()
{
	var name = document.getElementById("name").value;
	var mail = document.getElementById("email").value;
	  var pwd = document.getElementById("password").value;
	  var dob = document.getElementById("dob").value;
	  
	  var label = "";

	  if(name == "" || mail == "" || dob == "" || pwd == "" )
	  {
	    label = "All Fields are Required";
	  }
	  else if (! (new RegExp("^[a-zA-Z-' ]*$")).test(name)) 
	  {
	    label = "Name Should contain only Characters";
	  }
	  else if (! (new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")).test(mail)) 
	  {
	    label = "Invalid Email";
	  } 
	  else if (pwd.length <= 4) {
	    label = "Password Should contain atleast 5 Letters";
	    //alert(label);
	  }
	  else
	  {
	    label = "All fields are valid";
	    //alert(label);
	    return true;
	  }
	  alert(label);
	  return false;
}

function is_valid2()
{
	
	var mail = document.getElementById("email").value;
	  var pwd = document.getElementById("password").value;
	  
	  
	  var label = "";

	  if(mail == "" || pwd == "" )
	  {
	    label = "All Fields are Required";
	  }
	  else if (! (new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")).test(mail)) 
	  {
	    label = "Invalid Email";
	  } 
	  else if (pwd.length <= 4) {
	    label = "Password Should contain atleast 5 Letters";
	    //alert(label);
	  }
	  else
	  {
	    label = "All fields are valid";
	    //alert(label);
	    return true;
	  }
	  alert(label);
	  return false;
}

function is_valid3()
{
	var sname = document.getElementById("sname").value;
	var name = document.getElementById("name").value;
	var mail = document.getElementById("email").value;
	  var pwd = document.getElementById("password").value;
	  
	  
	  var label = "";

	  if(name == "" || mail == "" || sname == "" || pwd == "" )
	  {
	    label = "All Fields are Required";
	  }
	  else if (! (new RegExp("^[a-zA-Z-' ]*$")).test(name)) 
	  {
	    label = "Name Should contain only Characters";
	  }
	  else if (! (new RegExp("^[a-zA-Z-' ]*$")).test(sname)) 
	  {
	    label = "Shop Name Should contain only Characters";
	  }
	  else if (! (new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")).test(mail)) 
	  {
	    label = "Invalid Email";
	  } 
	  else if (pwd.length <= 4) {
	    label = "Password Should contain atleast 5 Letters";
	    //alert(label);
	  }
	  else
	  {
	    label = "All fields are valid";
	    //alert(label);
	    return true;
	  }
	  alert(label);
	  return false;
}
</script>

</html>