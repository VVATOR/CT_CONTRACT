var  Win = Ext.create('Ext.Window', {
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
            }).show();
