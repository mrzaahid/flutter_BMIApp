import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/pages/bmi_page.dart';
import 'package:ibmi/pages/history_page.dart';

class MainPage extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage>{
  Key _historyKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("IBMI"),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        automaticBackgroundVisibility: false,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          onTap: (index) {
            if (index == 1) {
              setState(() {
                _historyKey = UniqueKey();
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "BMI"
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: "History"
            )
          ]
        ), 
        tabBuilder: (context,index){
          return CupertinoTabView(
            builder: (context){
              if (index == 0) return BMIPage();
              return HistoryPage(key: _historyKey);
            },
          );
        }
      ),
    );
  }
}