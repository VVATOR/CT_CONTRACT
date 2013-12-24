<%@page import="com.sun.org.apache.bcel.internal.generic.LUSHR"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%> 
<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Добавление записей</title>

<link rel="stylesheet" type="text/css"
	href="extjs/resources/css/ext-all.css" />
<script type="text/javascript" src="extjs/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="extjs/resources/example.css" />
<!-- <script type="text/javascript" src="extjs/infinite-scroll.js"></script>
 -->





<script>
function send(a){
	//alert('Отправка данных формы...');
	switch(a){
		case "addContract":		    document.addFRM.action.value='DataServletWriter';
									alert("addContract");
									addFRM.submit();
									break;
		case "actAddCustomer":		document.addFRM.action.value='actAddCustomer';
									alert("actAddCustomer");
									break;
		case "actDelCustomer":		document.addFRM.action.value='actDelCustomer';
									alert("actDelCustomer");
									break;
		case "actAddPerformance":	document.addFRM.action.value='actAddPerformance';
									alert("actAddPerformance");
									break;
		case "actDelPerformance":	document.addFRM.action.value='actDelPerformance';
									alert("actDelPerformance");
									break;
		case "actAddRightholder":	document.addFRM.action.value='actAddRightholder';
									alert("actAddRightholder");
									break;
		case "actDelRightholder":	document.addFRM.action.value='actDelRightholder';
									alert("actDelRightholder");
									break;
		
	}
	
	document.addFRM.submit();
	//document.location=document.location;
}

</script>


</head>
<body>

<%
String action ="";
String iCustomerCount="0";

ArrayList<String>  spiski = new ArrayList<String>() ;
ArrayList <String> lstCustomer = new ArrayList<String>();
ArrayList <String> lstPerformance = new ArrayList<String>();
ArrayList <String> lstRightholder = new ArrayList<String>();

if(request.getParameter("action")!=null){
action=new String(request.getParameter("action").getBytes("windows-1251"));	
System.out.println("action="+action);
}



if (request.getParameter("iCustomerCount") != null) {
	iCustomerCount=new String (request.getParameter("iCustomerCount").getBytes("windows-1251"));
}
	

//получаем переданные массивы
System.out.println("iCustomerCount:"+iCustomerCount);
for(int i=0;i<Integer.parseInt(iCustomerCount);i++){
	lstCustomer.add(URLDecoder.decode(new String(request.getParameter("Customer" + Integer.valueOf(i).toString()).getBytes("ISO-8859-1")), "windows-1251"));													
	System.out.println("lst["+i+"]"+lstCustomer.get(i).toString());
}



if(action.equals("addContract")){
//	addContract();
	
}else if(action.equals("actAddCustomer")){ //добавить исполнителя
	iCustomerCount = Integer.valueOf(Integer.parseInt(iCustomerCount) + 1).toString();
	lstCustomer.add("add...");		
	System.out.println("dddddddd: "+lstCustomer.get(0).toString());
 }

		else if(action.equals("actDelCustomer")){
	  		//actDelCustomer
	 	  }else if(action.equals("actAddPerformance")){
		  		//actAddPerformance
		 	  }else if(action.equals("actDelPerformance")){
			  			//actDelPerformance
			 	    }else if(action.equals("actAddRightholder")){
				  			//actAddCustomer
					 	  }else if(action.equals("actDelRightholder")){
						  		//actAddCustomer
					 	  }else if(action.equals("actDelRightholder")){
						  		//actAddCustomer
					 	 		}	

//String action="";



if(action.equals("actAddCustomer")){
	lstCustomer.add("");
	lstCustomer.add("lol");
	
	
}


//Действие
 if (request.getParameter("action") != null) {
	 action = new String(request.getParameter("action").getBytes("ISO-8859-1"));
 }
%>

<br>
<button onclick="send('actAddCustomer');">actAddCustomer</button>
<button onclick="send('actDelCustomer');">actDelCustomer</button>
<button onclick="send('actAddPerformance');">actAddPerformance</button>
<button onclick="send('actDelPerformance');">actDelPerformance</button>
<button onclick="send('actAddRightholder');">actAddRightholder</button>
<button onclick="send('actDelRightholder');">actDelRightholder</button>
<br>

action= <% out.print(action); %> 


<br>




<input type="button" value="Добавить" onclick="document.addFRM.action.value='add';">


<br>

<%//@ include file="extjs/win_add.jsp" %>
<div class="content" id="content"
	style="width: 1200px; margin: 0 auto; background: red;">
</div>


<br>

<form name="addFRM">
<table border="1px">
	<tr>
		<td>
		Номер договора:
		</td>
		<td>
		<input type="text" name="num">
		</td>
	</tr>
	<tr>
		<td>
		Тема (наименование)договора:
		</td>
		<td>
		<input type="text" name="theme">
		</td>
	</tr>	
	<tr>
		<td>
		Сроки вытолнения договора:
		</td>
		<td>
		<input type="text" name="deadline">
		</td>
	</tr>
	<tr>
		<td>
		Заказчики:
		</td>
		<td>
		<input type="text" name="customer">
		</td>
	</tr>
	<tr>
		<td>
		
		</td>
	</tr>
	<tr>
		<td>
		Исполнители:
		</td>
		<td>
		<input type="text" name="performance">
		</td>
	</tr>
	<tr>
		<td>
		
		</td>
	</tr>
	<tr>
		<td>
		Правообладатели:
		</td>
		<td>
		<input type="text" name="rightholder">
		</td>
	</tr>


	
</table>








<input type="hidden" name="action">
<input type="hidden" name="iCustomerCount" value="<% out.print(iCustomerCount);%>">
customer<input type="text" name="Customer">

<!--  -->

<input type="button" value="Добавить" onclick="send('addContract');">
<input type="button" value="Отмена_history"   onclick="window.history.go(-1);">
<input type="button" value="Отмена_location"   onclick="window.location='index.jsp';">
</form>

</body>
</html>