
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Add_item")
public class Add_item extends HttpServlet {
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
		String template2 = "INSERT INTO ITEMS VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

		try 
		{
			HttpSession session = request.getSession();
			//out.println(session.getAttribute("user"));

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, password);

			PreparedStatement inserter = con.prepareStatement(template2);
			inserter.setInt(1, Integer.parseInt(request.getParameter("itemid")));
			inserter.setString(2, request.getParameter("name"));
			inserter.setString(3, request.getParameter("category"));
			inserter.setInt(4, Integer.parseInt(request.getParameter("quantity")));
			inserter.setFloat(5, Float.parseFloat(request.getParameter("price")));
			inserter.setString(6, request.getParameter("image"));
			inserter.setString(7, request.getParameter("desc"));
			inserter.setString(8, (String) session.getAttribute("user"));
			inserter.executeUpdate();

			//out.println("<script> alert(\"Item is Added Successfully\"); </script>");
			
			String encodedURL = response.encodeRedirectURL("Vendor_home.jsp");
			response.sendRedirect(encodedURL);
			
			//out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Vendor_home.jsp\"");

		} catch (Exception ex) {
			out.println(ex);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

}
