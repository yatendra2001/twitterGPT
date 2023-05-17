import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../utils/theme_constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homepage';

  const HomePage({Key? key}) : super(key: key);
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TwitterGPT',
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: _currentIndex == 0 ? const TweetsPage() : const PerformancePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tweets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Performance',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class TweetsPage extends StatelessWidget {
  const TweetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Generated Tweet #${index + 1}'),
            subtitle: const Text('This is a dummy generated tweet.'),
          ),
        );
      },
    );
  }
}

class PerformancePage extends StatelessWidget {
  const PerformancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          maxY: 20,
          barGroups: List.generate(
            7,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                    toY: (index + 1) * 2.0, color: AppColor.kMediumBlueColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
