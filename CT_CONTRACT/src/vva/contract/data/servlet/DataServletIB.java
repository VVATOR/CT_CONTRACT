package vva.contract.data.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
		System.out.println("Encoding: " + response.getCharacterEncoding());
		
		response.setCharacterEncoding("windows-1251");
		// response.setContentType("text/html; charset=Windows-1251");
		
		
		
		response.setHeader("Content-Type", "application/json");
		
		
		
		/*
		 // Кодировка сообщений, использованная engine
		   // Некоторые используют ISO-8859-1, некоторые кодировку
		   // по умолчанию - единообразия тут нет
		   String requestEnc = "ISO-8859-1";

		   // Кодировка, установленная в броузере
		   String clientEnc = request.getParameter("charset");

		   if( clientEnc==null ) clientEnc="Cp1251";

		   // Получение параметра
		   String fCustomer = request.getParameter("fCustomer");

		   // 
		   if( fCustomer!=null )
			   fCustomer = new String(fCustomer.getBytes(requestEnc),clientEnc);
		System.out.println("99999: "+fCustomer);
		*/
		String fCustomer=new String(request.getParameter("fCustomer").getBytes("ISO-8859-1"),"utf-8");
		/*String s=fCustomer;
		System.out.println("sop5  :"+ fCustomer);
		
		try{
		 fCustomer=new String(s.getBytes(),"utf-8");
		System.out.println("333333333333333333333333333333333333333333333: "+fCustomer);
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		*/
		
		
		
		System.out.println("Encoding: " + response.getCharacterEncoding());
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



	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// фильтр
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("Encoding: " + response.getCharacterEncoding());
	System.out.println("АБВ\u0410\u0411\u0412");
	if(request.getParameter("fCustomer")!=null){
		System.out.println(new String( request.getParameter("fCustomer").getBytes("ISO-8859-1"), "Cp1251" ));

		System.out.println("sop0  :"+URLDecoder.decode(new String(request.getParameter("fCustomer")),"utf-8"));
		System.out.println("sop01 :"+URLDecoder.decode(new String(request.getParameter("fCustomer")),"windows-1251"));
		
		
		System.out.println("sop1  :"+ request.getParameter("fCustomer"));
		System.out.println("sop2  :"+ request.getParameter("fCustomer").getBytes("utf-8"));
		System.out.println("sop3  :"+ request.getParameter("fCustomer").getBytes("ISO-8859-1"));
		System.out.println("sop4  :"+ request.getParameter("fCustomer").getBytes("windows-1251"));
		
		System.out.println("sop4  :"+"Элорлорлор");
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("utf-8")),"windows-1251"));
	
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("windows-1251")),"utf-8"));
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer")),"utf-8"));
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer")),"windows-1251"));
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer")),"ISO-8859-1"));		
			
		
		
		
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")),"utf-8"));
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")),"windows-1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")));
		System.out.println("sop6  :"+ request.getParameter("fCustomer").getBytes("utf-8"));
		
		System.out.println("sop7  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer")),"windows-1251"));
		System.out.println("sop8  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("utf-8")),"windows-1251"));	
		
		fCustomer = new String(request.getParameter("fCustomer").getBytes("utf-8"));
		fCustomer = URLDecoder.decode(fCustomer,"windows-1251").trim();
		System.out.println(fCustomer);
		
		
		
		System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("ISO-8859-5")),"windows-1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-5")));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-5"),"KOI8_R"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-5"),"windows-1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-1"),"windows-1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")).getBytes("Cp1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")).getBytes("windows-1251"));
		System.out.println("sop5  :"+ new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")).getBytes("Cp1251"));
	//	System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer")).getBytes("ISO-8859-5"),"windows-1251"));
		
		//System.out.println("sop5  :"+ URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("ISO-8859")),"windows-1251"));
	}
	
	String fPerformer="";
	if(request.getParameter("fPerformer")!=null){
		fPerformer = new String(request.getParameter("fPerformer").getBytes("windows-1251"));
		fPerformer = URLDecoder.decode(fPerformer,"windows-1251").trim();
		System.out.println(fPerformer);
	}
	
	String fRightholder="";
	if(request.getParameter("fRightholder")!=null){
		fRightholder = new String(request.getParameter("fRightholder").getBytes("ISO-8859-1"));
		fRightholder = URLDecoder.decode(fRightholder,"windows-1251").trim();
		System.out.println(fRightholder);
	}

	System.out.println("000000000000000000000000000000000000000000000000 : "+fCustomer+fPerformer+fRightholder);
	//System.out.println("sop5  :"+URLDecoder.decode(new String(request.getParameter("fCustomer").getBytes("ISO-8859-1")),"utf-8"));
	
System.out.println("=================================================================================================");
System.out.println("ПАРАМЕТРЫ");
System.out.println("=================================================================================================");
		
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
		

System.out.println("=================================================================================================");	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
		
		PrintWriter out = response.getWriter();
		
		
		try {
			IBRequest ibRequest = new IBRequest();
			ibRequest.getAllContractsWithFilter_IB(start,limit);
			JSONArray arrayObj = new JSONArray();
			while (ibRequest.rs.next()){
				
			//	System.out.println(ibRequest.rs.getString(1));
				
				JSONObject jon = new JSONObject();
					jon.put("I", ibRequest.rs.getString("i"));
					jon.put("ID_DOG", ibRequest.rs.getString("ID_DOG"));
					jon.put("KONTROL", fCustomer+ ibRequest.rs.getString("KONTROL"));
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	
	
		
	}

}
