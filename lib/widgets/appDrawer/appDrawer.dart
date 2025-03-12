import 'package:apms/Screens/collectionScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apms/Screens/Authe/signin_screen.dart';
import 'package:apms/Screens/Authe/loginLogic.dart';
import 'package:apms/Screens/defaultPageScreen.dart';
import 'package:apms/Screens/sensorsScreen.dart';
import 'package:apms/widgets/sensoConfigurationScreenWidgets/sensorReport.dart';
import 'package:apms/Screens/settingScreen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _signOut() async {
    _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninScreen()),
    );
  }

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user == null)
      return {"username": "Unknown User", "email": "No email provided"};

    try {
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(user.uid).get();

      if (userDoc.exists) {
        print("Firestore Data: ${userDoc.data()}"); // Debug output
        return userDoc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    print(
      "Auth Data: Name - ${user.displayName}, Email - ${user.email}",
    ); // Debug output
    return {
      "username": "Unknown User", // Default if username is not in Firestore
      "email": user.email ?? "No email provided",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                image: AssetImage("assets/image1.png"),
              ),
              color: Color.fromARGB(255, 187, 196, 204),
            ),
            child: FutureBuilder<Map<String, dynamic>>(
              future: _getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text(
                      "No user data found",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }

                String username = snapshot.data?["username"] ?? "Unknown User";
                String email = snapshot.data?["email"] ?? "No email provided";

                return UserAccountsDrawerHeader(
                  currentAccountPictureSize: const Size.square(56),
                  decoration: const BoxDecoration(color: Colors.transparent),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/image1.png"),
                  ),
                  accountName: Text(
                    username,
                    style: const TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(
                    email,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          _buildDrawerItem(Icons.home, "Home", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DefaultPageScreen(),
              ),
            );
          }),
          _buildDrawerItem(Icons.sensors, "Sensors", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SensorScreen()),
            );
          }),
          _buildDrawerItem(
            Icons.notification_add_sharp,
            "Notifications",
            () {},
          ),
          _buildDrawerItem(Icons.storage_rounded, "Collection Data", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DataCollectionScreen()),
            );
          }),
          _buildDrawerItem(Icons.bar_chart, "Sensor report", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SensorReport()),
            );
          }),
          _buildDrawerItem(Icons.settings, "Settings", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingScreen()),
            );
          }),
          _buildDrawerItem(Icons.logout, "Logout", _signOut),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(title), onTap: onTap),
    );
  }
}
