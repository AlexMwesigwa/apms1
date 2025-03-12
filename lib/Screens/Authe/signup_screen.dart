import 'package:apms/Screens/Authe/signin_screen.dart';
import 'package:apms/reusable_widgets/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/colors/color_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();

  // Function to store user data in Firestore
  Future<void> _storeUserData(User? user) async {
    if (user != null) {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "username": _userNameTextController.text,
        "email": _emailTextController.text,
        "createdAt": Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  hexStringToColor("9546C4"),
                  hexStringToColor("CB2B93"),
                  hexStringToColor("5E61F4")
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Automated Poultry Monitoring System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    ClipOval(
                      child: Image.asset(
                        "assets/image1.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    reusableTextField("Enter Username", Icons.person_outline, false, _userNameTextController),
                    const SizedBox(height: 20),
                    reusableTextField("Enter Email Id", Icons.email_outlined, false, _emailTextController),
                    const SizedBox(height: 20),
                    reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                    const SizedBox(height: 20),
                    signInSignUpButton(context, false, () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((userCredential) {
                        User? user = userCredential.user;
                        _storeUserData(user); // Store user data in Firestore
                        print("Created New account");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()));
                      }).catchError((error) {
                        print("Error: ${error.toString()}");
                      });
                    })
                  ],
                ),
              ),
            )));
  }
}
