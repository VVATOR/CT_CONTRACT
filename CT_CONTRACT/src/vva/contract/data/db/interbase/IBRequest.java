package vva.contract.data.db.interbase;

import java.sql.*;


public class IBRequest{
	
	private IBConnection ibC = null;
	public Statement stmt = null;
	public ResultSet rs   = null;
	
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
    
    public void sqlGetDogo() throws SQLException{
    	String sql="select * from DOGOVORA";
    	
    	rs=stmt.executeQuery(sql);
    	rs.next();
    	System.out.println("aaaaaaaaaaaaa"+rs.getString(1));
    }
   
    
    
	
	/*public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		IBRequest a = new IBRequest();
		a.sql();
		
	}*/

}
