var vg_1 = "fat_gender_bar.vg.json";
vegaEmbed("#bar_chart", vg_1).then(function(result) {
// Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
}).catch(console.error);


var vg_2 = "map.vg.json";
vegaEmbed("#chloro_map", vg_2).then(function(result) {
// Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
}).catch(console.error);

var vg_3 = "line_chart.vg.json";
vegaEmbed("#line_chart", vg_3).then(function(result) {
    // Access the Vega view instance(https://vega.github.io/vega/docs/api/view/) as result.view
    }).catch(console.error);