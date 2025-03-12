import 'package:flutter/material.dart';

class FooterTitleLink extends StatefulWidget {
  const FooterTitleLink({super.key});

  @override
  State<FooterTitleLink> createState() => _FooterTitleLinkState();
}

class _FooterTitleLinkState extends State<FooterTitleLink> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.095,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
      child: const Center(
          child: Text(
        "check out sensor report",
        style: TextStyle(color: Colors.blue),
      )),
    );
  }
}
