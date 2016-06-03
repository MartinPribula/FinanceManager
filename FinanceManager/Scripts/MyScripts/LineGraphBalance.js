Sys.Application.add_load(function () {
    var data = [];
    data.push([]);
    if (balanceProgress) {
        if (typeof balanceProgress.balProg != "undefined") {
            var obj = balanceProgress.balProg;
            for (var i = 0; i < obj.length; i++) {
                var value = obj[i];
                data[0].push(value);
            }
        }
    }

    $.jqplot('chartBalanceProgress', data, {
        title: 'Stav financií v uplynulom mesiaci',
        axesDefaults: {
            lableRender: $.jqplot.CanvasAxisLabelRender,

        },
        seriesDefaults: {
            renderOptions: {
                smooth: true
            },
            showMarker: false
        },
        axes: {
            // options for each axis are specified in seperate option objects.
            xaxis: {
                label: "Ďeň",
                // Turn off "padding".  This will allow data point to lie on the
                // edges of the grid.  Default padding is 1.2 and will keep all
                // points inside the bounds of the grid.
                pad: 0
            },
            yaxis: {
                label: "Stav v \u20AC"
            }
        }
    });
});