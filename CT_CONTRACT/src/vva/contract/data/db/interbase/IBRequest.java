package vva.contract.data.db.interbase;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class IBRequest{
	
	private IBConnection ibC = null;
	public Statement stmt = null;
	public ResultSet rs   = null;
	private int iQUERY_TIMEOUT=300;
	
	public IBRequest() throws Exception {
	    // TODO Auto-generated constructor stub
    	ibC = new IBConnection("IHVOST", "15111987", "bl-databases", "3050", "e:/Ibdata/IRINA", "MTS.GDB", "windows-1251");
    	ibC.getConnection();    	
    	stmt = (Statement) ibC.getCon().createStatement();
    }
    //
    public void Disconnect() throws Exception{
    	if(rs!=null){rs.close(); }
    	if(stmt!=null){	stmt.close(); }
    	ibC.disconnect();    	 
    }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
    
    public void getAllContracts_IB(String start,String limit) throws SQLException{
    	String sql="SELECT * FROM GET_NUMPP_DOGOVORA where GET_NUMPP_DOGOVORA.i>"+start+" and GET_NUMPP_DOGOVORA.i<=("+start+"+"+limit+")";

    	
    	//String gen_dog="set generator gen_dog to 0;";
    	///stmt.executeUpdate(gen_dog);
    	
    //	System.out.println("da");
    	stmt.setQueryTimeout(iQUERY_TIMEOUT);
    	rs=stmt.executeQuery(sql);
    	System.out.println("URA");
    }
   
    public String getCountContract_IB() throws SQLException{
    	String count="0";
    	
    	String sql="select count(*) from DOGOVORA";
    	rs=stmt.executeQuery(sql);
    	rs.next();
    	count=rs.getString(1);
    	return count;
    }
    
	
	/*public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		IBRequest a = new IBRequest();
		a.sql();
		
	}*/

}
