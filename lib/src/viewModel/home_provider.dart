import 'package:flutter/material.dart';
import 'package:machine_test/src/view/page_calendar.dart';
import 'package:machine_test/src/view/page_product_list.dart';

class HomeProvider extends ChangeNotifier{
  List pageList=[
    PageCalendar(),
    PageProductList()
  ];
  int index=0;

  changeIndex(int currentIndex){
    index=currentIndex;
    notifyListeners();
  }
}