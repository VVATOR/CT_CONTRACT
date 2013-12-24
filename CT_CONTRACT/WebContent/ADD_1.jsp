<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.LUSHR"%>

<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	function btnAddCustomer_click(){
		var action="addCustomer";
		document.addFRM.actionType.value="addCustomer";		
		//document.addFRM.action.value=action;
		document.addFRM.submit();
	}
	function btnAddPerformance_click(){
		var action="addPerformance";
		document.addFRM.actionType.value="addPerformance";	
		//document.addFRM.action.value=action;
		document.addFRM.submit();
	}
</script>
</head>
<body>
<%
ArrayList<String> lstCustomers  = new ArrayList<String>();
ArrayList<String> lstPerformance= new ArrayList<String>();


///Добавляемые значения///
String addCustomer="";
String addPerformance="";
String addRigtholder="";

/////////////////////////
String actionType="";
String countCustomers  ="0";
String countPerformance="0";
String countRigtholder ="0";






if(request.getParameter("addCustomer")!=null){
	addCustomer=new String(request.getParameter("addCustomer"));	
	addCustomer=URLDecoder.decode(addCustomer,"windows-1251");
			
}

if(request.getParameter("addPerformance")!=null){
	addPerformance=new String(request.getParameter("addPerformance"));	
	addPerformance=URLDecoder.decode(addPerformance,"windows-1251");
			
}



if(request.getParameter("countCustomers")!=null){
	countCustomers=new String(request.getParameter("countCustomers"));
}
if(request.getParameter("countPerformance")!=null){
	countPerformance= new String(request.getParameter("countPerformance"));
}


//------------ массивы
for(int i=0;i<Integer.parseInt(countCustomers);i++){
	lstCustomers.add(URLDecoder.decode(new String(request.getParameter("addCustomer"+i)),"windows-1251"));
	System.out.println("addCustomer"+i);
}
System.out.println(lstCustomers.toString());

for(int i=0;i<Integer.parseInt(countPerformance);i++){
	lstPerformance.add(URLDecoder.decode(new String(request.getParameter("addPerformance"+i)),"windows-1251"));
	
}
//--------------------//



if(request.getParameter("actionType")!=null){
	actionType=request.getParameter("actionType");
	
	
	if(request.getParameter("addCustomer")!=null){ //добавить заказчика
		countCustomers = Integer.valueOf(Integer.parseInt(countCustomers)+1).toString();
		//addCustomer = new String(request.getParameter("addCustomer"));
		lstCustomers.add(addCustomer);
		
	}
	
	if(request.getParameter("addPerformance")!=null){
		addPerformance = Integer.valueOf(Integer.parseInt(countPerformance)+1).toString();
		//addCustomer = new String(request.getParameter("addPerformance"));
		lstPerformance.add(addPerformance);
		
	}


}














%>

<form name="addFRM">
<input type="hidden" name="actionType">
customer:
<input type="text"   name="addCustomer">
<input type="hidden" name="countCustomers" value="<% out.print(countCustomers);%>">
<input type="button" name="btnAddCustomer" value="Добавить" onclick="btnAddCustomer_click();"> 
<table>
	<% 
	for (int i=0;i<Integer.parseInt(countCustomers);i++){
		out.println("<tr>");
		out.println("	<td>");
		out.println("		<input type='text' name='addCustomer"+i+"' value='"+lstCustomers.get(i)+"' readonly>");
		out.println("	</td>");
		out.println("</tr>");
	}
	%>
</table>

<br>
Performance:
<input type="text"   name="addPerformance">
<input type="hidden" name="countPerformance"  value="<% out.print(countPerformance);%>">	
<input type="button" name="btnAddPerformance" value='Добавить' onclick="btnAddPerformance_click();">
<table>
	<% 
	 for (int i=0;i<Integer.parseInt(countPerformance);i++){
		out.println("<tr>");
		out.println("	<td>");
		out.println("		<input type='text' name='addPerformance"+i+"' value='"+lstPerformance.get(i)+"' readonly>");
		out.println("	</td>");
		out.println("</tr>");
	}
	%>
</table>
	
	
	
<input type="button" name="btnAddContract" value="Добавить договор" onclick="ADD_CONTRACT();">
</form>





</body>
</html>