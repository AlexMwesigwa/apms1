import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorReport extends StatefulWidget {
  const SensorReport({super.key});

  @override
  State<SensorReport> createState() => _SensorReportState();
}

class _SensorReportState extends State<SensorReport> {
  final String url =
      'https://apms-6f88c-default-rtdb.firebaseio.com/sensors.json'; // Firebase URL
  Map<String, dynamic> sensorData = {};
  int totalSensors = 0;
  int faultySensors = 0;
  int runningSensors = 0;

  // List of sensor categories
  List sensorName = [
    "Temperature sensors",
    "Water sensors",
    "Weight sensors",
    "Alarm sensors",
    "Sound sensors",
    "Camera",
  ];

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  // Fetch sensor data from Firebase
  void _fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(url));

      // Check if the response is successful
      if (response.statusCode == 200) {
        print(
          'Response body: ${response.body}',
        ); // Debugging: Check the response
        setState(() {
          sensorData = json.decode(response.body); // Decode JSON response
          _calculateSensorStats(); // Update sensor stats
        });
      } else {
        // Handle unsuccessful response
        throw Exception(
          'Failed to load sensor data. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Catch errors (e.g., network issues)
      print('Error fetching sensor data: $e'); // Debugging: Show the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch sensor data')),
      );
    }
  }

  // Calculate total, running, and faulty sensors
  void _calculateSensorStats() {
    totalSensors = sensorData.length;
    faultySensors = 0;
    runningSensors = 0;

    // Check status of each sensor
    sensorData.forEach((key, sensor) {
      String status = sensor['status']; // Assuming status is stored as 'status'
      if (status == '0') {
        faultySensors++;
      } else if (status == '1') {
        runningSensors++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor report"), elevation: 0),
      body:
          sensorData.isEmpty
              ? const Center(
                child: CircularProgressIndicator(),
              ) // Show loading spinner while fetching data
              : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: sensorName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(sensorName[index]),
                      subtitle: Row(
                        children: [
                          // Total Installed Sensors
                          Row(
                            children: [
                              const Text("Total installed:"),
                              Text(
                                " $totalSensors",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.025),
                          // Faulty Sensors
                          Row(
                            children: [
                              const Text("Faulty sensors:"),
                              Text(
                                " $faultySensors",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.025),
                          // Running Sensors
                          Row(
                            children: [
                              const Text("Running:"),
                              Text(
                                " $runningSensors",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
