import 'package:flutter/material.dart';

class DataCollectionWidget extends StatefulWidget {
  final String description;
  final String amount;
  const DataCollectionWidget(
      {super.key, required this.description, required this.amount});

  @override
  State<DataCollectionWidget> createState() =>
      _DataCollectionWidgetState(amount, description);
}

class _DataCollectionWidgetState extends State<DataCollectionWidget> {
  @override
  final String description;
  final String amount;
  _DataCollectionWidgetState(this.amount, this.description);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.3,
              spreadRadius: 0.3),
          BoxShadow(
              color: Color.fromARGB(255, 158, 158, 158),
              offset: Offset(0.0, 0.0),
              blurRadius: 0.3,
              spreadRadius: 0.3),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            description,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Color.fromARGB(255, 8, 51, 92),
          ),
          Text(
            amount,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
