import 'package:flutter/material.dart';
import 'package:impiger_flutter_chart/gmbarchart.dart';
import 'package:impiger_flutter_chart/gmpiechart.dart';

import 'gmlinechart.dart';
import 'gmtwobarchart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GM Charts',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter GM Charts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> chartColorList = [
    Colors.greenAccent,
    Colors.amber,
    Colors.blueGrey,
    Colors.lightBlueAccent,
    Colors.pink
  ];
  List<String> chartNameList = ["Green", "Purple", "Grey", "Blue", "Pink"];
  List<String> chartImageList = [
    "https://www.gstatic.com/webp/gallery/1.jpg",
    "https://www.gstatic.com/webp/gallery/2.webp",
    "https://www.gstatic.com/webp/gallery/1.jpg",
    "https://www.gstatic.com/webp/gallery/4.jpg",
    "https://www.gstatic.com/webp/gallery/5.jpg"
  ];
  List<dynamic> chartValuesList = [5, 1.5, 2, 1, 1.5];
  List<dynamic> chartBarValuesList = [2, 3, 6, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const Text("PieChart Examples",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 40,
              ),
              GMPieChart(chartColorList, chartValuesList, chartNameList,
                  Colors.black, Colors.black, 30.0, const [], true),
              const SizedBox(
                height: 40,
              ),
              GMPieChart(chartColorList, chartValuesList, chartNameList,
                  Colors.black, Colors.black, 30.0, chartImageList, false),
              const SizedBox(
                height: 40,
              ),
              const Text("BarChart Examples",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(
                height: 40,
              ),
              GMBarChart(
                  chartValuesList,
                  chartNameList,
                  Colors.orangeAccent,
                  10,
                  const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                  false),
              const SizedBox(
                height: 40,
              ),
              GMBarChart(
                chartValuesList,
                chartNameList,
                Colors.blueGrey,
                10,
                const TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                true,
              ),
              const SizedBox(
                height: 40,
              ),
              GMTwoBarChart(chartNameList, Colors.black, Colors.amberAccent, Colors.redAccent,chartValuesList,chartBarValuesList,20),
              const SizedBox(
                height: 40,
              ),
              GMLineChart(chartValuesList, chartNameList, Colors.blueGrey),
            ],
          ),
        ),
      ),
    );
  }
}
