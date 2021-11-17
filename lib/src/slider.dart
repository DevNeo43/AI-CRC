import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

const ballSize = 20.0;
const step = 10.0;


class JoystickControl extends StatefulWidget {

  const JoystickControl({Key? key}) : super(key: key);

  @override
  _JoystickExampleState createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickControl> {
  double _x = 100;
  double _y = 100;
  JoystickMode _joystickMode = JoystickMode.vertical;

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white
                  ),
                  child: Text("Off"),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white
                  ),
                  child: Text("강함"),
                  onPressed: () => {},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreenAccent,
                      onPrimary: Colors.white
                  ),
                  child: Text("AUTO"),
                  onPressed: () => {},
                ),
              ],
            ),
            Container(
              color: Colors.green,
            ),
            Ball(_x, _y),
            Align(
              alignment: const Alignment(-0.9, 0.8),
              child: Row(
                children: [
              Joystick(
                mode: _joystickMode,
                listener: (details) {
                setState(() {
                _x = _x + step * details.x;
                _y = _y + step * details.y;
                });
                },
                ),
              ],
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