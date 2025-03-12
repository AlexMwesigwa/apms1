import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:apms/utils/dataJSONreading/sensorData.dart';

class DataCollectionScreen extends StatefulWidget {
  @override
  _DataCollectionScreenState createState() => _DataCollectionScreenState();
}

class _DataCollectionScreenState extends State<DataCollectionScreen> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .ref()
      .child('sensors'); // Firebase path to sensors

  List<SensorData> sensorList = []; // List to store sensor objects

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  void _fetchSensorData() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        List<SensorData> loadedSensors = [];

        data.forEach((key, value) {
          loadedSensors.add(
            SensorData(
              sensor_id: key,
              feedLevel: (value['feedLevel'] ?? 0).toDouble(),
              humidity: (value['humidity'] ?? 0).toDouble(),
              temperature: (value['temperature'] ?? 0).toDouble(),
              waterlevel: (value['waterLevel'] ?? 0).toDouble(),
              timestamp: value['timestamp'] ?? 'No Timestamp',
            ),
          );
        });

        setState(() {
          sensorList = loadedSensors;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Data')),
      body:
          sensorList.isEmpty
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loading indicator
              : ListView.builder(
                itemCount: sensorList.length,
                itemBuilder: (context, index) {
                  SensorData sensor = sensorList[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Sensor ID: ${sensor.sensor_id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Feed Level: ${sensor.feedLevel}'),
                          Text('Humidity: ${sensor.humidity}%'),
                          Text('Temperature: ${sensor.temperature}°C'),
                          Text('Water Level: ${sensor.waterlevel}'),
                          Text('Timestamp: ${sensor.timestamp}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
