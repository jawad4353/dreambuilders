import 'dart:math';
import 'package:flutter/material.dart';

class MyRoute extends PageRouteBuilder{
  final Widget child;
  Random ob=Random();
  var o,randomElement , Directions=[AxisDirection.up,AxisDirection.down,AxisDirection.left,AxisDirection.right];

  MyRoute(this.child):super(pageBuilder:(BuildContext, Animation , Animatio )=>child ){
    randomElement=ob.nextInt(4);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var T=Tween<Offset>(begin: getOffSet(randomElement),end: Offset.zero);
    var T1=Tween<double>(begin: 3.0,end: 1.0);
    return SlideTransition(
        position: animation.drive(T.chain(CurveTween(curve: Curves.bounceInOut))),
        child: child);
  }

  Offset getOffSet(randomElement){
    switch(randomElement) {
      case 0:
        o = const Offset(0, -1);
        break;
      case 1:
        o = const Offset(0, 1);
        break;
      case 2 :
        o = const Offset(1, 0);
        break;
      case 3:
        o = const Offset(-1, 0);
        break;
    }
    return o;
  }
}



