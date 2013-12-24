<%@ page language="java" contentType="text/html; charset=windows-1251"
	pageEncoding="windows-1251"%>
	<%//String SessionUser="vikhlaev"; %>
<script>
/*

This file is part of Ext JS 4

Copyright (c) 2011 Sencha Inc

Contact:  http://www.sencha.com/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 3.0 as published by the Free Software Foundation and appearing in the file LICENSE included in the packaging of this file.  Please review the following information to ensure the GNU General Public License version 3.0 requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department at http://www.sencha.com/contact.

 */



// /////////////////////////////////////////////////
Ext.Loader.setConfig({
	enabled : true
});

Ext.Loader.setPath('Ext.ux', 'extjs/ux/');
Ext.require([ 'Ext.grid.*', 
              'Ext.data.*', 
              'Ext.util.*', 
              'Ext.ux.grid.Printer',
              'Ext.grid.PagingScroller',
                           ]);

Ext.onReady(function() {
	Ext.define('ModelDocumentKOKT', {
		extend : 'Ext.data.Model',
		fields :[ 'id' ],
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
			url : 'DataServlet?SessionUser=vikhlaev',// http://ws-16:8080/DKOKT_ext/
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


////////////////////////////////////////////////////////////////////////////////////////
/// окно Добавление записи
////////////////////////////////////////////////////////////////////////////////////////
///  окно которое никогда не выйдет за границы экрана
var	 constrainedWin = Ext.create('Ext.Window', {
            title: 'Constrained Window',
            width: 500,
            height: '100%',
            x: 20,
            y: 20,
            constrain: true,
            layout: 'fit',
                     
            items: [                   
                    {
                        xtype: 'form',
                        id:'eaddfrm',
                        title: 'My Form',
                        url: 'DataServletWriter',
                        waitMsg: 'Loading...',
                        method: 'POST',
                        items: [
							{
							// HTML Content in windows            
							xtype: 'box',
							width: 300,
						    height: 300,
							autoEl: {
									tag: 'iframe',
									id:'frameAdd',
									src: 'add.jsp?SessionUser=Vikhlaev&ADMINISTRATOR=true&FULLNAME=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.&DEPARTMENT=%CA%C8%CE+%C2%D1&editNumber=9628&editNumberDep=385&editProduct=%CE%E1%F9%E5%E5&editOwner=%CA%E8%F1%E5%EB%E5%E2+%C5.%C2.&editRegNumber=%E1%2F%ED&editOutNumber=15545+%EE%F2+22.11.2013&editDocType=%C4%EE%EA%EB%E0%E4%ED%E0%FF+%E7%E0%EF%E8%F1%EA%E0&editDescription=%CE+%F0%E0%E7%F0%E5%F8%E5%ED%E8%E8+%E4%EE%F1%F2%F3%EF%E0+%ED%E0+%F1%E0%E9%F2&editNote=&editControlStatus=%CD%E5%F2&User0=%C2%E8%F5%EB%FF%E5%E2+%C2.%C0.&Status0=%F5%F0%E0%ED%E5%ED%E8%E5&Execute0=%C2%FB%EF%EE%EB%ED%E5%ED%EE&DateOfRead0=25.11.2013&sUsersCount=1&sDepartmentCount=0&sCurrentUsersCount=1&sCurrentDepartmentCount=0&TYPESORTING=all&START_PAGING=&END_PAGING=&selByISPFamily=%C2%F1%E5&selStartDate=01.01.2000&selEndDate=26.11.2013&selIdDep=&selOnControler='
										//'EDITItem.jsp'
									}
							},    
							{					   
					            xtype: 'button',
					            text: 'sss',
					            handler: function(){
					            	addFRM.submit({
					                    success: function(form, action) {
					                        Ext.Msg.alert('Success', action.result.message);
					                    },

					                    // If you don't pass success:true, it will always go here
					                    failure: function(form, action) {
					                        Ext.Msg.alert('Failed', action.result ? action.result.message : 'No response');
					                    }
					                });
					            	
					            }
							},
                            {
                                xtype: 'textfield',
                                anchor: '100%',
                                fieldLabel: 'Номер договора',
                                labelWidth: 200
                            },
                            {
                                xtype: 'combobox',
                                anchor: '100%',
                                fieldLabel: 'Заказчик',
                                labelWidth: 200
                            },
                            {
                                xtype: 'combobox',
                                anchor: '100%',
                                fieldLabel: 'Исполнитель',
                                labelWidth: 200
                            },
                            {
                                xtype: 'combobox',
                                anchor: '100%',
                                fieldLabel: 'Правообладатель результатов работ по договору',
                                labelWidth: 200
                            }
                        ]
                    }
                ],
                dockedItems: [
                    {
                        xtype: 'toolbar',
                        dock: 'bottom',
                        items: [
                            {
                                xtype: 'button',
                                text: 'MyButton'
                            }
                        ]
                    }
                ]
            
            }).show();
		

});

</script>







