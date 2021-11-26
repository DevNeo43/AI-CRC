import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'control.dart';
import 'signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController Controller = TextEditingController();
  TextEditingController Controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 가로모드
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: Icon(Icons.badge),
          onPressed: () {
            //signup page 구현 필요
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
          },
        ),
      ),
      body: Builder(
        builder: (context){
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                const Center(
                  child: Image(
                    image: AssetImage('images/logo.png'), //need to exchange images
                    width: 80.0,
                    height: 100.0,
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                const Text(
                  'Clean your Room!',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Form(
                    child: Theme(
                        data: ThemeData(
                            primaryColor: Colors.teal,
                            inputDecorationTheme: const InputDecorationTheme(
                                labelStyle: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 15.0
                                )
                            )
                        ),
                        child: Container(
                            width: 400.0,
                            padding: EdgeInsets.all(40.0),
                            child : Column(
                              children: <Widget>[
                                TextField(
                                  controller: Controller,
                                  decoration: const InputDecoration(
                                      labelText: "Input ID"
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextField(
                                  controller: Controller2,
                                  decoration: const InputDecoration(
                                      labelText: "Input Password"
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                SizedBox(height: 30.0),
                                ButtonTheme(
                                    minWidth: 100.0,
                                    height : 50.0,
                                    child: RaisedButton(
                                      color: Colors.greenAccent,
                                      child:  const Text(
                                        'Go',
                                        style: TextStyle(
                                            color : Colors.white
                                        ),
                                      ),
                                      onPressed:  (){
                                        if(Controller.text == "park" && Controller2.text == "1234"){
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>JoystickExample()));
                                          }else if(Controller.text !="park" && Controller2.text =="1234"){
                                            showSnackBarID(context);
                                          }else if(Controller.text =="park" && Controller2.text !="1234"){
                                            showSnackBarPWD(context);
                                        }else{
                                            showSnackBar(context);
                                        }
                                      },
                                    )
                                )
                              ],
                            )
                        ))
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


void showSnackBar(BuildContext context){
  Scaffold.of(context).showSnackBar(
    SnackBar(content: Text('로그인 정보를 다시 확인해주세요',
        textAlign: TextAlign.center
    ),
        duration : Duration(seconds: 2),
        backgroundColor: Colors.greenAccent,
      )
    );
}
void showSnackBarID(BuildContext context){
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('아이디를 다시 확인해주세요',
          textAlign: TextAlign.center
      ),
        duration : Duration(seconds: 2),
        backgroundColor: Colors.greenAccent,
      )
  );
}
void showSnackBarPWD(BuildContext context){
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('비밀번호를 다시 확인해주세요',
          textAlign: TextAlign.center
      ),
        duration : Duration(seconds: 2),
        backgroundColor: Colors.greenAccent,
      )
  );
}
