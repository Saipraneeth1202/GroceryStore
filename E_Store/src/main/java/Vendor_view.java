
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Vendor_view")
public class Vendor_view extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String docType = "<!DOCTYPE HTML>\n";
		String title = "E_Store : For all your Needs";

		out.println(
				docType + "<HTML>\n" + "<HEAD><TITLE>" + title + "</TITLE></HEAD>\n" + "<BODY BGCOLOR=\"#FDF5E6\">\n");

		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template1 = "SELECT EMAIL, PASSWORD FROM VENDOR_DETAILS WHERE EMAIL=?";
		String template2 = "INSERT INTO VENDOR_DETAILS VALUES(?, ?, ?, ?)";

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			if (request.getParameter("whattype").equals("REGISTER")) {
				PreparedStatement query = con.prepareStatement(template1);
				String temp = request.getParameter("email");
				query.setString(1, temp);

				ResultSet rs = query.executeQuery();

				if (rs.next()) {
					out.println(
							"<h1>Vendor already exists. You need to Click on Login. You will be redirected to home page again : )</h1>");
				} else {

					PreparedStatement inserter = con.prepareStatement(template2);
					inserter.setString(1, request.getParameter("shop_name"));
					inserter.setString(2, request.getParameter("name"));
					inserter.setString(3, request.getParameter("email"));
					inserter.setString(4, request.getParameter("password"));
					
					inserter.executeUpdate();

					out.println(
							"<h1>You have successfully registered : ) You will be redirected to a web page in 2 seconds </h1>");
					HttpSession session = request.getSession();
					session.setAttribute("user", request.getParameter("email"));
					out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/E_Store/Vendor_home.jsp\"");
				}
			} else {
				PreparedStatement query = con.prepareStatement(template1);
				query.setString(1, request.getParameter("email"));

				ResultSet rs = query.executeQuery();

				if (!rs.next()) {
					out.println(
							"<h1>Vendor Not Found. You Need to Register before Login if you are a new Vendor. You Will be Redirected to Home page again: )</h1>");
				} else if (!request.getParameter("password").equals(rs.getString(2))) {
					out.println(
							"<h1>Password is Incorrect. You will be redirected to home page. Please try logging again</h1>");
				} else {
					out.println("<h1>Weclome Back " + request.getParameter("email")
							+ " You will be redirected to the web page in 2 seconds </h1>");
					HttpSession session = request.getSession();
					session.setAttribute("user", request.getParameter("email"));
					out.print("<META http-equiv=\"refresh\" content=\"2;URL=http://localhost:8080/E_Store/Vendor_home.jsp\"");
				}

			}

			con.close();
		} catch (Exception ex) {
			out.println(ex);
			Logger lgr = Logger.getLogger(Buyer_view.class.getName());
			lgr.log(Level.SEVERE, ex.getMessage(), ex);
		}
		out.print("<META http-equiv=\"refresh\" content=\"3;URL=http://localhost:8080/E_Store/Main_Interface.jsp\"");
		out.println("</BODY>\n" + "</HTML>");

		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

}
