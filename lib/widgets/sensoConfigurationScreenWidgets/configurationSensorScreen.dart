import 'dart:convert'; // For json.encode()
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfigurationSensorScreen extends StatefulWidget {
  final String sensorName;
  final int sensorNumber;
  final IconData iconSensor;

  const ConfigurationSensorScreen({
    super.key,
    required this.sensorName,
    required this.sensorNumber,
    required this.iconSensor,
  });

  @override
  State<ConfigurationSensorScreen> createState() =>
      _ConfigurationSensorScreenState(sensorName, sensorNumber, iconSensor);
}

class _ConfigurationSensorScreenState extends State<ConfigurationSensorScreen> {
  final String sensorName;
  final int sensorNumber;
  final IconData iconSensor;

  _ConfigurationSensorScreenState(
    this.sensorName,
    this.sensorNumber,
    this.iconSensor,
  );

  final url =
      'https://apms-6f88c-default-rtdb.firebaseio.com/sensors.json'; // Firebase URL

  // Helper method to create action buttons (on/off)
  Widget _buildActionButton(
    String label,
    Color color,
    String dataValue,
    int index,
  ) {
    return InkWell(
      onTap: () async {
        try {
          // Send data to Firebase Realtime Database
          final response = await http.post(
            Uri.parse(url),
            body: json.encode({
              'sensorCategory': sensorName,
              'sensorId': '${index + 1}',
              'status': dataValue, // "1" for on, "0" for off
            }),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$sensorName ${index + 1} ${label.toLowerCase()} successfully",
                ),
              ),
            );
          } else {
            throw Exception('Failed to send data');
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Sensor failed to connect, check your internet connection.",
              ),
            ),
          );
          print('Error sending data: $e');
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.04,
        ),
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(color: color),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            sensorName,
            style: TextStyle(fontSize: size.height * 0.020),
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sensorNumber,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: size.height * 0.112,
                  width: size.width * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.044),
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.04),
                            child: Icon(
                              iconSensor,
                              size: size.height * 0.065,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildActionButton('on', Colors.blue, '1', index),
                          _buildActionButton('off', Colors.red, '0', index),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
