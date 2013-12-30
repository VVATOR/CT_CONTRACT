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


//��� �������������� ������
function columnWordWrapSIMBOL(val) {
	return '<div style="word-wrap:word-wrap !important;">' + val + '</div>';
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
	
	var store1= Ext.create('Ext.data.Store', {
		
        autoLoad: true,
        model: 'ModelDocumentKOKT',
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
	
	var movieTpl = new Ext.XTemplate(
		    '<tpl for="."><div class="movie-item">',
		        '<h2><span>Year: {SUMMA}<br />Rating: {THEME}</span>{REG_DATE}</h2>',
		        '{description}',
		    '</div></tpl>'
		);
	
	var a='{THEME}';
	
	var tplGRDcellBTN = '<a href="DataServlet?a={SUMMA}"><img src="design/images/contract_status/warning.png" height="12px" width="12px"></a>';

		
	 
		
	var grid = Ext.create('Ext.grid.Panel', {
		Cmp:'gv',  //vv
		cls : 'linear',
		columnLines : true, // ����� ������� � �����
		bottom: 0,
		store : store,
		width : 'auto',
		height : 500,
		title : ' ', // ������
		
		
		
		///verticalScrollerType : 'paginggridscroller',
	   /* verticalScroller: {
            xtype: 'paginggridscroller',
            activePrefetch: false
        },*/
        
		disableSelection : false,
		invalidateScrollerOnRefresh : false,
		
		

		
		dockedItems: [  
						/*{
						    dock: 'top',
						    xtype: 'toolbar',
						    items: [{
						       
						        fieldLabel: 'Search',
						        labelWidth: 50,
						        xtype: 'searchfield',
						        store: store
						    }, '->', {
						        xtype: 'component',
						        itemId: 'status',
						        tpl: 'Matching threads: {count}',
						        style: 'margin-right:5px'
						    }]
						},*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
						{
						                    xtype: 'toolbar',
						                    dock: 'left',
						                    width: 351,
						                    items: [
						                			
						                        {
						                            xtype: 'form',
						                            width: 210,
						                            bodyPadding: 10,
						                            headerPosition: 'left',
						                            title: '������',
						                            titleCollapse: false,
						                            jsonSubmit: false,
						                            method: 'POST',
						                            standardSubmit: true,
						                            url: 'http://localhost:8080/CT_CONTRACT_ib/DataServletIB?SessionUser=vikhlaev',
						                            items: [
															{
															    xtype: 'combo',
															    store: store,
															    displayField: 'title*******************',
															    typeAhead: false,
															    hideLabel: false,
															    hideTrigger:true,
															    anchor: '100%',
															
															    listConfig: {
															        loadingText: 'Searching...',
															        emptyText: 'No matching posts found.',
															
															        // Custom rendering template for each item
															        getInnerTpl: function() {
															            return '<a class="search-item" href="http://www.sencha.com/forum/showthread.php?t={topicId}&p={id}">' +
															                '<h3><span>{[Ext.Date.format(values.lastPost, "M j, Y")]}<br />by {author}</span>{title}</h3>' +
															                '{excerpt}' +
															            '</a>';
															        }
															    },
															    pageSize: 10
															},	
																		
															    
															    
															    
															    ///////////////////////////////////
						                                {
						                                    xtype: 'button',
						                                    handler: function(button, event) {
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
																		        Ext.Msg.alert('success');
																		    },
																		    failure: function(form, action) {
																		        Ext.Msg.alert('failure');
																		    }
																		});
																		
																		
																		
																		if (form.isValid()) {
																		    Ext.Msg.alert('Submitted Values', form.getValues(true));
																		}

						                                    },
						                                    formBind: true,
						                                    disabled: true,
						                                    text: 'MyButton'
						                                },
						                                {
						                                    xtype: 'combobox',
						                                    frame: false,
						                                    id: 'A3',
						                                    width: 150,
						                                    fieldLabel: '����',
						                                    labelAlign: 'top',
						                                    name: 'the',
						                                    displayField: 'I',
						                                    enableRegEx: true,
						                                    pageSize: 10,
						                                    store: store1,
						                                    typeAhead: true
						                                },
						                                {
						                                    xtype: 'combobox',
						                                    width: 150,
						                                    fieldLabel: '���������������',
						                                    labelAlign: 'top',
						                                    name: 'pra',
						                                    displayField: 'NAMEDOG',
						                                    enableRegEx: true,
						                                    pageSize: 10,
						                                    store: store1,
						                                    typeAhead: true
						                                },
						                                {
						                                    xtype: 'combobox',
						                                    fieldLabel: '�����������<br>(�������������)',
						                                    labelAlign: 'top',
						                                    name: 'isp',
						                                    enableRegEx: true,
						                                    pageSize: 10,
						                                    store: store1,
						                                    typeAhead: true
						                                },
						                                {
						                                    xtype: 'combobox',
						                                    id: 'search',
						                                    fieldLabel: '��������',
						                                    labelAlign: 'top',
						                                    name: 'zak',
						                                    hideTrigger: true,
						                                    enableRegEx: true,
						                                    forceSelection: true,
						                                    pageSize: 10,
						                                    queryMode: 'local',
						                                    store: store1,
						                                    typeAhead: true
						                                }
						                            ]
						                        }
						                    ]
						                },
						////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
		            {	xtype: 'templatecolumn',
			            tpl: tplGRDcellBTN,
            			width:16,
            			//css:' padding:0px; margin:0px;',
  	                    renderer : columnWrap
	  	                    /*renderer: function(value, meta) { 
		  	                    if (value === '25') { 
		  	                        meta.tdCls = 'male-cell'; 
		  	                        return a+'<img src="design/images/document-icon32.png">Male'; 
		  	                    } 						  	     
		  	                    meta.tdCls = 'female-cell'; 
		  	                    return a+'<img src="design/images/folder-contract-icon.png">Female'; 
		  	              }*/
            		},
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
		
	                
	                
	                
	      /*          
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
		
		
		*/
		  
	    plugins: [{	    	
            ptype: 'rowexpander',            
            rowBodyTpl : [                          
	            <% /// ���� ������������ ����� ������ �� �������� ��� �����	                
	               if  (ACCESS.equals("0")){
	               		out.println("'<div color=black> �����: <font color=red> {SUMMA} </font> {CURRENCY}</div>'"); 
	               };
	            %> ,         
                '<div style="color: green;"> </div>',
                '<p><b>������ �������� ���������� �� ����, ��������� � ���������� ����� �� ��������:</b> <br> {ID_DOG}</p>',
                '<p><b>������ �������� ���������� �� ����:</b> <br> {ID_DOG}</p><br>',
                a
            ]
        }], 
       
        collapsible: true,
        collapse: true,


		
		
		renderTo : 'content'// ,Ext.getBody(), //
	});
    
    
    
    
    
    
    
    
}); 
</script>







