Sys.Application.add_load(function () {
    var data = [];
    if (categoryCounts) {
        if (typeof categoryCounts.categoryCount != "undefined") {
            var obj = categoryCounts.categoryCount;
            for (var i = 0; i < obj.length; i++) {
                data.push([obj[i].Category, obj[i].Value]);
            }
        }
    }

    var total = 0;
    $(data).map(function () { total += this[1]; })
    myLabels = $.makeArray($(data).map(function () { return this[1] + " \u20AC - " + Math.round(this[1] / total * 100) + "%"; }));

    piePlot = $.jqplot('chartCategoryDistribution', [data], {
        grid: {
            drawBorder: false,
            drawGridlines: false,
            background: '#efeeef',
            shadow: false
        },
        title: 'Rozloženie kategorií výdavkov',
        axesDefaults: {

        },
        seriesDefaults: {
            renderer: $.jqplot.PieRenderer,
            rendererOptions: {
                showDataLabels: true,
                dataLabels: myLabels
            }
        },
        legend: {
            show: true,
            location: 's'
        }
    });
});