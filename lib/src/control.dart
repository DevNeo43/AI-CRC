import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white
                    ),
                    child: Text("hello"),
                    onPressed: () => OnOff(),
                ),
                ]
            )
        )
    );
  }

  void OnOff(){

  }
}


