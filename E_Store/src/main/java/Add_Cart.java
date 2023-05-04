

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Add_Cart")
public class Add_Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		//RequestDispatcher reqDis = request.getRequestDispatcher("/Vendor_home.jsp");
		//reqDis.include(request, response);

		String url = "jdbc:mysql://localhost:3306/E_STORE";
		String user = "root";
		String password = "password";
		String template1  = "SELECT * FROM ITEMS WHERE ITEM_ID = ? AND NAME = ?";
		String template2 = "INSERT INTO CART VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

		try 
		{
			HttpSession session = request.getSession();
			//out.println(session.getAttribute("user"));

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement query = con.prepareStatement(template1, ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			query.setInt(1, Integer.parseInt(request.getParameter("Id")));
			query.setString(2, request.getParameter("NAME"));
			
			ResultSet rs = query.executeQuery();
			rs.next();
			
			PreparedStatement inserter = con.prepareStatement(template2);
			inserter.setInt(1, Integer.parseInt(request.getParameter("Id")));
			inserter.setString(2, request.getParameter("NAME"));
			inserter.setString(3, rs.getString(3));
			inserter.setInt(4, Integer.parseInt(request.getParameter("number1")));
			inserter.setFloat(5, Float.parseFloat(rs.getString(5)));
			inserter.setString(6, rs.getString(6));
			inserter.setString(7, rs.getString(8));
			inserter.setString(8, (String) session.getAttribute("user"));
			
			
			
			inserter.executeUpdate();
			
			out.println("Item is Added to Cart Successfully");
			
			String encodedURL = response.encodeRedirectURL("Buyer_home.jsp");
			response.sendRedirect(encodedURL);
			
			//out.print("<META http-equiv=\"refresh\" content=\"5;URL=http://localhost:8080/E_Store/Buyer_home.jsp\"");

		} catch (Exception ex) {
			out.println(ex);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

}
