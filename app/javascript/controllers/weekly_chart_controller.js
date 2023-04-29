import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="weekly-chart"
export default class extends Controller {
  static targets = ["weekly-chart"];

  connect() {
    console.log("connected 11");
    google.charts.load("current", { packages: ["corechart"] });
    google.charts.setOnLoadCallback(this.drawAllCharts.bind(this));
  }

  formatChartTitle(title) {
    // Replace hyphens with spaces
    let formattedTitle = title.replace(/-/g, " ");

    // Remove "Chart" suffix
    formattedTitle = formattedTitle.replace(/ chart/gi, "");

    // Capitalize the first letter of each word
    formattedTitle = formattedTitle.replace(/\b\w/g, (char) =>
      char.toUpperCase()
    );

    return formattedTitle;
  }

  drawAllCharts() {
    this.drawLineChart(this.smallGroupsMultiData, "small-group-location");
    this.drawChart(this.lordsDaysData, "lords-days");
    this.drawChart(this.prayerMeetingsData, "prayer-meetings");
    this.drawChart(this.smallGroupsData, "small-groups");
  }

  drawLineChart(data, chartId) {
    console.log(data);
    const dataTable = new google.visualization.DataTable();
    dataTable.addColumn("string", "Week");
    const locations = data;
    locations.forEach((location) => {
      dataTable.addColumn("number", location[0]);
    });
    const rows = [];
    const numWeeks = locations[0][1].length;
    for (let i = 0; i < numWeeks; i++) {
      const row = [locations[0][1][i][0]];
      locations.forEach((location) => {
        row.push(location[1][i][1]);
      });
      rows.push(row);
    }
    dataTable.addRows(rows);

    const options = {
      hAxis: {
        titleTextStyle: { fontName: "Nunito" },
      },
      curveType: "function",
      legend: { position: "top" },
      responsive: true,
    };

    const chart = new google.visualization.LineChart(
      this.element.querySelector(`#${chartId}`)
    );

    chart.draw(dataTable, options);
  }

  drawChart(dataset, chartId) {
    // Create a data table
    const data = new google.visualization.DataTable();
    data.addColumn("string", "Week");
    data.addColumn("number", "Total");
    data.addColumn("number", "Adults");
    data.addColumn("number", "Teenagers");
    data.addColumn("number", "Children");
    data.addRows(dataset);

    // Set chart options
    const options = {
      seriesType: "bars",
      series: {
        0: { type: "line" },
        1: {},
        2: {},
        3: {},
        4: {},
      },
      colors: ["#0000FF", "#3366CC", "#DC3912", "#FF9900"],
      responsive: true,
      legend: { position: "top" },
      vAxes: [
        {
          title: "Number of People",
          titleTextStyle: { fontName: "Nunito" },
        },
      ],
      hAxis: {
        title: "Week",
        titleTextStyle: { fontName: "Nunito" },
      },
    };

    // Instantiate and draw the chart
    const chart = new google.visualization.ComboChart(
      document.getElementById(chartId)
    );
    chart.draw(data, options);
  }

  get smallGroupsMultiData() {
    return JSON.parse(
      this.element.getAttribute("data-weekly-chart-small-groups-multi-data")
    );
  }

  get lordsDaysData() {
    return JSON.parse(
      this.element.getAttribute("data-weekly-chart-lords-days-data")
    );
  }

  get prayerMeetingsData() {
    return JSON.parse(
      this.element.getAttribute("data-weekly-chart-prayer-meetings-data")
    );
  }

  get smallGroupsData() {
    return JSON.parse(
      this.element.getAttribute("data-weekly-chart-small-groups-data")
    );
  }
}
