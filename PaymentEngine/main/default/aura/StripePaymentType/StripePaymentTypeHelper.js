({
    buildYearOptions : function(component) {
        var options = [];
        for (var i = 0 ; i < 20 ; i++) {
            var year = new Date().getFullYear() + i;
            var option = {label : year,value : year};
            options.push(option);
        }
        component.find('year').setSelectOptions(options,options[0].value);
    },
    buildMonthOptions : function(component) {
        var options = [];
        for (var i = 1 ; i < 13 ; i++) {
            var monthOption = i;
            if (i < 10) {
                monthOption = '0'+monthOption;
            }
            var option = {label : monthOption.toString(),value : monthOption.toString()};
            options.push(option);
        }
        component.find('month').setSelectOptions(options,options[0].value);
    },
    toggleButtonEvent : function(buttonGroup) {
        var compEvent = $A.get('e.Framework:ButtonToggleIndicatorEvent');
        compEvent.setParams({
            group : buttonGroup
        });
        compEvent.fire();
    }
});
