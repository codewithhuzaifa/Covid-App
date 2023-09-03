import 'package:covidapp/Models/worldstatmodels.dart';
import 'package:covidapp/Services/stats_services.dart';
import 'package:covidapp/views/apiLoadingscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  List<Color> colorlist = const [
    Color(0xFF74b9ff),
    Color(0xFF55efc4),
    Color(0xFFff7675),
  ];
  @override
  Widget build(BuildContext context) {
    StatServices statServices = StatServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                future: statServices.getworldstats(),
                builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitFadingCircle(
                          size: 50,
                          color: Colors.black,
                          controller: _controller,
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          PieChart(
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            colorList: colorlist,
                            chartType: ChartType.disc,
                            animationDuration: const Duration(seconds: 4),
                            dataMap: {
                              'Effected': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Death': double.parse(
                                  snapshot.data!.deaths.toString()),
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            flex: 5,
                            child: Card(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ReusableCard(
                                        title: 'Total Test Conducted',
                                        value: snapshot.data!.tests.toString()),
                                    ReusableCard(
                                        title: 'Total Positive',
                                        value: snapshot.data!.cases.toString()),
                                    ReusableCard(
                                        title: 'Total Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ReusableCard(
                                        title: 'Total Death',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ReusableCard(
                                        title: 'Active Cases',
                                        value:
                                            snapshot.data!.active.toString()),
                                    ReusableCard(
                                        title: 'Critical Cases',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReusableCard(
                                        title: 'Today Positive',
                                        value: snapshot.data!.todayCases
                                            .toString()),
                                    ReusableCard(
                                        title: 'Today Recovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                    ReusableCard(
                                        title: 'Today Death',
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                  child: Text(
                                'Track Countries',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  String title, value;
  ReusableCard({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
