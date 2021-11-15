// class Signup extends StatefulWidget {
//   const Signup({Key? key}) : super(key: key);
//
//   @override
//   _AuthAppState createState() => _AuthAppState();
// }
//
// class _AuthAppState extends State<Signup> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//             title: Text("firebase Auth")
//         ),
//         body: Center(
//             child: Column(
//               children: [
//                 TextField(controller: emailController),
//                 TextField(controller: passwordController, obscureText: true),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(onPressed: () async {
//                       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//                           email: emailController.text,
//                           password: passwordController.text
//                       );
//                       setState(() {});
//                     }, child: Text("sign up")),
//                     ElevatedButton(onPressed: (){}, child: Text("sign up2")),
//                     ElevatedButton(onPressed: (){}, child: Text("sign up3")),
//                   ],
//                 )
//               ],
//             )
//         ),
//       ),
//     );
//   }
// }
