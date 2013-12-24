package vva.contract.data.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vva.contract.data.db.SQLRequest;

@WebServlet("/DataServletWriter")
public class DataServletWriter extends HttpServlet {
	   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String callback=request.getParameter("");
		SQLRequest sqlRequest;
		
		try {			
			sqlRequest = new SQLRequest();
			int a=sqlRequest.insertSql(   "INSERT INTO CT_ALLCONTRACTS"
										+ " (ID, DEADLINE, SESSION_USER, DEPARTMENT_ID, NUM, ID_RIGHTHOLDERS, ID_CUSTOMERS, ID_PERFORMANCES, THEME, DATE_REG)"
										+ "  VALUES"
										+ "((SELECT MAX(ID) + 1 AS FREE_ID FROM CT_ALLCONTRACTS), "	
										+ " '16.06.1991', 'VVV', 11, 'rg', 10, 12, 31, 'hh', '20.02.2012')");
			if (a>0)
			System.out.println("vstavleno: "+a+" zapisey");	
			else
			System.out.println("NE vstavleno");	
			
			//response.sendRedirect("index.jsp");
		//	response.
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
