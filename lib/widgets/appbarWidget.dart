

import 'package:flutter/material.dart';

import 'userAccountWidgets/userConfigurationPage.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.009),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu),
          Column(
            children: [
              Text("APMS",
                  style: TextStyle(
                      fontSize: size.height * 0.05,
                      fontWeight: FontWeight.bold)),
              Text(
                "Making poultry farming efficient with technology",
                style: TextStyle(fontSize: size.height * 0.009),
              )
            ],
          ),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const UserConfigurationPage();
                }));
              },
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.03),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/image1.png"),
                ),
              ))
        ],
      ),
    );
  }
}
