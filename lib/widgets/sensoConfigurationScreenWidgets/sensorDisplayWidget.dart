import 'package:flutter/material.dart';

import 'configurationSensorScreen.dart';

class SensorDisplayWidget extends StatefulWidget {
  final double temperature;
  final double humidity;
  final double waterLevel;
  final double feedLevel;
  final String securityStatus;

  const SensorDisplayWidget({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.waterLevel,
    required this.feedLevel,
    required this.securityStatus,
  });

  @override
  State<SensorDisplayWidget> createState() => _SensorDisplayWidgetState();
}

class _SensorDisplayWidgetState extends State<SensorDisplayWidget> {
  List icons = [
    Icons.lightbulb,
    Icons.thermostat,
    Icons.water,
    Icons.fastfood,
    Icons.security,
  ];

  List<String> iconNames = [
    "Light Control",
    "Temperature Sensor",
    "Water Level Sensor",
    "Feed Level Sensor",
    "Security Status",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<String> sensorValues = [
      "-", // Light Control (not in Firebase yet)
      "${widget.temperature}°C",
      "${widget.waterLevel}%",
      "${widget.feedLevel}%",
      widget.securityStatus,
    ];

    return Container(
      height: size.height * 0.53,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: iconNames.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ConfigurationSensorScreen(
                  sensorName: iconNames[index],
                  sensorNumber: 1,
                  iconSensor: icons[index],
                );
              }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.009,
                  horizontal: size.width * 0.04),
              height: size.height * 0.22,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 8, 75, 121)
                          .withOpacity(0.4),
                      offset: const Offset(0.5, 2),
                      blurRadius: 0.1,
                      spreadRadius: 0.2),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.022),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: size.width * 0.09),
                            height: size.height * 0.10,
                            width: size.width * 0.22,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Icon(
                              icons[index],
                              color: Colors.white,
                            ))),
                        Padding(
                          padding: EdgeInsets.only(right: size.width * 0.15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${iconNames[index]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: size.height * 0.010,
                              ),
                              Text(
                                "Current Value: ${sensorValues[index]}",
                                style: const TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: size.height * 0.012,
                    ),
                    Text(
                      "Activate or deactivate sensor",
                      style: TextStyle(
                          color: Colors.blue.withOpacity(0.3),
                          fontSize: size.height * 0.014),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
