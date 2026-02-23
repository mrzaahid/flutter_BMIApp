import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BMIPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BMIPageState();
  }
}

class _BMIPageState extends State<BMIPage>{
  double? _deviceHeight,_deviceWidth;

  int _age = 26,_weight = 70,_height = 175,_gender = 0;
  
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          height: _deviceHeight! * 0.85,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ageSelectContiner(),
                    _weightSelectContiner(),
                    
                  ],
                ),
                _heightSelectContainer(),
                _genderSelectContainer(),
                _calculateBMIButton()
              ],
            )
          ),
        ),
      ),
    );
  }
 
  Widget _ageSelectContiner(){
      return InfoCard( 
            height: _deviceHeight!*0.20, 
            width: _deviceWidth!*0.45,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Age yr",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  _age.toString(),
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: CupertinoButton(
                        onPressed: (){
                          setState(() {
                            _age--;
                            
                          });
                        },
                        child: const Text(
                          "-",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: CupertinoButton(
                        onPressed: (){
                          setState(() {
                            _age++;
                          });
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          );
    }
  Widget _weightSelectContiner(){
      return InfoCard( 
            height: _deviceHeight!*0.20, 
            width: _deviceWidth!*0.45,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Weight kg",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  _weight.toString(),
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: CupertinoButton(
                        onPressed: (){
                          setState(() {
                            _weight--;
                            
                          });
                        },
                        child: const Text(
                          "-",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: CupertinoButton(
                        onPressed: (){
                          setState(() {
                            _weight++;
                          });
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          );
    }

  Widget _heightSelectContainer(){
      return InfoCard( 
        height: _deviceHeight!*0.15, 
        width: _deviceWidth! *0.90,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "height cm",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400
              ),
            ),
            Text(
              _height.toString(),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              width: _deviceWidth! * 0.80,
              child: CupertinoSlider(
                min: 0,
                max: 250,
                divisions: 250,
                value: _height.toDouble(), 
                onChanged: (value){
                  setState(() {
                    _height = value.toInt();
                  });
                }
              ),
            )
          ],
        ),
      );
    }
  Widget _genderSelectContainer(){
    return InfoCard(
      height: _deviceHeight!*0.11, 
      width: _deviceWidth!*0.90, 
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Gender",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children: const{
              0: Text("Male"),
              1: Text("Female"),
            }, 
            onValueChanged: (_value){
              setState(() {
                _gender = _value!.toInt();
              });
            }
          )
        ]
      )
    );
  }
  Widget _calculateBMIButton(){
    return Container(
      height: _deviceHeight! *0.07,
      child: CupertinoButton.filled(
        child: const Text(
          "Calculate BMI",
        ),
        onPressed: (){
          if(_height>0 && _weight>0 && _age>0){
            double bmi = _weight / (_height/100 * _height/100);
            print(bmi);
            _showResult(bmi);
          }
        }
      ),
    );
  }
  void _showResult(double _bmi){
    String? _status;
    if(_bmi<18.5){
      _status = "Underweight";
    } else if(_bmi<25&&_bmi>=18.5){
      _status = "Normal";
    } else if(_bmi<30&&_bmi>=25){
      _status = "Overweight";
    } else if(_bmi>=30){
      _status = "Obese";
    }
    showCupertinoDialog(
      context: context, 
      builder: (BuildContext _context){
        return CupertinoAlertDialog(
          title: Text("Your BMI is ${_bmi.toStringAsFixed(2)}"),
          content: Text("You are $_status"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: (){
                _saveResult(_bmi.toString(), _status!);
                Navigator.of(_context).pop();
              },
            )
          ],
        );
       }
    );
  }
  void _saveResult(String _bmi,String _status) async{
    final prefs =await SharedPreferences.getInstance();
    await prefs.setString('bmi_date', DateTime.now().toString());
    prefs.setStringList('bmi', <String>[
      _bmi,
      _status
    ]);
  }

}