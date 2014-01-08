<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
    
   <%@ page import="vva.contract.data.db.SQLRequest" %>
   <%@ page import="vva.contract.info.Informer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="extjs/resources/css/ext-all.css" />
<script type="text/javascript" src="extjs/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="extjs/resources/example.css" />
<!-- <script type="text/javascript" src="extjs/infinite-scroll.js"></script>
 -->

<link rel="stylesheet" type="text/css" href="design/style.css" />




<!--<img class="im" src="design/images/Contract-icon.png" height="16px"> -->

<style type="text/css">
.pluginTAble{
margin: 10px;
}

.pluginTAble thead tr th  {
 text-align: left; /* Выравнивание по левому краю */
    background: #ccc; /* Цвет фона ячеек */
    padding: 5px; /* Поля вокруг содержимого ячеек */
    border: 1px solid black; /* Граница вокруг ячеек */

}
.pluginTAble tbody tr td  {
 text-align: left; /* Выравнивание по левому краю */
    background: #fff; /* Цвет фона ячеек */
    padding: 5px; /* Поля вокруг содержимого ячеек */
    border: 1px solid black; /* Граница вокруг ячеек */
    
}




.imgGRD-edit{
    background: url(design/images/document-icon.png); /* Путь к файлу с исходным рисунком  */
    display: block; /*  Рисунок как блочный элемент */
    width: 32px; /* Ширина рисунка */
    height: 32px; /*  Высота рисунка */
   }
   
.imgGRD-edit:hover{
/*background-color: red;*/
background: url(design/images/Contract-icon.png);

}

.imgGRD-add:hover{
background-color: yellow;
}
.imgGRD-new:hover{
background-color: lime;
}







.control-card .x-grid-cell {
	background: red /*#FAFAD2*/ !important;
}

.male-cell { 
    background: url(design/images/document-icon32.png) no-repeat 2px 1px !important; 
    padding-left: 16px; 
} 
 
.female-cell { 
    background: url(design/images/folder-contract-icon.png) no-repeat 2px 1px !important; 
    padding-left: 16px; 
}
///////////////////////////////////////////////////////////////////















 .footer_Menu
    {
        list-style: none; /* прячем маркеры */
        margin: 0px;
        
    }

  .footer_Menu li
    {
    	float: left; /* выстраиваем элементы списка в один ряд */
		margin-right: 15px; /* делаем отступ чтобы пункты меню не сливались */
        border-bottom:1px solid #eeeeee;
        background-repeat: no-repeat;
        background-position: center;
        
    }
 
	.footer_Menu li a {
    display: block;
    text-align: center;
    padding-top: 70px; /* внутренний осттуп чтобы текст был вне фона */
    color: #ff0000;
    background-position: center top; /* выравниваем фон вверх и по центру */
    background-repeat: no-repeat;
    width: 100px; /* размеры указываем чтобы картинки полностью отобразились */
    height: 50px;
    margin-bottom: 15px;
	}


  .footer_Menu li:hover
    {
        background-color:#ffcc00;
    }
  .footer_Menu li:hover a
    {
        color:White;
    }


li.separotor{
 background-image: url("design/images/separator.png");
 color: white;


}

li.status-all{
 background-image: url("design/images/contract_status/contract_all.png");
 color: white;
 background-size: 24px 24px;
}

li.status-active{
 background-image: url("design/images/contract_status/contract_active.png");
 color: white;
}

li.status-warning{
 background-image: url("design/images/contract_status/contract_warning.png");
 color: white;
}

li.status-late{
 background-image: url("design/images/contract_status/contract_late.png");
 color: white;
}

li.status-ok{
 background-image: url("design/images/contract_status/contract_ok.png");
 color: white;
}

</style>
</head> 
<body>
 
    

<div style="width: 100%; height: 30px; background-color: #00ff00;">
Пользователь: (<%=System.getProperty("user.name") %>) /
Права: <% 


/// Определение прав доступа
String ACCESS="-1";
/*
-1 - simple user (looser)
 0 - administrator
*/	

SQLRequest sqlRequest = new SQLRequest();
if  (sqlRequest.isAdmin(System.getProperty("user.name"))==true){

	ACCESS="0";
	out.println("администратор");
}else{
	ACCESS="-1";
	out.println("user");
}

%>
</div>




<jsp:include page="extjs/infinite-scroll.jsp"></jsp:include>
		<div class="content" id="content"
			style="width: 1200px; margin: 0 auto; background: gray;">
		</div>


<br>

<form name="addFRM" method="get" action="DataServletIB">
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
		s
		
		</td>
		<td>
		<input type="text" name="themes">
		</td>
	</tr>
</table>
<input type="submit" value="send">
<br>
</form>

<form action="DataServlet">
<input type="submit">

</form>
write
<form action="DataServlet">
<input type="submit">
<input type="button" value="Отмена_history"   onclick="window.history.go(-1);">
<button onclick="history.back();">Back</button>
</form>

<div style="z-index:1000; background-color: black; color:white; position: fixed; bottom: 0px; width:100%; min-height: 100px;">
<% Informer info =new Informer();  
%>



<div>

<ul class="footer_Menu">

	 <li class="status-all">
	 <a href="#">
		Всего договоров:	<%=info.getAllContracts() %> 
	 </a>	
	</li>  
	<li class="status-active">
	<a href="#">
		Активных:			<%=info.getActiveContracts() %> 
	</a>	
	</li>
	<li class="status-warning">
	<a href="#">
		внимание:       <%=info.getWarningContracts() %> 
	</a>	
	</li>
	<li class="status-late">
	<a href="#">
		просроченных:   <% 	//=info.getLateContracts() %> 
	</a>	 
	</li> 
	<li class="status-longer">
	<a href="#">
		продлен:	    <%=info.getAllContracts() %> 
	</a>	
	</li>
	<li class="status-ok"> 
	<a href="#">
		завершенных успешно:<%=info.getEndContracts() %> 
	</a>	
	</li>
</ul>

</div>
</div>
</body>
</html>