

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
// import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
// import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DelFromCart")
public class DelFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String docType = "<!DOCTYPE HTML>\n";
		String title = "E_Store : For all your Needs";

		out.println(docType + "<HTML>\n" + "<HEAD><TITLE>" + title + "</TITLE></HEAD>\n" + "<BODY BGCOLOR=\"#FDF5E6\">\n");

		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template2 = "DELETE FROM CART WHERE ITEM_ID = ? AND BUYER_EMAIL = ?";
		HttpSession session = request.getSession();
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);
			
			if(request.getParameter("rem") != null)
			{
				if (request.getParameter("rem").equals("Remove From Cart")) 
				{
				PreparedStatement query = con.prepareStatement(template2);
				query.setInt(1, Integer.valueOf(request.getParameter("Id")));
				query.setString(2, (String) session.getAttribute("user"));

				int rs = query.executeUpdate();

				if (rs >= 1) 
				{
					out.println(
							"<h1>ITEM DELETED SUCCESFULLY</h1>");
				} 
				else {
					out.println("<H1>SOMETHING WENT WRONG</H1>");
				}

				}
			}
			
			
			con.close();
		} catch (Exception ex) {
			out.println(ex);
			// out.println((String) ex.printStackTrace());
			out.println("Something went wrong. An exception Occured. You Will be Redirected to Home page again.");
		}
		out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Buyer_home.jsp\"");
		out.println("</BODY>\n" + "</HTML>");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}
}
