import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["chart"];

  connect() {
    // Load the Visualization API and the corechart package
    console.log("chart connected");
    google.charts.load("current", { packages: ["corechart"] });
    google.charts.setOnLoadCallback(this.drawAllCharts.bind(this));
  }

  drawAllCharts() {
    this.drawChart(this.lordsDaysData, "lords-days-chart");
    this.drawChart(this.prayerMeetingsData, "prayer-meetings-chart");
    this.drawChart(this.smallGroupsData, "small-groups-chart");
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

  drawChart(dataset, chartId) {
    // Create a data table
    const data = new google.visualization.DataTable();
    data.addColumn("string", "Week");
    data.addColumn("number", "Total");
    data.addColumn("number", "Adults");
    data.addColumn("number", "Teenagers");
    data.addColumn("number", "Children");
    data.addColumn("number", "Toddlers");
    data.addRows(dataset);

    const chartTitle = this.formatChartTitle(chartId);

    // Set chart options
    const options = {
      title: `${chartTitle} Weekly Statistics`,
      titleTextStyle: {
        fontSize: 18,
        fontName: "Nunito",
        color: "#333",
      },
      hAxis: {
        title: "Week Number and Year",
        titleTextStyle: { fontName: "Nunito" },
      },
      vAxes: [
        { title: "Total" },
        {
          title: "Number of People",
          titleTextStyle: { color: "#FF0000", fontName: "Nunito" },
          textStyle: { color: "#FF0000", fontName: "Work Sans" },
        },
      ],
      seriesType: "bars",
      series: {
        0: { type: "line", targetAxisIndex: 0 },
        1: { targetAxisIndex: 1 },
        2: { targetAxisIndex: 1 },
        3: { targetAxisIndex: 1 },
        4: { targetAxisIndex: 1 },
      },
      colors: ["#0000FF", "#3366CC", "#DC3912", "#FF9900", "#109418"],
    };

    // Instantiate and draw the chart
    const chart = new google.visualization.ComboChart(
      document.getElementById(chartId)
    );
    chart.draw(data, options);
  }

  get lordsDaysData() {
    return JSON.parse(this.data.get("lordsDaysData"));
  }
  get prayerMeetingsData() {
    return JSON.parse(this.data.get("prayerMeetingsData"));
  }

  get smallGroupsData() {
    return JSON.parse(this.data.get("smallGroupsData"));
  }
}
