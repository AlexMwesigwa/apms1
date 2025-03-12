class SensorData {
  final String sensor_id;
  final double feedLevel;
  final double humidity;
  final double temperature;
  final double waterlevel;
  final String timestamp;

  SensorData({
    required this.sensor_id,
    required this.feedLevel,
    required this.humidity,
    required this.temperature,
    required this.waterlevel,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'feedLevel': feedLevel,
      'humidity': humidity,
      'temperature': temperature,
      'waterLevel': waterlevel,
      'timestamp': timestamp,
    };
  }
}
