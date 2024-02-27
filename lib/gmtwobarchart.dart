import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GMTwoBarChart extends StatefulWidget {
  final List<String> chartNameList;
  final List<dynamic> chartY1ValuesList;
  final List<dynamic> chartY2ValuesList;
  final Color chartXAxisTextColor;
  final Color leftBarColor;
  final Color rightBarColor;
  final double maxYAxisValue;

  const GMTwoBarChart(this.chartNameList,this.chartXAxisTextColor, this.leftBarColor, this.rightBarColor, this.chartY1ValuesList, this.chartY2ValuesList,this.maxYAxisValue,{super.key});
  @override
  State<StatefulWidget> createState() => GMTwoBarChartState();
}

class GMTwoBarChartState extends State<GMTwoBarChart> {
  final double width = 7;

   List<BarChartGroupData> rawBarGroups = [];
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    rawBarGroups.clear();
    for(int item = 0; item<widget.chartY1ValuesList.length; item++){
      rawBarGroups.add(makeGroupData(item,widget.chartY1ValuesList[item].toDouble(),widget.chartY2ValuesList[item].toDouble()));
    }
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:250,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: widget.maxYAxisValue,
                  borderData: FlBorderData(
                      show: true,border:Border.all(color: Colors.black.withOpacity(0.2))
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                      ),
                    ),
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {

    final Widget text = Text(
      widget.chartNameList[value.toInt()],
      style: TextStyle(
        color: widget.chartXAxisTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
