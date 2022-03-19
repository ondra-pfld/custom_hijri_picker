import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:custom_hijri_picker/custom_hijri_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
              const Locale('en', 'USA'),
          // const Locale('ar', 'SA'),
        ],
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: Colors.brown,
          accentColor: Colors.green,
          // brightness: Brightness.dark,
        ),
        home: MyHomePage(title: "Umm Alqura Calendar"));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedDate = new HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: HijriMonthPicker(
        lastDate: new HijriCalendar()
          ..hYear = 1445
          ..hMonth = 9
          ..hDay = 25,
        firstDate: new HijriCalendar()
          ..hYear = 1438
          ..hMonth = 12
          ..hDay = 25,
        onChanged: (HijriCalendar value) {
          setState(() {
            selectedDate = value;
          });
        },
        cellMargin: 10, 
        dayFontSize: 14, 
        daysOfWeekHeight: 32, 
        chevronSize: 26, 
        rowHeight: 64, 
        selectedColor: Colors.red, 
        weekColor: Colors.grey,
        weekColorBg: Colors.yellow,
        headerBg: Colors.purple,
        titleFontSize: 16,
        selectedDate: selectedDate,
      )
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendar? picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,
      lastDate: new HijriCalendar()
        ..hYear = 1445
        ..hMonth = 9
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }
}
