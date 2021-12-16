// playground dart file
// this file is not used in program

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

const ballSize = 20.0;
const step = 20.0;

String ipaddress = '172.20.10.12';
int port = 9999;

class JoystickExample extends StatefulWidget {
  const JoystickExample({Key? key}) : super(key: key);

  @override
  _JoystickExampleState createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.horizontalAndVertical;

  bool pressPower = false;
  bool pressCleanPower = false;
  bool pressAutoMode = false;

  bool pressPowerText = false;
  bool pressCleanPowerText = false;
  bool pressAutoModeText = false;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              // color: Colors.black12,
            ),
            Ball(_x, _y),
            Align(
              alignment: const Alignment(2.0, 1.3),
              child: Column(
                children: [
                  Row(
                    children: [
                      RaisedButton( // On/Off button
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white60)
                          ),
                          color: pressPower ? Colors.red : Colors.black,
                          textColor: Colors.white,
                          child: pressPowerText ? Text("On") : Text("Off"),
                          onPressed: () {
                            setState(() {
                              if(pressPower == true){
                                OnPush();
                              }
                              else if(pressPower == false){
                                OffPush();
                              }
                              pressPower = !pressPower;
                              pressPowerText = !pressPowerText;
                            });
                          }
                      ),
                      RaisedButton( // Motor Power button
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white60)
                          ),
                          color: pressCleanPower ? Colors.blue : Colors.purpleAccent,
                          textColor: Colors.white,
                          child: pressCleanPowerText ? Text("Low") : Text("High"),
                          //    style: TextStyle(fontSize: 14)
                          onPressed: () {
                            setState(() {
                              pressCleanPower = !pressCleanPower;
                              pressCleanPowerText = !pressCleanPowerText;
                            });
                          }
                      ),
                      RaisedButton( //Mode button
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white60)
                          ),
                          color: pressAutoMode ? Colors.brown : Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          child: pressAutoModeText ? Text("Manual") : Text("Auto"),
                          //    style: TextStyle(fontSize: 14)
                          onPressed: () {
                            setState(() {
                              if(pressAutoMode == true){
                                AutoPush();
                              }
                              else if(pressAutoMode == false){
                                ManualPush();
                              }
                              pressAutoMode = !pressAutoMode;
                              pressAutoModeText = !pressAutoModeText;
                            });
                          }
                      )
                    ],
                  )
                ],
              ),
            ),
            Align( //joystick1
              alignment: const Alignment(-0.9, 0.8),
              child: Joystick(
                mode: _joystickMode,
                listener: (details) {
                  setState(() {
                    _x = _x + step * details.x;
                    _y = _y + step * details.y;
                    print('================');
                    print('x : ${details.x}');
                    print('y : ${details.y}');
                    if(details.x<0){
                      LeftTurn();
                    }
                    else if(details.x==0){
                      if(details.y>=0){
                        Back();
                      }
                      else{
                        Go();
                      }
                    }
                    else if(details.x>0){
                      RightTurn();
                    }
                  });
                },
              ),
            ),
            Align( //joystick2
              alignment: const Alignment(0.9, 0.8),
              child: Joystick(
                mode: _joystickMode,
                listener: (details) {
                  setState(() {
                    _y = _y + step * details.y;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;

  const Ball(this.x, this.y, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}

void OnPush() async{
  Socket socket = await Socket.connect(ipaddress, port);
  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('P0'));
  print('Send Data : P0');
  await Future.delayed(Duration(seconds: 1));

}
void OffPush() async{
  Socket socket = await Socket.connect(ipaddress, port);
  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('P1'));
  print('Send Data : P1');
  await Future.delayed(Duration(seconds: 1));

}
void LowPush() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
    socket.add(utf8.encode('SL'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void ManualPush() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('CM'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void AutoPush() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('CA'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void Go() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('GO'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void Back() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('BACK'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void LeftTurn() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('L'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}
void RightTurn() async{
  Socket socket = await Socket.connect(ipaddress, port);

  socket.listen((List<int> event){
    print(utf8.decode(event));
  });
  socket.add(utf8.encode('R'));
  await Future.delayed(Duration(seconds: 5));

  socket.close();
}