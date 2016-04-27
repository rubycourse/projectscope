var SlackTrendGraphic = function(projectID, slackTrendURI) {
    this.slackTrendURI = slackTrendURI;
    this.getSlackTrendData = function() {
        jQuery.ajax({
            type: 'GET',
            url: this.slackTrendURI,
            timeout: 5000,
            success: this.showSlackTrendGraphic,
            error: function(xhrObj, textStatus, exception) {
                    alert('Slack Tend Graphic Error! ' + textStatus + ' ' + exception);
                }
                // 'success' and 'error' functions will be passed 3 args
        });
        return (false);
    };
    this.showSlackTrendGraphic = function(jsonData, requestStatus, xhrObject) {
        // Set a callback to run when the Google Visualization API is loaded.
        google.charts.setOnLoadCallback(drawTrendlines);

        function drawTrendlines() {
            var data = new google.visualization.DataTable();
            data.addColumn('number', 'X');
            data.addColumn('number', 'Score');
            var color = '#FFFFFF'

            var one_week_ago_data = jsonData.weekone;
            var two_week_ago_data = jsonData.weektwo;
            var three_week_ago_data = jsonData.weekthree;

            data.addRows([
                [0, three_week_ago_data],
                [1, two_week_ago_data],
                [2, one_week_ago_data]
            ]);

            var difference = one_week_ago_data - two_week_ago_data;

            if (one_week_ago_data <= 50) {
                color = 'red'
            }
            else if (one_week_ago_data <= 60 && one_week_ago_data > 50){
                color = 'yellow'
            }
            else {
                switch (true) {
                    case (difference <= -20):
                        color = 'red';
                        break;
                    case (difference <= -10):
                        color = 'yellow';
                        break;
                    default:
                        color = 'green';
                        break;
                }
            }

            var options = {
                hAxis: {
                    maxValue: 2,
                    minValue: 0,
                    textPosition: 'none',
                    gridlines: {
                        color: 'transparent'
                    }
                },
                vAxis: {
                    maxValue: 100,
                    minValue: 0,
                    ticks: [0,25,50,75,100],
                },
                legend: {
                    position: 'none'
                },
                colors: [color],
                pointsVisible: true,
                width: 75,
                height: 50

            };

            var chart = new google.visualization.LineChart(document.getElementById(projectID+'-slack-trend'));
            chart.draw(data, options);
        }

    };
};