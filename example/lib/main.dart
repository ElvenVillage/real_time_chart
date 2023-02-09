import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: RealTimeGraph(
            key: const Key('LiveGraph'),
            stream: getDataStream(),
          ),
        ),
      ),
    );
  }

  int count = 0;
  bool up = true;

  Stream<double> getDataStream() {
    return Stream.periodic(const Duration(milliseconds: 10), (_) {
      if (count >= 100) {
        up = false;
      } else if (count <= 0) {
        up = true;
      }
      if (up) {
        count++;
      } else {
        count--;
      }

      return count * 1.0;
    });
  }
}
