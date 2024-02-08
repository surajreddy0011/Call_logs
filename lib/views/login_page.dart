// import 'package:flutter/foundation.dart';
import 'package:contacts_app/controllers/auth_serives.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(children: [
            SizedBox(
              height: 110,
            ),
            Text(
              'Login',
              style:
                  GoogleFonts.sora(fontSize: 40, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Email cannot be empty" : null,
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('Email')),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: TextFormField(
                  validator: (value) => value!.length < 8
                      ? "Password should have atleast 8 characters."
                      : null,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('Password')),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 65,
              width: MediaQuery.of(context).size.width * .9,
              child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    AuthService()
                        .loginWithEmail(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      if (value == "Login Successful") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login Successful")));
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ));
                      }
                    });
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 65,
              width: MediaQuery.of(context).size.width * .9,
              child: OutlinedButton(
                  onPressed: () {
                    AuthService().ContinueWithGoogle().then((value) {
                      if (value == "Google Login Successful") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Google Login Successful")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ));
                      }
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/google.png', height: 40, width: 40),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Continue With Google',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: Text("Sign Up")),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
