var vg_1 = "crash_type_age_group.vg.json";
vegaEmbed("#stacked_bar_chart", vg_1, {action: false}).then(function(result) {
// Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
}).catch(console.error);


var vg_2 = "map.vg.json";
vegaEmbed("#chloro_map",vg_2, {action: false}).then(function(result) {
// Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
}).catch(console.error);

var vg_3 = "line_chart.vg.json";
vegaEmbed("#line_chart", vg_3, {action: false}).then(function(result) {
    // Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
    }).catch(console.error);

var vg_4 = "bar_chart_crash_type.vg.json";
vegaEmbed("#bar_chart2", vg_4, {action: false}).then(function(result) {
        // Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
        }).catch(console.error);


var vg_5 = "lasagna_heat_map.vg.json";
vegaEmbed("#heat_map", vg_5, {action: false}).then(function(result) {
        // Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.vie
        }).catch(console.error);