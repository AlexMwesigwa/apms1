import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserConfigurationPage extends StatefulWidget {
  const UserConfigurationPage({super.key});

  @override
  State<UserConfigurationPage> createState() => _UserConfigurationPageState();
}

class _UserConfigurationPageState extends State<UserConfigurationPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to update username in Firestore
  Future<void> _updateUsername(String newUsername) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).update({
          'username': newUsername,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username updated successfully")),
        );
      } catch (e) {
        print("Error updating username: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update username")),
        );
      }
    }
  }

  // Function to update password in Firebase Authentication
  Future<void> _updatePassword(String newPassword) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );
      } catch (e) {
        print("Error updating password: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text(
            "User Detail Edit Page",
            style: TextStyle(fontSize: size.height * 0.019),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.04),
            Center(
              child: CircleAvatar(
                radius: size.height * 0.06,
                backgroundImage: const AssetImage("assets/image1.png"),
              ),
            ),
            const Text("Username"),
            SizedBox(height: size.height * 0.014),
            TextFormField(
              controller: _controllerUsername,
              autocorrect: true,
              decoration: const InputDecoration(
                hintText: "Enter new username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const Text("Password"),
            SizedBox(height: size.height * 0.014),
            TextFormField(
              controller: _controllerPassword,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter new password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.047),
            Center(
              child: GestureDetector(
                onTap: () async {
                  String newUsername = _controllerUsername.text;
                  String newPassword = _controllerPassword.text;

                  // Update username and password if they are not empty
                  if (newUsername.isNotEmpty) {
                    await _updateUsername(newUsername);
                  }
                  if (newPassword.isNotEmpty) {
                    await _updatePassword(newPassword);
                  }
                },
                child: Container(
                  height: size.height * 0.09,
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Update Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.023,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
