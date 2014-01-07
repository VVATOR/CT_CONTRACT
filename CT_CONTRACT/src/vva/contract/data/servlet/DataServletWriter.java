package vva.contract.data.servlet;

import java.io.IOException;
import java.net.URLDecoder;

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
		
		System.out.println("1: "+new String(request.getParameter("rus")));
		
		//System.out.println("2: "+URLDecoder.decode(new String(request.getParameter("rus"));
		System.out.println("3: "+new String(request.getParameter("rus").getBytes("ISO-8859-1"),"windows-1251"));
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
