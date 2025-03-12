import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/appbarWidget.dart';
import '../widgets/sensoConfigurationScreenWidgets/footerTitleLink.dart';
import '../widgets/sensoConfigurationScreenWidgets/headerTitle.dart';
import '../widgets/sensoConfigurationScreenWidgets/sensorDisplayWidget.dart';
import '../widgets/sensoConfigurationScreenWidgets/sensorReport.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  // Use the full Firebase Realtime Database URL
  final DatabaseReference _database = FirebaseDatabase.instance.refFromURL("https://apms-6f88c-default-rtdb.firebaseio.com/sensors");

  late Stream<DatabaseEvent> _sensorStream;

  @override
  void initState() {
    super.initState();
    // Listen to the sensor data changes in real-time
    _sensorStream = _database.onValue;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.018),
            const HeaderTitle(),
            SizedBox(height: size.height * 0.014),
            Text(
              "Click to activate or deactivate sensor",
              style: TextStyle(color: Colors.red.withOpacity(0.4)),
            ),
            SizedBox(height: size.height * 0.014),
            // StreamBuilder to listen to the Firebase Realtime Database changes
            StreamBuilder<DatabaseEvent>(
              stream: _sensorStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                  double temperature = (data['temperature'] ?? 0).toDouble();
                  double humidity = (data['humidity'] ?? 0).toDouble();
                  double waterLevel = (data['waterLevel'] ?? 0).toDouble();
                  double feedLevel = (data['feedLevel'] ?? 0).toDouble();
                  String securityStatus = data['security'] ?? "Unknown";

                  return SensorDisplayWidget(
                    temperature: temperature,
                    humidity: humidity,
                    waterLevel: waterLevel,
                    feedLevel: feedLevel,
                    securityStatus: securityStatus,
                  );
                } else {
                  return Text("No data available.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
