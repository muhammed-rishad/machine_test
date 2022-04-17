import 'dart:collection';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/src/model/meeting.dart';
import 'package:machine_test/src/view/page_calendar.dart';
import 'package:machine_test/src/view/page_home.dart';
import 'package:machine_test/src/viewModel/home_provider.dart';
import 'src/viewModel/meetingDataSource.dart';
import 'package:machine_test/src/view/page_product_list.dart';
import 'package:machine_test/src/viewModel/calendar_provider.dart';
import 'package:machine_test/src/viewModel/product_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(MyApp());
}

/// The app which hosts the home page which contains the calendar on it.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CalendarProvider>(create: (context) => CalendarProvider()),
          ChangeNotifierProvider<ProductProvider>(create: (context) => ProductProvider()),
          ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider()),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
           home: PageHome()));
  }
}






