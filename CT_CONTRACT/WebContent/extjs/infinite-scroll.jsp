<%@page import="vva.contract.data.db.SQLRequest"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
	pageEncoding="windows-1251"%>
	<%//String SessionUser="vikhlaev"; %>
<script>

<%
 /// ����������� ���� �������
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

// ��� �������������� ������
function columnWrap(val) {
	return '<div style="white-space:normal !important;">' + val + '</div>';
}

// ��� �������������� ������
function columnWordWrap(val) {
	return '<div style="white-space:word-wrap !important;">' + val + '</div>';
}

// ���������������
function renderTopic(value, p, record) {
	return Ext.String.format('<a href="{2}" target="_blank">{0}</a>', value,
			record.data.forumtitle, record.getId(), record.data.forumid);
}

/*
 * Ext.application({ name: 'HelloExt', launch: function() {
 * Ext.create('Ext.container.Viewport', { layout: 'fit', items: [ { title:
 * '���������� �� Ext JS 4', html : '<h3>����� ���������� � ��� Ext JS 4!</h3>' } ]
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
		         'DATA_W',
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
		         'USER_FIO1'
		         
			    ],
		idProperty : 'threadid'
	});

	// create the Data Store
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
			extraParams : {
				total : 50000
			},
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
	
	var pluginExpanded = true; // ��� ������ ���������
	
	var a='{THEME}';
	var grid = Ext.create('Ext.grid.Panel', {
		Cmp:'gv',  //vv
		cls : 'linear',
		columnLines : true, // ����� ������� � �����
		bottom: 0,
		store : store,
		width : 'auto',
		height : 500,
		title : ' ', // ������
		
		
		
		

	    
	    plugins: [{
	    	
            ptype: 'rowexpander',
            collapsed: false,
            rowBodyTpl : [                          
	            <% /// ���� ������������ ����� ������ �� �������� ��� �����	                
	               if  (ACCESS.equals("0")){
	               		out.println("'<div color=black> �����: <font color=red> {SUMMA} </font> {CURRENCY}</div>'"); 
	               };
	            %> ,         
                '<div style="color: green;"> xzxzxzx<br>xaxaxax]]</div>',
                '<p><b>������ �������� ���������� �� ����, ��������� � ���������� ����� �� ��������:</b> <br> {ID_DOG}</p>',
                '<p><b>������ �������� ���������� �� ����:</b> <br> {ID_DOG}</p><br>',
                
            ]
        }], 
       
        collapsible: true,
        animCollapse: true,
		
		
		
		
		
		
		
		///verticalScrollerType : 'paginggridscroller',
	   /* verticalScroller: {
            xtype: 'paginggridscroller',
            activePrefetch: false
        },*/
        
		disableSelection : false,
		invalidateScrollerOnRefresh : false,
		dockedItems: [  
							
		                {
		                    xtype: 'pagingtoolbar', 
		                    store: 'store',
		                    dock: 'bottom',
		                    rtl: false,
		                    afterPageText: ' �� {0}',
		                    beforePageText: '��������',
		                    displayInfo: true,
		                    displayMsg: '������ � {0} �� {1}  <b><u>�����: {2}</u></b>',
		                    emptyMsg: '��� ������ ��� �����������',
		                    firstText: '� ������',
		                    lastText: '� �����',
		                    nextText: '������ �� 200 �������',
		                    prevText: '����� �� 200 �������',
		                    refreshText: '��������',
		                   
		                    items:[
									new Ext.form.field.ComboBox({									   
										 xtype: 'timefield',
									        name: 'out',
									     renderer: function() 
											      {
											         return 'lol';
											      } 
								   })
								   ,
		                           '-', {
		                               text: '��������',
		                               enableToggle: true,
		                               handler: function(){winADD.show();}
		                              },
		                           '-', {
		                              text: '��������������',
		                              enableToggle: true,
		                              handler: function(){winEDIT.show();}
		                             },
		                           '-', {
		                            	 text: '�����������',
		                            	 handler: function(){winSuggestion.show();}
		                             },{
		     							xtype:'button',
		    							id:'frmAdd-btnAdd',
		    							text: 'Add',
		    								handler: function() {window.location='add.jsp';}
		    						}
		                         ]
		                },
		                {
		                    xtype: 'toolbar', 
		                    height: 48,
		                    dock: 'top',
		                    rtl: false,
		                    afterPageText: ' �� {0}',
		                    beforePageText: '��������',
		                    displayInfo: true,
		                    displayMsg: '������ � {0} �� {1}  <b><u>�����: {2}</u></b>',
		                    emptyMsg: '��� ������ ��� �����������',
		                    firstText: '� ������',
		                    lastText: '� �����',
		                    nextText: '������ �� 200 �������',
		                    prevText: '����� �� 200 �������',
		                    refreshText: '��������',
		                    items:[
									{
										xtype: 'button',
										scale   : 'large',
										text: '',
										height: 42,
										width: 42,

										iconCls: 'icon-email32',
										handler: function(){
															document.forms.Main.reset(); 
															//window.open("index.jsp?TYPESORTING=i");
															window.open("index.jsp?TYPESORTING=i");
															// allSort('i');
															}
									//Notes.jsp"
									},
									{
										xtype: 'button',
										scale   : 'large',
										text: '',
										height: 42,
										width: 42,

										iconCls: 'icon-mail',
										handler: function(){ 
															document.forms.Main.reset(); 
															window.open("index.jsp?TYPESORTING=all");
															// allSort('all');
															}
										//Notes.jsp"
									},{
										xtype: 'button',
										height: 32,
										width: 32,
										text: '',
										iconCls: 'icon-email32',
										handler: function(){ window.open("ya.ru");}
									//Notes.jsp"
									},{
										xtype: 'button',
										height: 32,
										width: 32,
										text: '',
										iconCls: 'icon-email32',
										handler: function(){ window.open("Notes.jsp");}
									},
									{
				                    text: '������',
				                    iconCls: 'icon-print',
				                    menu: {
				                        xtype: 'menu',
				                        minWidth: 150,
				                        width: 150,
				                        items: [ 
				                                
				                           /*  {	
				                            	 xtype: 'button',
				                            	 text: 'button',			                            
				                            	 handler : function(){
				         			            	Ext.ux.grid.Printer.printAutomatically = false;
				         			            	Ext.ux.grid.Printer.print(grid);	
				                            	 }
				                             },   */
				                             {				
											  xtype: 'menuitem',	
											  text: '������',
											  icon: 'images/printer.png',
											  handler: function(){winReport.show();}		
															
								            },																								
				                            {
				                                xtype: 'menuitem',
				                                text: '����� �� ���������'
				                            },
				                            {
				                                xtype: 'menuitem',
				                               // icon: 'icon-menu-excel',
				                               icon: 'images/excel.png',
				                               text: '� Excell'
				                            },
				                            {
				                                xtype: 'menuitem',
				                                text: '� PDF'
				                            }
				                        ]
				                    }
								}
		                         ]
		                }
		            ],
       
		        
		            
		// grid columns
		/*columns : [ {
			xtype : 'rownumberer',
			// flex: 1,
			width : 40,
			header : '� �/�'
		// ,renderer : renderTopic
		}, {
			header : "id",
			dataIndex : 'id',

			width : 40,

			hidden : false, // ������ ��� ������
			hideable : true, // ����������� ��������/���������� �������

			sortable : true
		// ��������� ����������

		}],*/
		columns: [
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'I',
	                    text: '�����<br>(ID_DOG)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'ID_DOG',
	                    text: '�������������<br>(ID_DOG)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'KONTROL',
	                    text: '<br>(KONTROL)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'ID_COUNT',
	                    text: '<br>(ID_COUNT)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'ID_ACCOUNT',
	                    text: '<br>ID_ACCOUNT'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'NAMEDOG',
	                    text: '<br>(NAMEDOG)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'NOM_DOG',
	                    text: '<br>(NOM_DOG)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'DATA_W',
	                    text: '<br>(DATA_W)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'SROK_PLAT',
	                    text: '<br>(SROK_PLAT)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'SUMMA',
	                    text: '<br>(SUMMA)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'CURRENCY',
	                    text: '<br>(CURRENCY)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'NOTE',
	                    text: '<br>(NOTE)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'IS_DEL',
	                    text: '<br>(IS_DEL)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'USER_FIO',
	                    text: '<br>(USER_FIO)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'STATUS',
	                    text: '<br>(STATUS)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'FULLNAMEDOG',
	                    text: '<br>(FULLNAMEDOG)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'PRIM',
	                    text: '<br>(PRIM)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'USL_POST',
	                    text: '<br>(USL_POST)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'DATE_STATUS',
	                    text: '<br>(DATE_STATUS)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'REG_NOM',
	                    text: '<br>(REG_NOM)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'REG_DATE',
	                    text: '<br>(REG_DATE)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'REG_SECT',
	                    text: '<br>(REG_SECT)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'REG_INDEX',
	                    text: '<br>(REG_INDEX)'
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'FULL_NUM',
	                    text: '<br>(FULL_NUM)',
	                    renderer : columnWrap
	                },
	                {
	                    xtype: 'gridcolumn',
	                    dataIndex: 'USER_FIO1',
	                    text: '<br>(USER_FIO1)',
	                    renderer : columnWrap
	                }
	                /*,
	                {
	                    xtype: 'gridcolumn',
	                    sortable: false,
	                    text: '�����',
	                    columns: [
	                        {
	                            xtype: 'datecolumn',
	                            dataIndex: 'DATE_REG',
	                            text: '���� �����������<br>(DATE_REG)',
	                            format: 'd.m.Y'
	                        },
	                        {
	                            xtype: 'datecolumn',
	                            dataIndex: 'DEADLINE',
	                            text: '���� ����������<br>(DEADLINE)',
	                            format: 'd.m.Y'
	                        }
	                    ]
	                }
	                */
	            ],
	            tools: [
	                    {
	                        xtype: 'tool',
	                        handler: function(event, toolEl, owner, tool) {
	                            var params = "menubar=yes,location=yes,resizable=yes,scrollbars=yes,status=yes";
	                            window.open("http://ya.ru/", "Yandex", params)

	                        },
	                        rtl: false,
	                        tooltip: '�������',
	                        type: 'help'
	                    },
	                    {
	                        xtype: 'tool',
	                        type: 'up'
	                    }
	                ],
		viewConfig : {
			loadMask : false,
			trackOver : false,
			stripeRows : true,
			enableTextSelection : true,
			
			getRowClass : function(record) {
				var typeRow = 'typeRow';
				switch (record.get('ID_DOG')) {
				case '��':
					typeRow = 'control-card';
					break;
				case '���':
					typeRow = 'linear';
					break;
				}
				;

				return typeRow;
			}
		},
		renderTo : 'content'// ,Ext.getBody(), //
	});

	// trigger the data store load
	store.guaranteeRange(0, 199);


	
	
	
////////////////////////////////////////////////////////////////////////////////////////
/// ���� �������������� ������
////////////////////////////////////////////////////////////////////////////////////////	
var winEDIT = new Ext.Window({
		    title: "�������������� ������",
		    modal: true,       // ����������� ���� ��������  (ShowModal)
		    constrain: true,   // ������ ������ �� ����� ���� ������ �����
		    border: true,      //vv
			loadMask : true,  //vv
		    width: 700,
		    height: 800,
		    layout:'fit',
		    closable: false,
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
							src: 'http://bl-04:8080/DocumentsKOKT/EDITItem.jsp?SessionUser=Vikhlaev&ADMINISTRATOR=true&FULLNAME=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.&DEPARTMENT=%CA%C8%CE+%C2%D1&editNumber=9628&editNumberDep=385&editProduct=%CE%E1%F9%E5%E5&editOwner=%CA%E8%F1%E5%EB%E5%E2+%C5.%C2.&editRegNumber=%E1%2F%ED&editOutNumber=15545+%EE%F2+22.11.2013&editDocType=%C4%EE%EA%EB%E0%E4%ED%E0%FF+%E7%E0%EF%E8%F1%EA%E0&editDescription=%CE+%F0%E0%E7%F0%E5%F8%E5%ED%E8%E8+%E4%EE%F1%F2%F3%EF%E0+%ED%E0+%F1%E0%E9%F2&editNote=&editControlStatus=%CD%E5%F2&User0=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.&Status0=%F5%F0%E0%ED%E5%ED%E8%E5&Execute0=%C2%FB%EF%EE%EB%ED%E5%ED%EE&DateOfRead0=25.11.2013&sUsersCount=1&sDepartmentCount=0&sCurrentUsersCount=1&sCurrentDepartmentCount=0&TYPESORTING=all&START_PAGING=&END_PAGING=&selByISPFamily=%C2%F1%E5&selStartDate=01.01.2000&selEndDate=26.11.2013&selIdDep=&selOnControler='
								//'EDITItem.jsp'
								/*function(){	
								return 
								 'EDITItem.jsp'+
							     '&ADMINISTRATOR=true&FULLNAME=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.&DEPARTMENT=%CA%C8%CE+%C2%D1'+
							     '&editNumber=9628&editNumberDep=385&editProduct=%CE%E1%F9%E5%E5&editOwner=%CA%E8%F1%E5%EB%E5%E2+%C5.%C2.'+
							     '&editRegNumber=%E1%2F%ED&editOutNumber=15545+%EE%F2+22.11.2013'+
							     '&editDocType=%C4%EE%EA%EB%E0%E4%ED%E0%FF+%E7%E0%EF%E8%F1%EA%E0'+
							     '&editDescription=%CE+%F0%E0%E7%F0%E5%F8%E5%ED%E8%E8+%E4%EE%F1%F2%F3%EF%E0+%ED%E0+%F1%E0%E9%F2'+
							     '&editNote=&editControlStatus=%CD%E5%F2&User0=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.'+
							     '&Status0=%F5%F0%E0%ED%E5%ED%E8%E5&Execute0=%C2%FB%EF%EE%EB%ED%E5%ED%EE'+
							     '&DateOfRead0=25.11.2013&sUsersCount=1&sDepartmentCount=0'+
							     '&sCurrentUsersCount=1&sCurrentDepartmentCount=0&TYPESORTING=all'+
							     '&START_PAGING=&END_PAGING=&selByISPFamily=%C2%F1%E5'+
							     '&selStartDate=01.01.2000&selEndDate=26.11.2013&selIdDep=&selOnControler='
								}*/
							}
					}/*,
		            {   xtype: "panel",
		                html: new Ext.XTemplate("<a href='#'>{value}").apply({
		                    value: '�� ���!'
		                })
		            },{
		                xtype: 'textfield',
		                id:'jsID_DEP',
		                fieldLabel: '� �/� 1:'
		            },{
		                xtype: 'textfield',
		                id:'jsPRODUCT',
		                fieldLabel: '������:'
		            },{
		                xtype: 'textfield',
		                id:'jsAUTHOR',
		                fieldLabel: '�����������:'
		            },{
		                xtype: 'textfield',
		                id:'jsREG_NUMBER',
		                fieldLabel: '� �������.:'
		            },{
		                xtype: 'textfield',
		                id:'jsOUT_NUMBER',
		                fieldLabel: '� �����:'
		            },{
		                xtype: 'textfield',
		                id:'jsDOCTYPE',
		                fieldLabel: '��� ���������:'
		            },{
		                xtype: 'textarea',
		                id:'jsDESCRIPTION',
		                fieldLabel: '������� ����������:',
		                hideLabel: false,
		                name: 'msg',
		                style: 'margin:0', // Remove default margin
		                flex: 1  // Take up all *remaining* vertical space
		            },{
		                xtype: 'textarea',
		                id:'jsNOTE',
		                fieldLabel: '����������:',		               
		                hideLabel: false,
		                name: 'msg',
		                style: 'margin:0', // Remove default margin
		                flex: 1  // Take up all *remaining* vertical space
		            },{
		                xtype: 'textfield',
		                id:'jsCONTROL_STATUS',
		                fieldLabel: '�� ��������:'
		            },{
		                xtype: 'textfield',
		                id:'jsEXECUTE',
		                fieldLabel: '������ ������������:'
		            },{
		                xtype: 'textfield',
		                id:'poles3',
		                fieldLabel: '����� �������� � ������:'
		            },{
		                xtype: 'textfield',
		                id:'jsFILE_ID',
		                fieldLabel: '����:'
		            },{
		        		xtype:'button',
		        		id:'frmAdd-btnADD',
		        		text: '�������������',
		        		handler: function(key, value) {
									var form = this.up('form').getForm(),
									s = '';
									if (form.isValid()) {
									    Ext.iterate(form.getValues(), function(key, value) {
									        s += Ext.util.Format.format("{0} = {1}<br />", key, value);
									}, this);
									
									Ext.Msg.alert('��������: ', s);
									}
		        			
		        				}
		        	},{
		        		xtype:'button',
		        		id:'frmAdd-btnAbort',
		        		text: '������',
		        			handler: function() {winEDIT.hide();}
		        	}
		            */
		          ]
		        })        	
		        	
		       
		    ]
		 });
	 
///
////////////////////////////////////////////////////////////////////////////////////////
	 
	 
////////////////////////////////////////////////////////////////////////////////////////
/// ���� ���������� ������
////////////////////////////////////////////////////////////////////////////////////////
		
		 var winADD = new Ext.Window({
			    title: "���������� ������",
			    modal: true,       // ����������� ���� ��������  (ShowModal)
			    constrain: true,   // ������ ������ �� ����� ���� ������ �����
			    border: true,      //vv
				loadMask : true,  //vv
			    width: 700,
			    height: 800,
			    layout:'fit',
			    closable: false,  // ������� ��� �������� ����
			    items: [
			        new Ext.form.FormPanel({       
			            frame: true,
			            
			            items: [  
						{
							xtype:'button',
							id:'frmAdd-btnAbort',
							text: '������',
								handler: function() {winADD.hide();}
						},
			            { // HTML Content in windows
						xtype: 'box',
						width: '100%',
				        height: '100%',
						autoEl: {
								tag: 'iframe',
								src: 'ADDItem.jsp'
								}
						},
			            {   xtype: "panel",
			                html: new Ext.XTemplate("<a href='#'>{value}").apply({
			                    value: '�� ���'
			                })
			            },{
			                xtype: 'textfield',
			                id:'jsID_DEP',
			                fieldLabel: '� �/� 1:'
			            },{
			                xtype: 'textfield',
			                id:'jsPRODUCT',
			                fieldLabel: '������:',
			                emptyText: '<%//=SessionUser %>'
			            },{
			                xtype: 'textfield',
			                id:'jsAUTHOR',
			                fieldLabel: '�����������:'
			            },{
			                xtype: 'textfield',
			                id:'jsREG_NUMBER',
			                fieldLabel: '� �������.:'
			            },{
			                xtype: 'textfield',
			                id:'jsOUT_NUMBER',
			                fieldLabel: '� �����:'
			            },{
			                xtype: 'textfield',
			                id:'jsDOCTYPE',
			                fieldLabel: '��� ���������:'
			            },{
			                xtype: 'textarea',
			                id:'jsDESCRIPTION',
			                fieldLabel: '������� ����������:',
			                hideLabel: false,
			                name: 'msg1',
			                style: 'margin:0', // Remove default margin
			                flex: 1  // Take up all *remaining* vertical space
			            },{
			                xtype: 'textarea',
			                id:'jsNOTE',
			                fieldLabel: '����������:',		               
			                hideLabel: false,
			                name: 'msg',
			                style: 'margin:0', // Remove default margin
			                flex: 1  // Take up all *remaining* vertical space
			            },{
			                xtype: 'textfield',
			                id:'jsCONTROL_STATUS',
			                fieldLabel: '�� ��������:'
			            },{
			                xtype: 'textfield',
			                id:'jsEXECUTE',
			                fieldLabel: '������ ������������:'
			            },{
			                xtype: 'textfield',
			                id:'poles3',
			                fieldLabel: '����� �������� � ������:'
			            },{
			                xtype: 'textfield',
			                id:'jsFILE_ID',
			                fieldLabel: '����:'
			            },{
			        		xtype:'button',
			        		id:'frmAdd-btnADD',
			        		text: '�������������',
			        		handler: function(key, value) {
										var form = this.up('form').getForm(),
										s = '';
										if (form.isValid()) {
										    Ext.iterate(form.getValues(), function(key, value) {
										        s += Ext.util.Format.format("{0} = {1}<br />", key, value);
										}, this);										
										Ext.Msg.alert('��������: ', s);
										}
			        				}
			        	}			            
			          ]
			        })     
			    ]
			 });		 
///
////////////////////////////////////////////////////////////////////////////////////////
	 
	
////////////////////////////////////////////////////////////////////////////////////////
/// ���� winReport
////////////////////////////////////////////////////////////////////////////////////////		
var winReport = new Ext.Window({
			    title: "Report",
			    modal: true,       // ����������� ���� ��������  (ShowModal)
			    constrain: true,   // ������ ������ �� ����� ���� ������ �����
			    border: true,      //vv
				loadMask : true,  //vv
			    width: 700,
			    height: 800,
			    layout:'fit',
			    closable: false,  // ������� ��� �������� ����
			    items: [
			        new Ext.form.FormPanel({       
			            frame: true,
			            
			            items: [  
						{
							xtype:'button',
							id:'frmAdd-btnAbort',
							text: '������',
								handler: function() {winReport.hide();}
						},
			            { // HTML Content in windows
						xtype: 'box',
						width: '100%',
				        height: '100%',
						autoEl: {
								tag: 'iframe',
								src: <%									
										//URL = "'Report.jsp?SessionUser=" + SessionUser+"'";
										out.print("''");
									    %>									 
								}
						}
			          ]
			        })     
			    ]
			 });		 
	///
	
	
////////////////////////////////////////////////////////////////////////////////////////
/// ���� winReport
////////////////////////////////////////////////////////////////////////////////////////		
var winSuggestion = new Ext.Window({
			    title: "�����������",
			    modal: true,       // ����������� ���� ��������  (ShowModal)
			    constrain: true,   // ������ ������ �� ����� ���� ������ �����
			    border: true,      //vv
				loadMask : true,  //vv
			    width: 700,
			    height: 800,
			    layout:'fit',
			    closable: false,  // ������� ��� �������� ����
			    items: [
			        new Ext.form.FormPanel({       
			            frame: true,
			            
			            items: [  
						{
							xtype:'button',
							id:'frmAdd-btnAbort',
							text: '������',
								handler: function() {winSuggestion.hide();}
						},{ 
						// HTML Content in windows
						xtype: 'box',
						width: '100%',
				        height: '100%',
						autoEl: {
								tag: 'iframe',
								src: <%									
									//	URL = "'Notes.jsp'";
										out.print("''");
									    %>									 
								}
						}
			          ]
			        })     
			    ]
			 });	
	
	////////////////////////////////////////////////////////////////////////////////////////	 
	///  ���� ������� ������� �� ������ �� ������� ������
	 /*constrainedWin = Ext.create('Ext.Window', {
            title: 'Constrained Window',
            width: 100,
            height: 100,
            x: 20,
            y: 20,
            constrain: true,
            layout: 'fit',
            items: {
                border: false
            }
            }).show()
	*/	 

	
	
	
	
	
	
	

	
	
	
	
	
		}); 
</script>







