import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:impiger_flutter_chart/widgets/indicator.dart';

class GMPieChart extends StatefulWidget {
  List<Color> chartColorList;
  List<dynamic> chartValuesList;
  List<String> chartNameList;
  List<String>? chartImageList;
  Color? chartTextColor = Colors.black;
  Color? indicatorTextColor = Colors.black;
  double? widgetSize = 30.0;
  bool? isHorizontalIndicatorView = false;

  GMPieChart(this.chartColorList, this.chartValuesList, this.chartNameList,
      {this.chartTextColor,
      this.indicatorTextColor,
      this.widgetSize,
      this.chartImageList,
      this.isHorizontalIndicatorView,
      super.key});

  @override
  State<StatefulWidget> createState() => GMPieChartState(
      chartColorList,
      chartValuesList,
      chartNameList,
      chartTextColor,
      indicatorTextColor,
      widgetSize,
      chartImageList,
      this.isHorizontalIndicatorView);
}

class GMPieChartState extends State {
  int touchedIndex = -1;
  List<String>? chartImageList;
  List<Color> chartColorList;
  List<dynamic> chartValuesList;
  List<String> chartNameList;
  Color? chartTextColor;
  Color? indicatorTextColor;
  double? widgetSize;
  bool? isHorizontalIndicatorView;

  GMPieChartState(
      this.chartColorList,
      this.chartValuesList,
      this.chartNameList,
      this.chartTextColor,
      this.indicatorTextColor,
      this.widgetSize,
      this.chartImageList,
      this.isHorizontalIndicatorView);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isHorizontalIndicatorView != null && !isHorizontalIndicatorView!
          ? 260
          : 200,
      width: MediaQuery.of(context).size.width,
      child: chartValuesList.length == chartNameList.length &&
              chartValuesList.length == chartColorList.length
          ? isHorizontalIndicatorView != null && !isHorizontalIndicatorView!
              ? Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int item = 0;
                              item < chartColorList.length;
                              item++)
                            Row(
                              children: [
                                Indicator(
                                  color: chartColorList[item],
                                  text: chartNameList[item],
                                  isSquare: true,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int item = 0;
                              item < chartColorList.length;
                              item++)
                            Column(
                              children: [
                                Indicator(
                                  color: chartColorList[item],
                                  text: chartNameList[item],
                                  isSquare: true,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                )
          : const Center(
              child: Text(
                "Chart not rendering, please provide valid values",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(chartValuesList.length, (item) {
      final isTouched = item == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      widgetSize = isTouched ? 35.0 : 30.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: chartColorList[item],
        value: chartValuesList[item].toDouble(),
        title: chartValuesList[item].toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: chartTextColor ?? Colors.black,
          shadows: shadows,
        ),
        badgeWidget: chartImageList != null && chartImageList!.length == chartNameList.length
            ? _Badge(
                chartImageList != null ? chartImageList![item] : "",
                size: 25.0,
                borderColor: Colors.white,
              )
            : Container(),
        badgePositionPercentageOffset: .99,
      );
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.imageUrl, {
    required this.size,
    required this.borderColor,
  });

  final String imageUrl;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.network(
          imageUrl,
        ),
      ),
    );
  }
}
