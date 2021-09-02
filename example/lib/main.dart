import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housecode/housecode.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      title: 'Housecode Demo',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: CupertinoColors.white,
        primaryColor: CupertinoColors.systemBlue,
        primaryContrastingColor: CupertinoColors.systemBlue,
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
  List<String?> _items = [];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoadingDialog(
        isAsync: _isASync,
        loadingMessage: "Load Data...",
        child: WillPopScope(
          onWillPop: () => Future(() => true),
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: () {
                    _showPicker();
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
                        return TextCell(
                            title: _items[i].coalesce("-").capitalize());
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
        _items = List.generate(
            50, (index) => index == 15 ? null : "item number ${index + 1}");
        _isASync = false;
      });
    });
  }

  void _showPicker() {
    showPicker(
      context,
      List.generate(5, (index) => "Item number ${index + 1}"),
      title: "Picker",
      onDone: (index) {
        showMessage(context, "Item number ${index + 1}");
      },
    );
  }
}
