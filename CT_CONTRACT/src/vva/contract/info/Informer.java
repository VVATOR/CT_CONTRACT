package vva.contract.info;

import vva.contract.data.db.SQLRequest;
import vva.contract.data.db.interbase.IBRequest;

public class Informer {

	static int allContracts;
	static int activeContracts;
	static int warningContracts;
	static int lateContracts;
	static int endContracts;
	 

	public Informer()  throws Exception{
		 IBRequest sqlRequest = new IBRequest();
		 sqlRequest.sqlInformerInfo_IB();
		 sqlRequest.rs.next();
		 this.allContracts=sqlRequest.rs.getInt("allContracts");
		 this.activeContracts=sqlRequest.rs.getInt("activeContracts");
		 this.warningContracts=sqlRequest.rs.getInt("warningContracts");
		// this.lateContract=sqlRequest.rs.getInt("lateContract");
		 this.endContracts=sqlRequest.rs.getInt("endContracts");
	 }

/////////////// getters
	
	 public int getAllContracts() {
		return allContracts;
	}

	public int getActiveContracts() {
		return activeContracts;
	}

	public int getWarningContracts() {
		return warningContracts;
	}

	public int getLateContracts() {
		return lateContracts;
	}

	public int getEndContracts() {
		return endContracts;
	}


}
