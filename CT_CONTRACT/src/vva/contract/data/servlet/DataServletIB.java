package vva.contract.data.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import vva.contract.data.db.interbase.IBRequest;

/**
 * Servlet implementation class DataServletIB
 */
@WebServlet("/DataServletIB")
public class DataServletIB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataServletIB() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("windows-1251");
		response.setHeader("Content-Type", "application/json");
		
	String autoComplete="";
	String textAutocomplete="";
	if(request.getParameter("query")!=null){
		textAutocomplete=new String(request.getParameter("query").getBytes("ISO-8859-1"));
		textAutocomplete=URLDecoder.decode(textAutocomplete,"windows-1251");
		System.out.println("query:+++++++++++"+textAutocomplete);
	}
	
	
	String callback=request.getParameter("callback");
	String start=request.getParameter("start")!=null?request.getParameter("start"):"1";
	String limit=request.getParameter("limit")!=null?request.getParameter("limit"):"100";




if(request.getParameter("autoComplete")!=null){
	autoComplete=new String(request.getParameter("autoComplete").getBytes("ISO-8859-1"));
	System.out.println("autoComplete:"+autoComplete);
	PrintWriter out = response.getWriter();
	
	try {
		IBRequest ibRequest = new IBRequest();
		ibRequest.autocomplete_NOM_DOG_IB(textAutocomplete,start,limit);
		
		JSONArray arrayObj = new JSONArray();
		while (ibRequest.rs.next()){			
			JSONObject jon = new JSONObject();				
			jon.put("NOM_DOG", ibRequest.rs.getString("NOM_DOG"));
			arrayObj.put(jon);
		}		
		JSONObject sendJSONObj = new JSONObject();
		sendJSONObj.put("data", arrayObj);
		sendJSONObj.put("totalCount", ibRequest.getCountContract_IB());
		
		out.println(callback + "(" + sendJSONObj.toString() + ");");
		out.close();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}else{
		
		
		
		
		PrintWriter out = response.getWriter();
		
		try {
			IBRequest ibRequest = new IBRequest();
			ibRequest.getAllContracts_IB(start,limit);
			JSONArray arrayObj = new JSONArray();
			while (ibRequest.rs.next()){
				
			//	System.out.println(ibRequest.rs.getString(1));
				
				JSONObject jon = new JSONObject();
					jon.put("I", ibRequest.rs.getString("i"));
					jon.put("ID_DOG", ibRequest.rs.getString("ID_DOG"));
					jon.put("KONTROL", ibRequest.rs.getString("KONTROL"));
					jon.put("ID_COUNT", ibRequest.rs.getString("ID_COUNT"));
					jon.put("ID_ACCOUNT", ibRequest.rs.getString("ID_ACCOUNT"));
					jon.put("NAMEDOG", ibRequest.rs.getString("NAMEDOG"));
					jon.put("NOM_DOG", ibRequest.rs.getString("NOM_DOG"));
					jon.put("DATA_W", ibRequest.rs.getString("DATA_W"));
					jon.put("SROK_PLAT", ibRequest.rs.getString("SROK_PLAT"));
					jon.put("SUMMA", ibRequest.rs.getString("SUMMA"));
					jon.put("CURRENCY", ibRequest.rs.getString("CURRENCY"));
					jon.put("NOTE", ibRequest.rs.getString("NOTE"));
					jon.put("IS_DEL", ibRequest.rs.getString("IS_DEL"));
					jon.put("USER_FIO", ibRequest.rs.getString("USER_FIO"));
					jon.put("STATUS", ibRequest.rs.getString("STATUS"));
					jon.put("FULLNAMEDOG", ibRequest.rs.getString("FULLNAMEDOG"));
					jon.put("PRIM", ibRequest.rs.getString("PRIM"));
					jon.put("USL_POST", ibRequest.rs.getString("USL_POST"));
					//jon.put("KOD1C", ibRequest.rs.getString("KOD1C"));
					jon.put("DATE_STATUS", ibRequest.rs.getString("DATE_STATUS"));
					jon.put("REG_NOM", ibRequest.rs.getString("REG_NOM"));
					jon.put("REG_DATE", ibRequest.rs.getString("REG_DATE"));
					jon.put("REG_SECT", ibRequest.rs.getString("REG_SECT"));
					jon.put("REG_INDEX", ibRequest.rs.getString("REG_INDEX"));
					jon.put("FULL_NUM", ibRequest.rs.getString("FULL_NUM"));
					jon.put("USER_FIO1", ibRequest.rs.getString("USER_FIO1"));				
				arrayObj.put(jon);

			}
			
			JSONObject sendJSONObj = new JSONObject();
			sendJSONObj.put("data", arrayObj);
			sendJSONObj.put("totalCount", ibRequest.getCountContract_IB());
			
			out.println(callback + "(" + sendJSONObj.toString() + ");");
			out.close();
			
		    //ibRequest.create100Random();
			//ibRequest.create100RandomrightHolder();
			//ibRequest.create100Customer();
			//ibRequest.create100PERFORMERS();
			//ibRequest.disconnect();			
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
		
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
	String autoComplete="";
	if(request.getParameter("autoComplete")!=null){
		autoComplete=new String(request.getParameter("autoComplete").getBytes("ISO-8859-1"));
		System.out.println("autoComplete:"+autoComplete);
		
		Enumeration en = request.getParameterNames();
        while(en.hasMoreElements()) {
            // Get the name of the request parameter
            String name = (String)en.nextElement();
            System.out.println(name);
 
            // Get the value of the request parameter
            String value = request.getParameter(name);
 
            // If the request parameter can appear more than once in the query string, get all values
            String[] values = request.getParameterValues(name);
 
            for (int i=0; i<values.length; i++) {
            	System.out.println(" " + values[i]);
            }
        }
		
		
	}
	
		
	}

}
