import 'package:apms/Screens/collectionScreen.dart';
import 'package:apms/Screens/notificationScreen.dart';
import 'package:apms/Screens/sensorsScreen.dart';
import 'package:apms/Screens/home_screen.dart';
import 'package:apms/Screens/settingScreen.dart';

import 'package:flutter/material.dart';

import '../widgets/appDrawer/appDrawer.dart';
import '../widgets/userAccountWidgets/userConfigurationPage.dart';

class DefaultPageScreen extends StatefulWidget {
  const DefaultPageScreen({super.key});

  @override
  State<DefaultPageScreen> createState() => _DefaultPageScreenState();
}

class _DefaultPageScreenState extends State<DefaultPageScreen> {
  @override
  int _selectedIndex = 0;
  List Page = [
    HomeScreen(),
    const SensorScreen(),
     DataCollectionScreen(),
    const SettingScreen(),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Column(
            children: [
              Text(
                "APMS",
                style: TextStyle(
                  fontSize: size.height * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const UserConfigurationPage();
                  },
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: size.width * 0.03),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/image1.png"),
              ),
            ),
          ),
        ],
      ),
      body: Page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[200],
        currentIndex: _selectedIndex,
        onTap: ((value) => onItemTapped(value)),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 39, 37, 37),
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.network_wifi),
            label: 'Sensors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
