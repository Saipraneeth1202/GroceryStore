

import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.Connection;
// import java.sql.Date;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
// import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Page10")
public class Page10 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String docType = "<!DOCTYPE HTML>\n";
		String title = "E_Store : For all your Needs";

		out.println(docType + "<HTML>\n" + "<HEAD><TITLE>" + title + "</TITLE></HEAD>\n" + "<BODY BGCOLOR=\"#FDF5E6\">\n");
		HttpSession session = request.getSession();
		try {
			if(request.getParameter("go") != null)
			{
				if (request.getParameter("go").equals("GO"))
				{
					int k = Integer.parseInt(request.getParameter("pgno"));
					session.setAttribute("numpg", Integer.toString(k));
					out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Buyer_home.jsp\"");
				}
			}
			else {
				if(request.getParameter("next") != null)
				{
					if (request.getParameter("next").equals("Next Page")) 
					{
						String str = (String) session.getAttribute("pagecount");
						int pgcount = Integer.valueOf(str);
						
						int m = Integer.parseInt(request.getParameter("pgno"));
						
						pgcount = pgcount + m;
						session.setAttribute("pagecount", Integer.toString(pgcount));
						session.setAttribute("numpg", Integer.toString(m));
						out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Buyer_home.jsp\"");
					}
				}
				else 
				{
					String str = (String) session.getAttribute("pagecount");
					int pgcount = Integer.valueOf(str);
					int m = Integer.parseInt(request.getParameter("pgno"));
					pgcount = pgcount - m;
					session.setAttribute("pagecount", Integer.toString(pgcount));
					out.print("<META http-equiv=\"refresh\" content=\"0;URL=http://localhost:8080/E_Store/Buyer_home.jsp\"");

				}
			}
		} 
		catch (Exception ex) {
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
