package vva.contract.data.db;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

public class SQLRequest {
	
	
	private OracleConnection oOC=null;
	private Statement stmt=null;
	public ResultSet rs=null;
	
	private int iQUERY_TIMEOUT = 300;
	

	public SQLRequest() throws Exception  {
		// TODO Auto-generated constructor stub
		oOC = new OracleConnection("plm.gskbgomel.by", "SEARCH", "1521", "proeuser", "proeuser");
		//oOC = new OracleConnection("localhost", "SEARCH", "1521", "PROEUSER", "masterkey");
		oOC.getConnection();
		stmt=oOC.getCon().createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	}
	
	
	public void disconnect() throws Exception{
		if(rs!=null){
			rs.close();
		}
		if(stmt!=null){
			stmt.close();
		}	
		if(oOC!=null){
			oOC.disconnect();
		}
		
	}
	
	public void getAutoComplete_CUSTOMERS() throws Exception{
		String sql="SELECT distinct CUSTOMER from CT_CUSTOMERS ";
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);	
	}
	
	public void getAllContracts(String start, String limit) throws SQLException{
		String sql="SELECT *  "
				+"  FROM "
				+"  (SELECT "
				+"    rownum INTERVAL_paging,  "
				+"    CT_ALLCONTRACTS.id id, "
				+"    CT_ALLCONTRACTS.DEPARTMENT_ID DEPARTMENT_ID, "
				+"    CT_ALLCONTRACTS.NUM NUM, "
				+"    CT_ALLCONTRACTS.DEADLINE DEADLINE, "
				+"    CT_ALLCONTRACTS.THEME THEME, "
				+"    CT_ALLCONTRACTS.SESSION_USER SESSION_USER, "	
				+"    CT_ALLCONTRACTS.DATE_REG DATE_REG,"
				
				+"    CT_CUSTOMERS.CUSTOMER CUSTOMER, "
				+"    CT_PERFORMANCES.PERFORMANCE PERFORMANCE, "
				+"    CT_RIGHTHOLDERS.RIGHTHOLDER RIGHTHOLDER "
				+"   FROM  "
				+"    CT_ALLCONTRACTS "
				+"    left join CT_CUSTOMERS on(CT_CUSTOMERS.ID = CT_ALLCONTRACTS.ID_CUSTOMERS) "
				+"    left join CT_PERFORMANCES on(CT_PERFORMANCES.ID = CT_ALLCONTRACTS.ID_PERFORMANCES) "
				+"    left join CT_RIGHTHOLDERS on(CT_RIGHTHOLDERS.ID = CT_ALLCONTRACTS.ID_RIGHTHOLDERS) "
				+"  order by DATE_REG desc  "
				+"  ) "
				+"  where INTERVAL_paging>"+start+" and INTERVAL_paging<=("+start+"+"+limit+"+1) ";
		
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);		
	}
	
	
	public String getCountContract() throws Exception{
		String sql="SELECT count(*) from CT_ALLCONTRACTS ";
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		rs.next();
		return rs.getString(1);
	}
	
	

	
	/**
	 * @param SessionUser - логин пользователя авторизованного в системе
	 * @return 
	 * true  - если пользователь является администратором, <BR>
	 * false - если пользователь НЕ является администратором	
	 * @throws Exception
	 */
	public boolean isAdmin(String SessionUser) throws Exception{
		String sql="SELECT count(*) from users inner join CT_USERS_ADMINS on (CT_USERS_ADMINS.USER_ID in users.ID)"
				+ " where UPPER(TRIM(users.login)) = UPPER(TRIM('"+SessionUser+"'))";
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		rs.next();
		if (rs.getInt(1)>0)
			return true;
		else	
			return false;
		
	}
	

	
	public int insertSql(String sqlString) throws Exception{
		String sql=sqlString;
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		int a=stmt.executeUpdate(sql);
		if (a>0)
			return a;
		else	
			return 0;
		
	}
	
	
	public void sqlInformerInfo() throws Exception{
		String sql="SELECT "
				 + "  (SELECT count(*) FROM  CT_ALLCONTRACTS)  allContracts,"
				 + "  (SELECT count(*) FROM  CT_ALLCONTRACTS where sysdate<deadline) activeContracts, "
				 + "  (SELECT count(*) FROM  CT_ALLCONTRACTS where sysdate>deadline) endContracts,"
				 + "  (SELECT count(*) FROM  CT_ALLCONTRACTS where sysdate<deadline-7) warningContracts "
				 + " FROM "
				 + "	 CT_ALLCONTRACTS "
				 + " WHERE "
				 + " ROWNUM=1";
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);		
	}
	
	
	
	
///////////////////////////////////////////////////////////////////////
// random data
///////////////////////////////////////////////////////////////////////
	
	
	public String createRandomUser() throws Exception{
		Random a =new Random();
		String sql="SELECT * from users ";
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		rs=stmt.executeQuery(sql);
		int buf=a.nextInt(1000);
		int i=0;
		while(rs.next()){
		   if (i==buf){
			   break;
		   }
		   i++;
		}
		
		return rs.getString("fullname");
	}
	
	
	public void create100Random() throws Exception{
		Random a =new Random();
		String sql;
		int i=0;
		while(i<200){
		sql="insert into CT_ALLCONTRACTS (ID, DEADLINE, SESSION_USER, DEPARTMENT_ID, NUM,  ID_RIGHTHOLDERS, ID_CUSTOMERS, ID_PERFORMANCES, THEME, DATE_REG)"
				+ " values ("
				+ " "+i+","
				+ " sysdate+(0+"+a.nextInt(2000)+"-2000),";
		
			if (a.nextInt() % 2==0){
			   sql+= " 'vikhlaev',";
			   sql+= " 31,";
			}else{
			   sql+= " 'vikavg',";
			   sql+= " 17,";
			}
			
			   sql+= " "+a.nextInt(100)+",";
			   sql+= " "+a.nextInt(100)+",";
			   sql+= " "+a.nextInt(100)+",";
			   
			   sql+=" "+a.nextInt(100)+","
			      +" 'theme №"+a.nextInt(100)+"',"
			      + " sysdate)";
		
				
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		stmt.executeUpdate(sql);	
		i++;
		}
		
	}
	
	
	public void create100RandomrightHolder() throws Exception{
		Random a =new Random();
		String sql;
		int i=0;
		while(i<100){
		sql="insert into CT_RIGHTHOLDERS (ID, RIGHTHOLDER)"
				+ " values ("
				+ " "+i+",";
		
			   sql+= " '"+createRandomUser()+"')";				
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		stmt.executeUpdate(sql);	
		i++;
		}
		
	}
	
	public void create100Customer() throws Exception{
		Random a =new Random();
		String sql;
		int i=0;
		while(i<100){
		sql="insert into CT_CUSTOMERS (ID, CUSTOMER)"
				+ " values ("
				+ " "+i+",";
		
			   sql+= " '"+createRandomUser()+"')";				
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		stmt.executeUpdate(sql);	
		i++;
		}
		
	}
	
	public void create100PERFORMERS() throws Exception{
		Random a =new Random();
		String sql;
		int i=0;
		while(i<100){
		sql="insert into CT_PERFORMANCES (ID, PERFORMANCE)"
				+ " values ("
				+ " "+i+",";
		
			   sql+= " '"+createRandomUser()+"')";				
		stmt.setQueryTimeout(iQUERY_TIMEOUT);
		stmt.executeUpdate(sql);	
		i++;
		}
		
	}
/////////////////////////////////////////////////////////////////////	
/////////////////////////////////////////////////////////////////////	
/*
	public static void main(String[] args) {
		// TODO Auto-generated method stub_
		
	}
*/
}
