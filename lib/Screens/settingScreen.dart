import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Profile Settings",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Profile"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Profile Edit Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Change Password Screen
            },
          ),
          const Divider(),

          const Text(
            "System Configurations",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: true, // Fetch actual value from user preferences
            onChanged: (bool value) {
              // Handle notification toggle
            },
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text("Temperature Threshold"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Threshold Settings
            },
          ),
          const Divider(),

          const Text(
            "Data & API Management",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text("Refresh Data Interval"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Data Refresh Settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text("Clear Data Cache"),
            onTap: () {
              // Implement cache clearing
            },
          ),
          const Divider(),

          const Text(
            "Security & Authentication",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              // Implement logout function
            },
          ),
        ],
      ),
    );
  }
}
