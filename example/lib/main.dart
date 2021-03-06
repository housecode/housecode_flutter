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
  List<String?> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Separator(),
            StackViewCell(
              children: [
                Text("LOAD One"),
                Text("LOAD Two"),
                Text("LOAD Three")
              ],
            ),
            Separator(),
            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (c, i) =>
                    Separator(margin: EdgeInsets.only(left: 12)),
                itemBuilder: (c, i) {
                  switch (i) {
                    case 0:
                      return CheckboxCell(
                          title: _items[i].coalesce("-").capitalize(),
                          onChecked: (checked) {});
                    case 1:
                      return DateTimePickerCell(
                          _items[i].coalesce("-").capitalize(), (dateTime) {});
                    case 2:
                      return PickerViewCell(
                          title: _items[i].coalesce("-").capitalize(),
                          items: "A B C D E F".split(' '));
                    case 3:
                      return SelectableViewCell(
                          child: Text(_items[i].coalesce("-").capitalize()),
                          selected: false);
                    default:
                      return TextCell(
                        title: _items[i].coalesce("-").capitalize(),
                        onTap: i == 4 || i == 5 || i == 6
                            ? (callback) {
                                if (i == 4) {
                                  showMessage(context, "Hello World!");
                                } else if (i == 5) {
                                  showConfirm(context, "Are you sure?", () {});
                                } else if (i == 6) {
                                  showActionSheet(
                                    context,
                                    ["Option 1", "Option 1"],
                                    title: "Choose",
                                    message: "One of",
                                    textColor: CupertinoColors.systemBlue,
                                  );
                                }
                              }
                            : null,
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Loading _loading = Loading();

  void _load() {
    _loading.show(context, message: "Load data...");

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _items = List.generate(
            50, (index) => index == 15 ? null : "item number ${index + 1}");
      });
      _loading.hide();
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
