import 'package:flutter/material.dart';

class TestOne extends StatefulWidget {
  TestOne({Key key}) : super(key: key);

  @override
  TestOneState createState() {
    return TestOneState();
  }
}

class TestOneState extends State<TestOne> {
  final items = List<String>.generate(3, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return Scaffold(
      appBar: AppBar(
        title: Text('666'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('1')
          ],
        ),
      ),
    );
  }
}
