import 'dart:async';
import 'dart:convert';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:onlinevoting/Globalvariable.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uhc_geoteagging/view/patientlist_page.dart';

// import 'Model/GlobalVariable.dart';
// import 'Model/VotePage.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var _passwordVisilble = true;

  void _btnLogin(String username, String Password) async {
    debugPrint(username);
    debugPrint('password is $Password');
    Timer(const Duration(seconds: 3), () async {
      // var uri = 'http://10.222.81.108:45455/api/geoTagLogin';
      var uri = 'http://uhcsocot20222-001-site1.dtempurl.com/api/geoTagLogin';

      try {
        Response response = await post(Uri.parse(uri), body: {
          'Username': username,
          'Password': Password,
        });
        print('status is ' + response.statusCode.toString());
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);

          // userID = json["StudentID"];
          _btnController.success();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PatientList()),
            (Route<dynamic> route) => false,
          );
        } else {
          _btnController.error();
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 75,
            ),
            const Image(
              image: AssetImage(
                'Assets/socotlogo.png',
              ),
              height: 200,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Username",
                  fillColor: Colors.white70),
              controller: usernameController,
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              obscureText: _passwordVisilble,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_passwordVisilble == true
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          _passwordVisilble = !_passwordVisilble;
                        },
                      );
                    },
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Password",
                  fillColor: Colors.white70),
              controller: passwordController,
            ),
            const SizedBox(
              height: 25,
            ),
            RoundedLoadingButton(
              child:
                  const Text('LOGIN!', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: () {
                _btnLogin(usernameController.text.toString(),
                    passwordController.text.toString());
              },
              resetAfterDuration: true,
              resetDuration: const Duration(seconds: 6),
            )
          ],
        ),
      ),
    );
  }
}
