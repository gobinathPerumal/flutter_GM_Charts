import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GMBarChart extends StatefulWidget {
  List<dynamic> chartValuesList;
  List<String> chartNameList;
  TextStyle? chartXAxisTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
  bool? isThinChart = false;
  Color barColor;
  double maxYAxisValue;

  GMBarChart(this.chartValuesList, this.chartNameList, this.barColor, this.maxYAxisValue,{this.chartXAxisTextStyle,this.isThinChart,super.key});

  @override
  State<StatefulWidget> createState() => GMBarChartState(this.chartValuesList, this.chartNameList, this.barColor, this.maxYAxisValue,this.chartXAxisTextStyle, this.isThinChart);
}

class GMBarChartState extends State<GMBarChart> {
  List<dynamic> chartValuesList;
  List<String> chartNameList;
  TextStyle? chartXAxisTextStyle;
  Color barColor;
  double maxYAxisValue;
  bool? isThinChart;
  GMBarChartState(this.chartValuesList, this.chartNameList, this.barColor, this.maxYAxisValue,this.chartXAxisTextStyle, this.isThinChart);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: BarChart(
                randomData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getXAxisTitles(double value, TitleMeta meta) {
    Widget text = Text(
      chartNameList[value.toInt()],
      style: chartXAxisTextStyle,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
  BarChartData randomData() {
    return BarChartData(
      maxY: maxYAxisValue,
      barTouchData: BarTouchData(
        enabled: true,
      ),
      alignment: BarChartAlignment.spaceAround,
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getXAxisTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 30,
            showTitles: true,
          ),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,border:Border.all(color: barColor.withOpacity(0.3))
      ),
      barGroups: List.generate(
        chartValuesList.length,
        (item) => isThinChart??false?makeThinGroupData(
          item,
          chartValuesList[item].toDouble(),
        ):makeGroupData(
          item,
          chartValuesList[item].toDouble(),
        ),
      ),
      gridData: const FlGridData(show: false),
    );
  }

  BarChartGroupData makeGroupData(
      int x,
      double y,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color:  widget.barColor,
          borderRadius: BorderRadius.zero,
          width: 22,
          borderSide: BorderSide(color: widget.barColor, width: 2.0),
        ),
      ],
    );
  }

  BarChartGroupData makeThinGroupData(
      int x,
      double y,
      ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: _barsGradient,
        )
      ],
    );
  }

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      barColor,
      barColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

}
