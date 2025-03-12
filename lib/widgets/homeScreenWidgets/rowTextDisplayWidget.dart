import 'package:apms/Screens/collectionScreen.dart';
import 'package:apms/widgets/sensoConfigurationScreenWidgets/sensorReport.dart';
import 'package:flutter/material.dart';

class RowTextDisplayWidget extends StatelessWidget {
  final String description;
  const RowTextDisplayWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(description, style: const TextStyle(color: Colors.blue)),
          InkWell(
            hoverColor: Colors.amber,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SensorReport();
                  },
                ),
              );
            },
            child: Text(
              "See all",
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}

class RowTextDisplayWidget2 extends StatelessWidget {
  final String description;
  const RowTextDisplayWidget2({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(description, style: const TextStyle(color: Colors.blue)),
          InkWell(
            hoverColor: Colors.amber,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DataCollectionScreen();
                  },
                ),
              );
            },
            child: Text(
              "See all",
              style: TextStyle(color: Colors.black.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}
