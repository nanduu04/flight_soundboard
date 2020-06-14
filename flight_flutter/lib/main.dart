import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flights Soundboard',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Flight Soundboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: 15,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              borderRadius: new BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Text('${index + 1}'),
            ),
          ),
          onTap: () {
            if (mounted) {
              setState(() {
                print(index);
              });
            }
          },
        ),
        primary: false,
        padding: const EdgeInsets.all(30),
      ),
    );
  }
}
