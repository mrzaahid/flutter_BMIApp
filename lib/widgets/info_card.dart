import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget{
  final Widget child;
  final double height,width;

  const InfoCard({
    super.key,
    required this.height,
    required this.width,
    required this.child,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                )
              ]
            ),
            
            height: height,
            width: width,
            child: child,
          );
  }

}