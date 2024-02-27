# impiger_flutter_chart

In this package contains Pie Chart, Image with Pie Chart, Single Bar Chart with Thick Bars, Single Bar Chart with Thin Bars, Two Bars Chart with Thin Bars and Line Chart.

Integration Steps:
1. Create a new Flutter project.
2. Add impiger_flutter_chart: ^0.0.3 plugin in your pubspec.yaml
3. Enter "flutter pub get" -> this command in your terminal
4. After completing the above steps, now you are able to use the GMChart class in your projects

Pie Chart:
Use GMPieChart class for getting pie chart widget in your screen

GMPieChart class need these parameters to create the chart widget, 
* list of colors
* list of values display in chart - double list
* list of names display in chart - String list
* chart value label color
* chart indicator label color
* empty list
* If the indicators shows in horizontal view then need to pass true values for isHorizontalIndicatorView parameter
 
Example:
GMPieChart(chartColorList, chartValuesList, chartNameList, Colors.black, Colors.black, 30.0, const [], true)


Pie Chart With Image:
Use GMPieChart class for getting pie chart widget in your screen

GMPieChart class need these parameters to create the chart widget,
* list of colors
* list of values display in chart - double list
* list of names display in chart - String list
* chart value label color
* chart indicator label color
* image url list - String list
* If the indicators shows in horizontal view then need to pass true values for isHorizontalIndicatorView parameter

Example:
GMPieChart(chartColorList, chartValuesList, chartNameList, Colors.black, Colors.black, 30.0, chartImageList, false)


Single Bar Chart with Thick Bars:

Use GMBarChart class for getting bar chart widget in your screen

GMBarChart class need these parameters to create the chart widget,
* list of values display in chart - double list
* list of names display in chart - String list
* chart bar color
* maximum Y axis values - Integer
* chart X axis label textStyle format
* If you need thick bars then pass false value for isThinChart parameter

Example:
GMBarChart(chartValuesList, chartNameList, Colors.orangeAccent, 10, const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.normal, fontSize: 15,), false)


Single Bar Chart with Thin Bars:

Use GMBarChart class for getting bar chart widget in your screen

GMBarChart class need these parameters to create the chart widget,
* list of values display in chart - double list
* list of names display in chart - String list
* chart bar color
* maximum Y axis values - Integer
* chart X axis label textStyle format
* If you need thin bars then pass true value for isThinChart parameter

Example:
GMBarChart(chartValuesList, chartNameList, Colors.orangeAccent, 10, const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.normal, fontSize: 15,), true)


Two Bars Chart with Thin Bars:
Use GMTwoBarChart class for getting bar chart widget in your screen

GMTwoBarChart class need these parameters to create the chart widget,

* list of names display in chart - String list
* chart left bar color
* chart right bar color
* list of bar 1 values display in chart - double list
* list of bar 2 values display in chart - double list
* maximum Y axis values - Integer

Example:
GMTwoBarChart(chartNameList, Colors.black, Colors.amberAccent, Colors.redAccent,chartBar1ValuesList,chartBar2ValuesList,20)





