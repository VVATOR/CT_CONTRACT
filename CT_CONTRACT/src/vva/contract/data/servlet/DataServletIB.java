package vva.contract.data.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import sun.util.resources.CalendarData;
import vva.contract.data.db.interbase.IBRequest;

/**
 * Servlet implementation class DataServletIB
 */
@WebServlet("/DataServletIB")
public class DataServletIB extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
	 * parametrs for filtering 
	 */
	private String cbF_FULLNAMEDOG="";
	private String cbF_RESULTDOG="";
	private String cbF_RIGHTHOLDER="";
	private String cbF_SUBDOG_INPROCESS="";
	private String cbF_SUBDOG_PRED="";
	private String cbF_PERFORMER="";
	private String cbF_COUNTERAGENT_FNAME="";
	
		
	
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
		response.setHeader("Cache-Control", "no-cache");
		/////////////////////////////////////////////////////////////////////
		/// set content encoding for response
		/////////////////////////////////////////////////////////////////////
		System.out.println("Encoding: " + response.getCharacterEncoding());		
		
		response.setCharacterEncoding("windows-1251");
		// response.setContentType("text/html; charset=Windows-1251");
		response.setHeader("Content-Type", "application/json");
		
		System.out.println("Encoding: " + response.getCharacterEncoding());
		/////////////////////////////////////////////////////////////////////
		
		prepareParam(request);
	
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
// ÙËÎ¸Ú
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
String cbF_FULLNAMEDOG="";
	if(request.getParameter("cbF_FULLNAMEDOG")!=null){
		try{
		cbF_FULLNAMEDOG=new String(request.getParameter("cbF_FULLNAMEDOG").getBytes("ISO-8859-1"),"utf-8");
		System.out.println("cbF_FULLNAMEDOG==========: "+cbF_FULLNAMEDOG);
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}			
		/*String s=fCustomer;
		System.out.println("sop5  :"+ fCustomer);
		try{
			fCustomer=new String(s.getBytes(),"utf-8");
		System.out.println("333333333333333333333333333333333333333333333: "+fCustomer);
		}catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}*/		
	}

/*String fPerformer="";
	if(request.getParameter("fPerformer")!=null){
		try{
			fPerformer=new String(request.getParameter("fPerformer").getBytes("ISO-8859-1"),"utf-8");
		System.out.println("fPerformer==========: "+fPerformer);
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}			
	}
	
String fRightholder="";
	if(request.getParameter("fRightholder")!=null){
		try{
			fRightholder=new String(request.getParameter("fRightholder").getBytes("ISO-8859-1"),"utf-8");
		System.out.println("fRightholder==========: "+fRightholder);
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}			
	}*/

/*	
System.out.println("=================================================================================================");
System.out.println("œ¿–¿Ã≈“–€");
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
*/	
	
		
		PrintWriter out = response.getWriter();
		
		
		try {
			IBRequest ibRequest = new IBRequest();
			ibRequest.getAllContractsWithFilter_IB( start,limit,
													cbF_FULLNAMEDOG,//,""
													cbF_RESULTDOG,//"",//"F_RESULTDOG",///
													cbF_RIGHTHOLDER,//"",//"F_RIGHTHOLDER",
													cbF_SUBDOG_INPROCESS,//"",//"F_SUBDOG_INPROCESS",
													cbF_SUBDOG_PRED,//"",//"F_SUBDOG_PRED",
													cbF_PERFORMER,//"",//"F_PERFORMER",
													cbF_COUNTERAGENT_FNAME//""//"F_COUNTERAGENT_FNAME"
													);
			
			//IBRequest ibReqPerformer = new IBRequest();
			//ibReqPerformer.getAllPerformerWithFilter_IB(start,limit);
			
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
					
					
					SimpleDateFormat sdf_DATA_W = new SimpleDateFormat("dd.mm.yyyy");
					jon.put("DATA_W", sdf_DATA_W.format(ibRequest.rs.getDate("DATA_W")));
					
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
					
					SimpleDateFormat sdf_REG_DATE = new SimpleDateFormat("dd.mm.yyyy");
					jon.put("REG_DATE", sdf_DATA_W.format(ibRequest.rs.getDate("REG_DATE")));

					jon.put("REG_SECT", ibRequest.rs.getString("REG_SECT"));
					jon.put("REG_INDEX", ibRequest.rs.getString("REG_INDEX"));
					
					jon.put("RESULTDOG", ibRequest.rs.getString("RESULTDOG"));
					
					jon.put("FULL_NUM", ibRequest.rs.getString("FULL_NUM"));
					jon.put("USER_FIO1", ibRequest.rs.getString("USER_FIO1"));		

																						//System.out.print(ibRequest.rs.getString("ID_DOG")+"[");
																						/*	String performers="";	
																							
																							//ibReqPerformer.rs(TYPE_SCROLL_INSENSITIVE);
																							//ibReqPerformer.rs.next();
																									while(ibReqPerformer.rs.next() 
																										 )
																									{	
																										if(ibReqPerformer.rs.getString("id_dog").equals(ibRequest.rs.getString("id_dog"))){
																									      performers+=ibReqPerformer.rs.getString("performer")+ "<br>";
																									      System.out.print(ibReqPerformer.rs.getString("id_dog")+";");
																									}
																									}		
																									
																				System.out.println("]");
																						 */

					
					jon.put("counteragent_fname",ibRequest.rs.getString("counteragent_fname"));
					jon.put("performer",ibRequest.rs.getString("performer"));
					jon.put("rightholder",ibRequest.rs.getString("rightholder"));
					jon.put("subdog_pred",ibRequest.rs.getString("subdog_pred"));
					jon.put("subdog_inProcess",""+ibRequest.rs.getString("subdog_inProcess"));
					
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
	
	
	
	
	public void prepareParam(HttpServletRequest request){
		if(request.getParameter("cbF_FULLNAMEDOG")!=null){
			try{
				cbF_FULLNAMEDOG=new String(request.getParameter("cbF_FULLNAMEDOG").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_FULLNAMEDOG="";}
		System.out.println("prepareParam (cbF_FULLNAMEDOG: "+cbF_FULLNAMEDOG);
		
		if(request.getParameter("cbF_RESULTDOG")!=null){
			try{
				cbF_RESULTDOG=new String(request.getParameter("cbF_RESULTDOG").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_RESULTDOG="";}
		System.out.println("prepareParam (cbF_RESULTDOG: "+cbF_RESULTDOG);

		if(request.getParameter("cbF_RIGHTHOLDER")!=null){
			try{
				cbF_RIGHTHOLDER=new String(request.getParameter("cbF_RIGHTHOLDER").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_RIGHTHOLDER="";}
		System.out.println("prepareParam (cbF_RIGHTHOLDER: "+cbF_RIGHTHOLDER);

		if(request.getParameter("cbF_SUBDOG_INPROCESS")!=null){
			try{
				cbF_SUBDOG_INPROCESS=new String(request.getParameter("cbF_SUBDOG_INPROCESS").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_SUBDOG_INPROCESS="";}
		System.out.println("prepareParam (cbF_SUBDOG_INPROCESS: "+cbF_SUBDOG_INPROCESS);

		if(request.getParameter("cbF_SUBDOG_PRED")!=null){
			try{
				cbF_SUBDOG_PRED=new String(request.getParameter("cbF_SUBDOG_PRED").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_SUBDOG_PRED="";}
		System.out.println("prepareParam (cbF_SUBDOG_PRED: "+cbF_SUBDOG_PRED);

		if(request.getParameter("cbF_PERFORMER")!=null){
			try{
				cbF_PERFORMER=new String(request.getParameter("cbF_PERFORMER").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_PERFORMER="";}
		System.out.println("prepareParam (cbF_PERFORMER: "+cbF_PERFORMER);

		if(request.getParameter("cbF_COUNTERAGENT_FNAME")!=null){
			try{
				cbF_COUNTERAGENT_FNAME=new String(request.getParameter("cbF_COUNTERAGENT_FNAME").getBytes("ISO-8859-1"),"utf-8");
			}
			catch(UnsupportedEncodingException e)
			{e.printStackTrace();}			
		}else{cbF_COUNTERAGENT_FNAME="";}
		System.out.println("prepareParam (cbF_COUNTERAGENT_FNAME: "+cbF_COUNTERAGENT_FNAME);

		
	}
	
	
	

}
