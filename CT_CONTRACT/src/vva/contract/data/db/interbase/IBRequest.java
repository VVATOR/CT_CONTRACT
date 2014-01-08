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
		//ibC = new IBConnection("SYSDBA", "masterkey", "localhost", "3050", "d:/SERVER/INTERBASE/MTS", "MTS.GDB", "windows-1251");
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
    
    
    public void getAllContractsWithFilter_IB(String start,String limit) throws SQLException{
    	//  public void getAllContracts_IB(String start,String limit) throws SQLException{
    	String sql="SELECT * FROM GET_NUMPP_DOGOVORA where GET_NUMPP_DOGOVORA.i>"+start+" and GET_NUMPP_DOGOVORA.i<=("+start+"+"+limit+")"
    			+ " ORDER BY id_dog asc";
    	stmt.setQueryTimeout(iQUERY_TIMEOUT);
    	rs=stmt.executeQuery(sql);
    	System.out.println("getAllContracts_IB");
    }
    
    
    public void getAllPerformerWithFilter_IB(String start,String limit) throws SQLException{
    	//  public void getAllContracts_IB(String start,String limit) throws SQLException{
    	String sql=" SELECT "
    			+ " 	  GET_NUMPP_DOGOVORA.id_dog id_dog, dog_performer.performer performer "
    			+ "  FROM GET_NUMPP_DOGOVORA, dog_performer "
    			+ "  where "
    			+ "      GET_NUMPP_DOGOVORA.id_dog = dog_performer.id_dog "
    			+ "	 and GET_NUMPP_DOGOVORA.i>"+start+" "
    			+ "  and GET_NUMPP_DOGOVORA.i<=("+start+"+"+limit+")"
    	    	+ " ORDER BY id_dog asc ";
    	stmt.setQueryTimeout(iQUERY_TIMEOUT);
    	rs=stmt.executeQuery(sql);
    	System.out.println("getAllPerformerWithFilter_IB******************************");
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



	public void autocomplete_KONTROL_IB(String text,String start,String limit) throws SQLException{
		String sql="SELECT distinct KONTROL FROM GET_NUMPP_DOGOVORA where GET_NUMPP_DOGOVORA.i>"+start+" and GET_NUMPP_DOGOVORA.i<=("+start+"+"+limit+") and KONTROL like '%"+text+"%'";
	
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		System.out.println("function > autocomplete_KONTROL_IB");
	}



	/**
	 * @author vikhlaev
	 * @param text  -  часть искомого текста
	 * @param countSelectRow  - количество записей при автозаполнении
	 * @throws SQLException
	 */
	public void autocomplete_Customer_IB(String text,int countSelectRow) throws SQLException{
		String sql=" SELECT  distinct counteragent.fullnamecount "
				+ " FROM DOGOVORA, counteragent "
				+ " where "
				+ " counteragent.id_count=DOGOVORA.id_count "
				+ " and counteragent.fullnamecount like '%"+text+"%' "
				+ " order by counteragent.fullnamecount ASC "
				+ " rows 1 to "+countSelectRow;			
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		System.out.println("function > autocomplete_Customer_IB");
	}

	/**
	 * @author vikhlaev
	 * @param text  -  часть искомого текста
	 * @param countSelectRow  - количество записей при автозаполнении
	 * @throws SQLException
	 */	
	public void autocomplete_Performer_IB(String text,int countSelectRow) throws SQLException{
		String sql=" SELECT distinct dog_performer.performer "
				+ " FROM dog_performer "
				+ " where "
				+ "   dog_performer.performer like '%"+text+"%' "
				+ " order by dog_performer.performer ASC " 
				+ " rows 1 to "+countSelectRow;			
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		System.out.println("function > autocomplete_Performer_IB");
	}
	
	/**
	 * @author vikhlaev
	 * @param text  -  часть искомого текста
	 * @param countSelectRow  - количество записей при автозаполнении
	 * @throws SQLException
	 */	
	public void autocomplete_Rightholder_IB(String text,int countSelectRow) throws SQLException{
		String sql=" SELECT  distinct DOGOVORA.pravoob "
				+ " FROM DOGOVORA "
				+ " where "
				+ "  DOGOVORA.pravoob like '%"+text+"%' "
				+ "  order by DOGOVORA.pravoob ASC "
				+ " rows 1 to "+countSelectRow;			
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		System.out.println("function > autocomplete_Rightholder_IB");
	}

	
	
	

/**
 * @throws Exception
 * полуечние количеств договоров  взависимости от статуса
 */
public void sqlInformerInfo_IB() throws Exception{
	String sql="SELECT  distinct "
			+ "              (SELECT count(*) FROM  DOGOVORA)  allContracts, "
			+ "              (SELECT count(*) FROM  DOGOVORA   where current_date<SROK_PLAT) activeContracts, "
			+ "              (SELECT count(*) FROM  DOGOVORA   where current_date>SROK_PLAT) endContracts, "
			+ "              (SELECT count(*) FROM  DOGOVORA   where current_date<SROK_PLAT) warningContracts "
			+ "FROM "
			+ "DOGOVORA ";
	stmt.setQueryTimeout(iQUERY_TIMEOUT);
	rs=stmt.executeQuery(sql);		
}


/*
public static void main () throws Exception{
	IBRequest ib =new IBRequest();
	ib.sqlInformerInfo_IB();
	ib.rs.next();
	System.out.println(ib.rs.getString(1));
}*/


}