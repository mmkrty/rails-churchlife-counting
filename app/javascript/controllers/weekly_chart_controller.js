import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="weekly-chart"
export default class extends Controller {
  static targets = ["weekly-chart"];

  connect() {
    console.log("connected 1");
    google.charts.load("current", { packages: ["corechart"] });
    google.charts.setOnLoadCallback(this.drawAllCharts.bind(this));
  }

  drawAllCharts() {
    this.drawLineChart(this.smallGroupsMultiData, "small-group-location");
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
      title: "Small Groups by Location",
      curveType: "function",
      legend: { position: "right" },
    };

    const chart = new google.visualization.LineChart(
      this.element.querySelector(`#${chartId}`)
    );

    chart.draw(dataTable, options);
  }

  get smallGroupsMultiData() {
    return JSON.parse(
      this.element.getAttribute("data-weekly-chart-small-groups-multi-data")
    );
  }
}
