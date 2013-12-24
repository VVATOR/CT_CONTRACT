package vva.contract.data.db.interbase;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class IBConnection{

	private static Connection ibConnect = null;
	private String DB_LOGIN = "";
	private String DB_PASSWORD = "";
	private String DB_HOST = "";
	private String DB_PORT = "3050";
	private String DB_PATCH = "";
	private String DB_NAME = "";
	private String DB_CHARSET = "";

	private String ConnectionString = "";

	public IBConnection(String DB_LOGIN, String DB_PASSWORD, String DB_HOST, String DB_PORT, String DB_PATCH, String DB_NAME, String DB_CHARSET) {
		// TODO Auto-generated constructor stub
		this.DB_LOGIN = DB_LOGIN;
		this.DB_PASSWORD = DB_PASSWORD;
		this.DB_HOST = DB_HOST;
		this.DB_PORT = DB_PORT;
		this.DB_PATCH = DB_PATCH;
		this.DB_NAME = DB_NAME;
		this.DB_CHARSET = DB_CHARSET;

	}

	public Connection getConnection()throws SQLException {
		try {
			ConnectionString = "jdbc:firebirdsql:" + DB_HOST + "/" + DB_PORT + ":" + DB_PATCH + "/" + DB_NAME;
			Properties connInfo = new Properties();
			connInfo.put("user", DB_LOGIN);
			connInfo.put("password", DB_PASSWORD);
			connInfo.put("charset", DB_CHARSET);

			Class.forName("org.firebirdsql.jdbc.FBDriver");
			setCon(DriverManager.getConnection(ConnectionString, connInfo));
			
		} catch (Exception e) {
			System.out.println("Error Driver DataBase not found!");
		}

		return getCon();
	}

	public Connection getCon() {
		return ibConnect;
	}

	public void setCon(Connection con) {
		IBConnection.ibConnect = con;
	}

	public void disconnect() throws Exception {
		getCon().close();
	}
	/*
	 * public static void main(String[] args) {
	 * // TODO Auto-generated method stub
	 * IBConnection ib = new IBConnection("IHVOST", "15111987", "bl-databases", "3050", "e:/Ibdata/IRINA", "MTS.GDB", "windows-1251");
	 * ib.getConnection();
	 * System.out.println("saas");
	 * }
	 */
}
