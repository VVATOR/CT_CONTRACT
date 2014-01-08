<%@page import="vva.contract.data.db.SQLRequest"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
	pageEncoding="windows-1251"%>
	<%//String SessionUser="vikhlaev"; %>
<script>

<%
 /// Определение прав доступа
String ACCESS="-1";
 
SQLRequest r = new SQLRequest();
if  (r.isAdmin(System.getProperty("user.name"))==true){
	/*
		-1 - simple user (looser)
		 0 - administrator
	*/	
	ACCESS="0";
}
%>




/*

This file is part of Ext JS 4

Copyright (c) 2011 Sencha Inc

Contact:  http://www.sencha.com/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 3.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.sencha.com/contact.

 */

// для многострочного текста
function columnWrap(val) {
	return '<div style="white-space:normal !important;">' + val + '</div>';
}

// для многострочного текста
function columnWordWrap(val) {
	return '<div style="white-space:word-wrap !important;">' + val + '</div>';
}


//для многострочного текста
function columnWordWrapSIMBOL(val) {
	return '<div style="word-wrap:word-wrap !important;">' + val + '</div>';
}

// ссылкогенератор
function renderTopic(value, p, record) {
	return Ext.String.format('<a href="{2}" target="_blank">{0}</a>', value,
			record.data.forumtitle, record.getId(), record.data.forumid);
}

/*
 * Ext.application({ name: 'HelloExt', launch: function() {
 * Ext.create('Ext.container.Viewport', { layout: 'fit', items: [ { title:
 * 'Приложение на Ext JS 4', html : '<h3>Добро пожаловать в мир Ext JS 4!</h3>' } ]
 * }); } });
 * 
 * 
 */

// /////////////////////////////////////////////////
Ext.Loader.setConfig({
	enabled : true
});

Ext.Loader.setPath('Ext.ux', 'extjs/ux/');
Ext.require([ 'Ext.grid.*', 
              'Ext.data.*', 
              'Ext.util.*', 
              'Ext.ux.RowExpander',
              'Ext.ux.grid.Printer',
              'Ext.grid.PagingScroller',
                           ]);

Ext.onReady(function() {	
	Ext.define('ModelDocumentKOKT', {
		extend : 'Ext.data.Model',
		fields: [
		         'I',
		         'ID_DOG',
		         'KONTROL',
		         'ID_COUNT',
		         'ID_ACCOUNT',
		         'NAMEDOG',
		         'NOM_DOG',
		         {	name:'DATA_W',
		        	dateFormat: 'd-m-Y H:i',
		 			dateReadFormat: 'Y-m-d H:i:s.u'
		 		 },
		         'SROK_PLAT',
		         'SUMMA',
		         'CURRENCY',
		         'NOTE',
		         'IS_DEL',
		         'USER_FIO',
		         'STATUS',
		         'FULLNAMEDOG',
		         'PRIM',
		         'USL_POST',
		         //'KOD1C',
		         'DATE_STATUS',
		         'REG_NOM',
		         'REG_DATE',
		         'REG_SECT',
		         'REG_INDEX',
		         'FULL_NUM',
		         'USER_FIO1',
		         
		         'counteragent_fname',
		         'performer',
		         'rightholder',
		         'subdog_pred',
		         'subdog_inProcess'
			    ],
		idProperty : 'threadid'
	});
	
	
	
	Ext.define('Model_CUSTOMER', {
		extend : 'Ext.data.Model',
		fields: [		         
		         'NAMEDOG',
		         'NOM_DOG',		         	         
			    ],
		idProperty : 'threadid'
	});
	
	// create the Data Store	
	var store1= Ext.create('Ext.data.Store', {		
        autoLoad: true,
        model: 'Model_CUSTOMER',
        id: 'store1',
        pageSize: 10,
        proxy: {
            type: 'jsonp',
            url: 'DataServletIB?SessionUser=vikhlae&autoComplete=1',
            reader: {
               
                root: 'data',
                totalProperty: 'totalCount'
            }
        }
	});
	
	
	var store = Ext.create('Ext.data.Store', {
		id : 'store',
		model : 'ModelDocumentKOKT',
		// remoteSort: true,
		// allow the grid to interact with the paging scroller by buffering
		buffered : true,
		 leadingBufferZone: 5000,
		pageSize : 100,
		proxy : {
			// load using script tags for cross domain, if the data in on the
			// same domain as
			// this page, an HttpProxy would be better
			type : 'jsonp',
			url : 'DataServletIB?SessionUser=vikhlaev',// http://ws-16:8080/DKOKT_ext/
			extraParanetms : {
				total : 50000,
				rus: 'привет'
			},
			params: {rrr: 'колян'},
			reader : {
				root : 'data',
				totalProperty : 'totalCount'
			},
			// sends single sort as multi parameter
			simpleSortMode : true
		},
		simpleGroupMode : true,
		// sorters: [{
		// property: 'id_impr_sug',
		// direction: 'DESC'
		// }],
		autoLoad : true
	});
	
	
	
	//var pluginExpanded = true; // для панели пэйджинга
	
	var movieTpl = new Ext.XTemplate(
		    '<tpl for="."><div class="movie-item">',
		        '<h2><span>Year: {SUMMA}<br />Rating: {THEME}</span>{REG_DATE}</h2>',
		        '{description}',
		    '</div></tpl>'
		);
	

	
	var tplGRDcellBTN = '<a href="DataServlet?a={SUMMA}"><img src="design/images/contract_status/warning.png" height="12px" width="12px"></a>';

		
	
	var mody=function setParamStoreInRuntime() { 
    	store.getProxy().extraParams.fCustomer    = Ext.getCmp("cbfCustomer").getValue(); /// УРА ЭТО СУПЕР  
    	//alert("zz:"+Ext.getCmp("cbfRightholder").getValue());
    	
		store.getProxy().extraParams.fPerformer   = Ext.getCmp("cbfPerformer").getValue(); /// УРА ЭТО СУПЕР    
		store.getProxy().extraParams.fRightholder = Ext.getCmp("cbfRightholder").getValue(); /// УРА ЭТО СУПЕР    
	     	
    };
	 
	var grid = Ext.create('Ext.grid.Panel',
	        {
	          //  "xtype": "gridpanel",
	            "cls": "linear",
	            "height": 450,
	            "collapsed": false,
	            "title": "Договора НИОКТР",
	            "titleCollapse": false,
	            "columnLines": true,
	            "store": store,
	            "viewConfig": {
	                "margin": 0
	            }
	            
	            
	            <% // если пользователь имеет доступ то показать ему сумму
	               if(ACCESS.equals("0")){           			
    			%> 
    			,  // - разделитель
	    	    plugins: [{	    	
	                ptype: 'rowexpander',            
	                rowBodyTpl : [  '<div color=black> Сумма: <font color=red> {SUMMA} </font> {CURRENCY}</div>',         
				                    '<div style="color: green;"> </div>',
				                    '<p><b>Номера охранных документов на ОППС, созданных в результате работ по договору:</b> <br> {ID_DOG}</p>',
				                    '<p><b>Номера охранных документов на ОППС:</b> <br> {ID_DOG}</p><br>',
				                   
			                 // '<script>',
			                 // ' if("{subdog_pred}"!="" || "{subdog_inProcess}"!=""){ ',
				                    '<table class="pluginTAble"> ',
				                    '	<thead> ',
				                    '		<th width="400px" scope="col">Номера охранных документов на ОППС, созданных в результате работ по договору: </th>',
				                    '		<th width="400px" scope="col">Номера охранных документов на ОППС:</th',
				                    '	</thead> ',
				                    '	<tbody ',
				                    '	<tr> ',
				                    '		<td> {subdog_pred}',
				                    '		</td> ',
				                    '		<td> {subdog_inProcess}',
				                    '		</td> ',
				                    '	</tr> ',
				                    '	<tr> ',
				                    '	</tr> ',
				                    '	</tbody>',
				                    '</table> '
			                  //'<script>',
			                 // '} '
					            
				                 ],
				                 collapse: false,
	            }], 
	           
	            collapsible: false,
	            collapse: false
				<% } %>
				
				
	            ,   // - разделитель	            
	            "columns": [
	                        
							{
							    "xtype": "gridcolumn",
							    "width": 51,
							    "dataIndex": "I",
							    "text": "№ (I)",
							},
							{
							    "xtype": "templatecolumn",
							    "tpl": [
							        "<a href=\"DataServlet?a={SUMMA}\"><img src=\"design/images/contract_status/warning.png\" height=\"12px\" width=\"12px\"></a>"
							    ],
							    "width": 35,
							    "text": "",
							},
							{
							    "xtype": "gridcolumn",
							    "width": 59,
							    "dataIndex": "ID_DOG",
							    "text": "ID_DOG",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "KONTROL",
							    "hideable": false,
							    "text": "KONTROL",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "ID_COUNT",
							    "hideable": false,
							    "text": "ID_COUNT",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "ID_ACCOUNT",
							    "hideable": false,
							    "text": "ID_ACCOUNT",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "NAMEDOG",
							    "text": "Вид документа<br>(NAMEDOG)",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "NOM_DOG",
							    "text": "Номер входящего<br>договора (NOM_DOG)",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "DATA_W",
							    "text": "Дата возникновения<br>договора (DATA_W)",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "SROK_PLAT",
							    "hideable": false,
							    "text": "SROK_PLAT"
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "SUMMA",
							    "hideable": false,
							    "text": "SUMMA"
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "CURRENCY",
							    "hideable": false,
							    "text": "CURRENCY",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "NOTE",
							    "hideable": false,
							    "text": "NOTE",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "IS_DEL",
							    "hideable": false,
							    "text": "IS_DEL",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "USER_FIO",
							    "hideable": false,
							    "text": "USER_FIO",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "STATUS",
							    "hideable": false,
							    "text": "STATUS",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "FULLNAMEDOG",
							    "text": "Полное название<br>договора (FULLNAMEDOG)",
							    renderer : columnWrap,
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "PRIM",
							    "hideable": false,
							    "text": "PRIM",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "USL_POST",
							    "hideable": false,
							    "text": "USL_POST",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "DATE_STATUS",
							    "hideable": false,
							    "text": "DATE_STATUS",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "REG_NOM",
							    "text": "Регистрационный номер<br>документа (REG_NOM)",
							},
							{
							    "xtype": "gridcolumn",
							    "width": 157,
							    "dataIndex": "REG_DATE",
							    "text": "Дата и время регистрации<br>договора (REG_DATE)",    
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "REG_SECT",
							    "hideable": false,
							    "text": "REG_SECT",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "REG_INDEX",
							    "hideable": false,
							    "text": "REG_INDEX",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "FULL_NUM",
							    "hideable": false,
							    "text": "FULL_NUM",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "USER_FIO1",
							    "hideable": false,
							    "text": "USER_FIO1",
							},
							{
							    "xtype": "gridcolumn",
							    "draggable": false,
							    "text": "Участники",
							    "columns": [
							        {
							            "xtype": "gridcolumn",
							            "dataIndex": "counteragent_fname",
							            "text": "Заказчики<br>(Counteragent_fname)",
							            renderer : columnWrap,
							            "allowBlank": false,
							            
							        },
							        {
							            "xtype": "gridcolumn",
							            "dataIndex": "rightholder",
							            "text": "Правообладатели<br>(Rightholder)",
							            renderer : columnWrap,
							        },
							        {
							            "xtype": "gridcolumn",
							            "dataIndex": "performer",
							            "text": "Исполнители<br>(Performer)",
							            renderer : columnWrap,
							        }
							    ]
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "subdog_pred",
							    "hideable": false,
							    "text": "Subdog_pred",
							},
							{
							    "xtype": "gridcolumn",
							    "hidden": true,
							    "dataIndex": "subdog_inProcess",
							    "hideable": false,
							    "text": "Subdog_inProcess",
							},
							{
							    "xtype": "gridcolumn",
							    "dataIndex": "",
							    "text": "",
							}
	            ],
	            "dockedItems": [
	                {
	                    "xtype": "pagingtoolbar",
	                    "dock": "bottom",
	                   // "width": 360,
	                    "afterPageText": "из {0}",
	                    "beforePageText": "Страница",
	                    "displayInfo": true,
	                    "displayMsg": "Записи с {0} по {1}  <b><u>Всего: {2}</u></b>",
	                    "emptyMsg": "Нет данных для отображения",
	                    "firstText": "В начало",
	                    "lastText": "В конец",
	                    "nextText": "Вперед",
	                    "prevText": "Назад",
	                    "refreshText": "Обновить",
	                    "store": store,
	                    "items": [
	                        {
	                            "xtype": "tbseparator",
	                        },
	                        {
	                            "xtype": "button",
	                            "text": "Добавить",
	                            handler: function(){ infoWin.show();}
	                        }
	                    ]
	                },
	                {
	                    "xtype": "toolbar",
	                    "dock": "left",
	                    "items": [
	                        {
	                            "xtype": "buttongroup",
	                            "height": 290,
	                            "title": "Buttons",
	                            "columns": 1,
	                            "items": [
	                                {
	                                    "xtype": "combobox",
	                                    "id": "cbfCustomer",
	                                    "width": 250,
	                                    "fieldLabel": "Заказчик",
	                                    "labelAlign": "top",
	                                    "name": "find",
	                                    "displayField": "NAMEDOG",
	                                    "pageSize": 15,
	                                    "store": store1,
	                                    "valueField": "NAMEDOG",
	                                    
	                                    
	                                    //"maskRe": /[0-9:a]/,  // допустимые символы для ввода
	                                    //"regex" : /^\d{2}:\d{2}$/,
										//"regexText" : 'Please enter time in HH:MM format', // текст при ошибке, ввода regexp

	                                    
	                                    
	                                    "listeners": {
                                            change:  mody
                                    	}  
	                                },
	                                {
	                                    "xtype": "combobox",
	                                    "id": "cbfPerformer",
	                                    "width": 250,
	                                    "fieldLabel": "Исполнитель",
	                                    "labelAlign": "top",
	                                    "displayField": "NAMEDOG",
	                                    "pageSize": 15,
	                                    "store": store,
	                                    "valueField": "NAMEDOG",
	                                    "listeners": {
                                            change:  mody
                                    	} 
	                                },
	                                {
	                                    "xtype": "combobox",
	                                    "id": 'cbfRightholder',
	                                    "width": 250,
	                                    
	                                    "fieldLabel": "Правообладатель",
	                                    "labelAlign": "top",
	                                    "displayField": "FULLNAMEDOG",
	                                    "pageSize": 15,
	                                    "store": store,
	                                    "valueField": "FULLNAMEDOG",
                                        "listeners": {
                                            change:  mody
                                    	}                                           
	                                },
	                                {
	                                    "xtype": "button",
	                                    "handler": function(button, event) {
	                                        var searchValue = Ext.getCmp("cbf1").getValue();//get new value 
	                                     //   store.load().filter('jsonGridFielName', searchValue); //load filtered data
	                                        
	                                    	store.load().filter('jsonGridFielName', Ext.getCmp("cbf1").getValue()); //load filtered data
	                                    	
	                                    	

	                                    	store.getProxy().extraParams.fCustomer    = Ext.getCmp("cbf1").getValue();/// УРА ЭТО СУПЕР
	                                    	store.getProxy().extraParams.fPerformer   = Ext.getCmp("cbf1").getValue();/// УРА ЭТО СУПЕР
	                                    	store.getProxy().extraParams.fRightholder = Ext.getCmp("cbf1").getValue();/// УРА ЭТО СУПЕР
	                                    	
	                                    	store.getProxy().extraParams.fDateReg_interval1 = Ext.getCmp("cbf1").getValue();/// УРА ЭТО СУПЕР
	                                    	store.getProxy().extraParams.fDateReg_interval2 = Ext.getCmp("cbf1").getValue();/// УРА ЭТО СУПЕР
	                                    	
	                                    	
	                                    	
	                                        store.load({
	                                            params:{
	                                                fCustomer: Ext.getCmp("cbf1").getValue(),
	                                                fPerformer: Ext.getCmp("cbf1").getValue(),
	                                                fRightholder: Ext.getCmp("cbf1").getValue()
	                                            }
	                                            //other options like a callback function, append/add flag, etc. 
	                                        });
	                                    },
	                                    "text": "filter"
	                                },
	                                {
	                                    "xtype": "button",
	                                    "text": "Button 2"
	                                },
	                                {
	                                    "xtype": "button",
	                                    "handler": function(button, event) {
	                                        var form = this.up('form').getForm();

	                                        /* Normally we would submit the form to the server here and handle the response...
	                                        form.submit({
	                                        clientValidation: true,
	                                        url: 'register.php',
	                                        success: function(form, action) {
	                                        //...
	                                    },
	                                    failure: function(form, action) {
	                                        //...
	                                    }
	                                });
	                                */

	                                form.submit({
	                                    clientValidation: true,
	                                    url: 'http://localhost:8080/CT_Contracts/Adder?',
	                                    success: function(form, action) {
	                                        //   Ext.Msg.alert('success');
	                                    },
	                                    failure: function(form, action) {
	                                        //  Ext.Msg.alert('failure');
	                                    }
	                                });



	                                if (form.isValid()) {
	                                    Ext.Msg.alert('Submitted Values', form.getValues(true));
	                                }
	                                    },
	                                    "text": "ПОИСК"
	                                }
	                            ]
	                        }
	                    ]
	                },
	                {
	                    "xtype": "toolbar",
	                    "dock": "top",
	                    "items": [
	                        {
	                            "xtype": "button",
	                            "height": 42,
	                            "width": 42,
	                            "iconCls": "icon-email32",
	                            "scale": "large",
	                            "text": ""
	                        },
	                        {
	                            "xtype": "button",
	                            "height": 42,
	                            "width": 42,
	                            "iconCls": "icon-mail",
	                            "scale": "large",
	                            "text": ""
	                        },
	                        {
	                            "xtype": "button",
	                            "iconCls": "icon-print",
	                            "text": "Отчеты",
	                            "menu": {
	                                "xtype": "menu",
	                                "minWidth": 150,
	                                "width": 150,
	                                "items": [
	                                    {
	                                        "xtype": "menuitem",
	                                        "icon": "images/printer.png",
	                                        "text": "Печать"
	                                    },
	                                    {
	                                        "xtype": "menuitem",
	                                        "text": "Отчет по тематикам"
	                                    },
	                                    {
	                                        "xtype": "menuitem",
	                                        "icon": "images/excel.png",
	                                        "text": "В Excell"
	                                    }
	                                ]
	                            }
	                        }
	                    ]
	                }
	            ],
	            "tools": [
	                {
	                    "xtype": "tool",
	                    "tooltip": "Справка",
	                    "type": "help"
	                }
	            ]
	            
	            
	            
	        });
		
	var form = Ext.create('Ext.form.Panel',
		{
		    "xtype": "form",
		    "height": 500,
		    "width": 1200,
		    "bodyPadding": 10,
		    "title": "",
		    "titleCollapse": false,
		    "jsonSubmit": true,
		    "method": "get",
		    "standardSubmit": true,
		    "url": "http://localhost:8080/CT_CONTRACT_ib/DataServletIB",
		    "items": [ grid ],
		    renderTo : 'content'// ,Ext.getBody(), //
		});
		
		    
		    
		   

		    
		    
	////////////////////////////////////////////////////////////////////////////////////////	 
	///  окно которое никогда не выйдет за границы экрана
	infoWin = Ext.create('Ext.Window', {
            title: 'Constrained Window',
            
            width: 250,
            height: 300,
            x: 20,
            y: 20,
            constrain: true,
            layout: 'fit',
            closable: false,
            tools: [
  	                {
  	                    "xtype": "tool",
  	                    "tooltip": "Справка",
  	                    "type": "help",
  	                    handler: function(){ infoWin.hide();}
  	                }
  	                ],
  	        items: [				
  	    		        new Ext.form.FormPanel({
  	    		            frame: true,
  	    		            
  	    		            items: [     
  	    		            { // HTML Content in windows
	  	    					xtype: 'box',
	  	    					width: '100%',
	  	    			        height: '100%',
	  	    					autoEl: {
	  	    							tag: 'iframe',
	  	    							src: 'add.jsp'
  	    		          
  	    		        		}  
  	    		            }]
  	    		 		})
  	    		 ]
          /* items:[ {xtype: 'form',
            		items:[
            
            	
		                    {
		            	  		//border: false,
		            	 		xtype: 'textfield',
		                 		name: 'searchField',
		                 		hideLabel: true,
		                 		width: 200,
		           		 	},{
		            	  		//border: false,
		            			xtype: 'textfield',
		                		name: 'search1Fielda',
		                		hideLabel: true,
		                		width: 200,
		            		}
		           		 ]
            		} 
            	]*/
			}).show();
			
	
		 
	    

		    
		    
		
		

    
    
    
    /*
    
	 var searchValue = Ext.getCmp("ehu").getValue();//get new value 
	    store.load().filter('jsonGridFielName', searchValue); //load filtered data
    */
    
    
    
	
    

  
   
    
}); 



</script>







