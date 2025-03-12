import 'package:flutter/material.dart';

import '../widgets/appbarWidget.dart';
import '../widgets/notificationWidgets/listCreator.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override

  // List<String> items = ['Martin Atwiine', 'Arinda Marvin', 'Chris Martin', 'durian', 'Martin Atwiine','Martin Atwiine','Martin Atwiine','Martin Atwiine','Martin Atwiine'];

  @override
  void _onSearchQueryChanged(String query) {
    setState(() {
      filteredItems = availableNotification
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // Initially, display all items before filtering
    filteredItems = availableNotification;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
//
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
          child: TextFormField(
            onChanged: _onSearchQueryChanged,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              prefixIcon: const Icon(Icons.search),
              hintText: 'filter notification',
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.0004,
        ),

        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (BuildContext context, int index) {
              ListItem item = filteredItems[index];
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("assets/image1.png"),
                  ),
                  subtitle: Text(
                    item.message,
                    style: TextStyle(color: Colors.black.withOpacity(0.4)),
                  ),
                  trailing: Text(
                    '${item.date.year}-${item.date.day}-${item.date.day} ',
                    style: TextStyle(color: Colors.red.withOpacity(0.4)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
