import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HistoryPage extends StatelessWidget{
  const HistoryPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: _dataCard(_deviceHeight, _deviceWidth)
    );
  }

  Widget _dataCard(double _deviceHeight,double _deviceWidth){
    return FutureBuilder(
      future: SharedPreferences.getInstance(), 
      builder: (BuildContext _context,AsyncSnapshot _snapshot){
        if(_snapshot.hasData){
          final _prefs = _snapshot.data as SharedPreferences;
          final _date = _prefs.getString('bmi_date');
          final _data = _prefs.getStringList('bmi');
          return Center(
            child: InfoCard(
              height: _deviceHeight*0.25, 
              width: _deviceWidth*0.75, 
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _statusText(_data![1]),
                  _dateText(_date!),
                  _bmiText(_data[0])
                ],
              )
            ),
          );
        }else{
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        }
      }
    );
  }

  Widget _statusText(String _status){
    return Text(
      _status,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400
       ),
     );
  }

  Widget _dateText(String _date){
    DateTime _parseDate = DateTime.parse(_date);
    return Text(
      '${_parseDate.day} / ${_parseDate.month} / ${_parseDate.year}',
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300
       ),
     );
  }
  
  Widget _bmiText(String _bmi){
    return Text(
      double.parse(_bmi).toStringAsFixed(2),
      style: const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.w600
       ),
      );
  }

}