import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:impiger_flutter_chart/widgets/indicator.dart';

class GMPieChart extends StatefulWidget {
  final List<Color> chartColorList;
  final List<dynamic> chartValuesList;
  final List<String> chartNameList;
  final List<String>? chartImageList;
  final Color chartTextColor;
  final Color indicatorTextColor;
  final double widgetSize;
  final bool isHorizontalIndicatorView;

  const GMPieChart(this.chartColorList, this.chartValuesList, this.chartNameList,
      this.chartTextColor,
      this.indicatorTextColor,
      this.widgetSize,
      this.chartImageList,
      this.isHorizontalIndicatorView,
      {super.key});

  @override
  State<StatefulWidget> createState() => GMPieChartState();
}

class GMPieChartState extends State<GMPieChart>  {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: !widget.isHorizontalIndicatorView
          ? 260
          : 200,
      width: MediaQuery.of(context).size.width,
      child: widget.chartValuesList.length == widget.chartNameList.length &&
          widget.chartValuesList.length == widget.chartColorList.length
          ? !widget.isHorizontalIndicatorView
              ? Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
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
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int item = 0;
                              item < widget.chartColorList.length;
                              item++)
                            Row(
                              children: [
                                Indicator(
                                  color: widget.chartColorList[item],
                                  text: widget.chartNameList[item],
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
                              item < widget.chartColorList.length;
                              item++)
                            Column(
                              children: [
                                Indicator(
                                  color: widget.chartColorList[item],
                                  text: widget.chartNameList[item],
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
    return List.generate(widget.chartValuesList.length, (item) {
      final isTouched = item == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: widget.chartColorList[item],
        value: widget.chartValuesList[item].toDouble(),
        title: widget.chartValuesList[item].toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: widget.chartTextColor,
          shadows: shadows,
        ),
        badgeWidget: widget.chartImageList != null && widget.chartImageList!.length == widget.chartNameList.length
            ? _Badge(
          widget.chartImageList != null ? widget.chartImageList![item] : "",
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
