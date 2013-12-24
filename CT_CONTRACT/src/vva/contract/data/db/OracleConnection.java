package vva.contract.data.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import oracle.jdbc.ttc7.Oopen;

public class OracleConnection {
	private static Connection oCon = null;
	private String hostName = "";
	private String dataBaseName = "";
	private String port = "";
	private String SID = "";
	private String password = "";

	private String connectionString = "";

	public OracleConnection(String hostName, String dataBaseName, String port,
			String SID, String password) throws ClassNotFoundException {
		// TODO Auto-generated constructor stub
		this.hostName = hostName;
		this.dataBaseName = dataBaseName;
		this.port = port;
		this.SID = SID;
		this.password = password;
		
	}

	public Connection getConnection() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver DataBase  installed!");
		} catch (Exception e) {
			System.out.println("Error Driver DataBase not found!");
		}

		connectionString = "jdbc:oracle:thin:@" + hostName + ":" + port + ":"+ dataBaseName;
		setCon(DriverManager.getConnection(connectionString, SID, password));
		return getCon();
	}
	
	

	public  Connection getCon() {
		return oCon;
	}

	private static void setCon(Connection con) {
		OracleConnection.oCon = con;
	}
	
	public void disconnect() throws Exception{
		if(oCon!=null){
			oCon.close();
		}
	}
	
	
	
/*
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
*/
}
