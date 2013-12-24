package vva.contract.data.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import vva.contract.data.db.SQLRequest;

/**
 * Servlet implementation class DataServlet
 */
@WebServlet("/DataServlet")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String callback=request.getParameter("callback");
		String start=request.getParameter("start")!=null?request.getParameter("start"):"1";
		String limit=request.getParameter("limit")!=null?request.getParameter("limit"):"100";
		String autoComplete=request.getParameter("autoComplete");
		
		response.setCharacterEncoding("windows-1251");
		response.setHeader("Content-Type", "application/json");
		
		
		PrintWriter out = response.getWriter();
		
		/*
		if(autoComplete.equals("customer")){
			try {
				SQLRequest sqlRequest = new SQLRequest();
				sqlRequest.getAutoComplete_CUSTOMERS();
				JSONArray arrayObj = new JSONArray();
				while (sqlRequest.rs.next()){
					
					System.out.println(sqlRequest.rs.getString(1));
					
					JSONObject jon = new JSONObject();
					jon.put("id", sqlRequest.rs.getString(1));
					
					arrayObj.put(jon);
					
				}
				
				JSONObject sendJSONObj = new JSONObject();
				sendJSONObj.put("data", arrayObj);
				sendJSONObj.put("totalCount", sqlRequest.getCountContract());
				
				out.println(callback + "(" + sendJSONObj.toString() + ");");
				out.close();
				
			    //sqlRequest.create100Random();
				//sqlRequest.create100RandomrightHolder();
				//sqlRequest.create100Customer();
				//sqlRequest.create100PERFORMERS();
				//sqlRequest.disconnect();			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		else*/
		{
			
			try {
				SQLRequest sqlRequest = new SQLRequest();
				sqlRequest.getAllContracts(start,limit);
				JSONArray arrayObj = new JSONArray();
				while (sqlRequest.rs.next()){
					
					System.out.println(sqlRequest.rs.getString(1));
					
					JSONObject jon = new JSONObject();
					jon.put("ID", sqlRequest.rs.getString("ID"));
					jon.put("DEPARTMENT_ID", sqlRequest.rs.getString("DEPARTMENT_ID"));
					jon.put("NUM", sqlRequest.rs.getString("NUM"));
					jon.put("THEME", sqlRequest.rs.getString("THEME"));
					jon.put("SESSION_USER", sqlRequest.rs.getString("SESSION_USER"));
					jon.put("DATE_REG", sqlRequest.rs.getString("DATE_REG"));
					jon.put("DEADLINE", sqlRequest.rs.getString("DEADLINE"));
					jon.put("CUSTOMER", sqlRequest.rs.getString("CUSTOMER"));
					jon.put("PERFORMANCE", sqlRequest.rs.getString("PERFORMANCE"));
					jon.put("RIGHTHOLDER", sqlRequest.rs.getString("RIGHTHOLDER"));
					
					arrayObj.put(jon);
					
				}
				
				JSONObject sendJSONObj = new JSONObject();
				sendJSONObj.put("data", arrayObj);
				sendJSONObj.put("totalCount", sqlRequest.getCountContract());
				
				out.println(callback + "(" + sendJSONObj.toString() + ");");
				out.close();
				
			    //sqlRequest.create100Random();
				//sqlRequest.create100RandomrightHolder();
				//sqlRequest.create100Customer();
				//sqlRequest.create100PERFORMERS();
				//sqlRequest.disconnect();			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
