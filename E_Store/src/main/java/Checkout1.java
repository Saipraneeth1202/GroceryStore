

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
// import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Checkout1")
public class Checkout1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		
		String docType = "<!DOCTYPE HTML>\n";
		String title = "E_Store : For all your Needs";

		out.println(docType + "<HTML>\n" + "<HEAD><TITLE>" + title + "</TITLE></HEAD>\n" + "<BODY BGCOLOR=\"#FDF5E6\">\n");

		if (session.getAttribute("user") == null) 
		{
			out.println("<H1><I> SESSION TIMED OUT. YOU WILL BE REDIRECTED TO HOME PAGE AGAIN <I> </H1>");
			out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/E_Store/Main_Interface.jsp\"");
			//return;
		}
		//int count = 0;
		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template = "SELECT ITEM_ID, NAME, QUANTITY FROM CART WHERE BUYER_EMAIL= ?";
		String template1 = "SELECT STOCK FROM ITEMS WHERE ITEM_ID = ? AND NAME = ?";
		String template2 = "UPDATE ITEMS SET STOCK = ? WHERE ITEM_ID = ? AND NAME = ?";
		
		String template3 = "DELETE FROM CART WHERE BUYER_EMAIL = ?";
		
		String template4 = "SELECT ITEM_ID, NAME, QUANTITY, VENDOR_EMAIL FROM CART WHERE BUYER_EMAIL= ?";
		String template5 = "INSERT INTO TRANSACTIONS VALUES (?, ?, ?, ?, ?, ?)";
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template, ResultSet.TYPE_SCROLL_SENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
			query.setString(1, (String) session.getAttribute("user"));

			ResultSet rs = query.executeQuery();
			
			if (!rs.next()) {
				out.println(
				"<h1 align=\"center\"><I>No items Found</I></h1>");
			} 
			else 
			{
				String name = "";
				int id = 1 , quantity = 1, STOCK = 1;
				//java.sql.ResultSetMetaData rsmd = rs.getMetaData();
				
				rs.beforeFirst();
				
				while (rs.next()) 
				{
					id = Integer.parseInt(rs.getString(1));	
					name = rs.getString(2);
					quantity = Integer.parseInt(rs.getString(3));
				
			
					PreparedStatement query1 = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					
					con.setAutoCommit(false);
					
					query1.setInt(1, id);
					query1.setString(2, name);

					ResultSet rs1 = query1.executeQuery();
				
			
					if(rs1.next())
					{
						STOCK = Integer.parseInt(rs1.getString(1));
					}	
				
				
					PreparedStatement query2 = con.prepareStatement(template2, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					query2.setInt(1, STOCK - quantity);
					query2.setInt(2, id);
					query2.setString(3, name);
				
					int rs2 = query2.executeUpdate();
				
			
				// Adding a Transaction at the end 
				
					PreparedStatement query4 = con.prepareStatement(template4, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					query4.setString(1, (String) session.getAttribute("user"));
				
					PreparedStatement inserter = con.prepareStatement(template5, ResultSet.TYPE_SCROLL_SENSITIVE,
						ResultSet.CONCUR_UPDATABLE);
				
					ResultSet rs3 = query4.executeQuery();
				
					String user1 = (String) session.getAttribute("user");
					LocalDate dateObj = LocalDate.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
					String dop = dateObj.format(formatter);
		        
			
					while (rs3.next()) 
					{
						inserter.setInt(1, Integer.parseInt(rs3.getString(1)));
						inserter.setString(2, rs3.getString(2));
						inserter.setInt(3, Integer.parseInt(rs3.getString(3)));
						inserter.setString(4, user1);
						inserter.setString(5, rs3.getString(4));
						inserter.setDate(6, Date.valueOf(dop));
					
						inserter.executeUpdate();
					
					}
				}	
				// Deleting the Cart
				
				PreparedStatement query3 = con.prepareStatement(template3, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				query3.setString(1, (String) session.getAttribute("user"));
				
				int rs4 = query3.executeUpdate();
				
				con.commit(); 		//con.rollback();
				
				con.close();
				out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Checkout.jsp\"");

		}
		}
		catch (Exception ex) {
			out.println(ex);
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}


}
