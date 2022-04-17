import 'package:flutter/material.dart';
import 'package:machine_test/src/viewModel/home_provider.dart';
import 'package:provider/provider.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(

        builder: (context,provider,child){
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.red,
                currentIndex: provider.index,
                onTap: (newValue){
                  print('presed...');
                  provider.changeIndex(newValue);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_outlined),
                      label: 'Calendar'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      label: 'Products'
                  ),
                ],
              ),
              body:provider.pageList[provider.index]
          );
        });
  }
}