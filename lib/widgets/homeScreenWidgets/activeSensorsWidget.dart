import 'package:flutter/material.dart';

class ActiveSensorsWidget extends StatefulWidget {
  const ActiveSensorsWidget({super.key});

  @override
  State<ActiveSensorsWidget> createState() => _ActiveSensorsWidgetState();
}

class _ActiveSensorsWidgetState extends State<ActiveSensorsWidget> {
  @override
  List icons = [
    Icons.temple_buddhist,
    Icons.alarm,
    Icons.camera,
    Icons.water,
  ];
  List iconnames = ["Temperature", "Alarm", "Camera", "Water sensor"];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: iconnames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              height: size.height * 0.010,
              width: size.width * 0.25,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(255, 8, 75, 121)
                          .withOpacity(0.4),
                      offset: const Offset(0.5, 3),
                      blurRadius: 0.1,
                      spreadRadius: 0.2),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(
                      icons.elementAt(index),
                      size: size.height * 0.037,
                    ),
                    Divider(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                    Text(
                      iconnames.elementAt(index),
                      style: const TextStyle(fontSize: 10),
                    )
                   
                  ],
                ),
              ),
            ),
          );
        });
  }
}
