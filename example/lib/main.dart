import 'package:flutter/material.dart';
import 'package:housecode/housecode.dart';
import 'package:housecode/widgets/loading_dialog.dart';
import 'package:housecode/widgets/separator.dart';
import 'package:housecode/widgets/text_cell.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Housecode Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Housecode Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isASync = false;
  List<String> _items = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoadingDialog(
        isAsync: _isASync,
        loadingMessage: "Load Data...",
        opacity: 0.8,
        child: WillPopScope(
          onWillPop: () => Future(() => true),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: () {
                    print("debug");
                  },
                  icon: Icon(Icons.access_alarms),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: _load,
                      child: Text("LOAD"),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _items.length,
                      separatorBuilder: (c, i) =>
                          Separator(margin: EdgeInsets.only(left: 12)),
                      itemBuilder: (c, i) {
                        return TextCell(title: _items[i].capitalize());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _load() {
    setState(() {
      _isASync = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _items = List.generate(50, (index) => "item number ${index + 1}");
        _isASync = false;
      });
    });
  }
}
