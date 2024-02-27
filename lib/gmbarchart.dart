import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GMBarChart extends StatefulWidget {
  final List<dynamic> chartValuesList;
  final List<String> chartNameList;
  final TextStyle chartXAxisTextStyle;
  final bool? isThinChart;
  final Color barColor;
  final double maxYAxisValue;

  const GMBarChart(this.chartValuesList, this.chartNameList, this.barColor, this.maxYAxisValue,this.chartXAxisTextStyle,this.isThinChart,{super.key});

  @override
  State<StatefulWidget> createState() => GMBarChartState();
}

class GMBarChartState extends State<GMBarChart> {
  GMBarChartState();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
      widget.chartNameList[value.toInt()],
      style: widget.chartXAxisTextStyle,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
  BarChartData randomData() {
    return BarChartData(
      maxY: widget.maxYAxisValue,
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
        topTitles:  const AxisTitles(
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
        show: true,border:Border.all(color: widget.barColor.withOpacity(0.3))
      ),
      barGroups: List.generate(
        widget.chartValuesList.length,
        (item) => widget.isThinChart??false?makeThinGroupData(
          item,
          widget.chartValuesList[item].toDouble(),
        ):makeGroupData(
          item,
          widget.chartValuesList[item].toDouble(),
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
      widget.barColor,
      widget.barColor,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

}
