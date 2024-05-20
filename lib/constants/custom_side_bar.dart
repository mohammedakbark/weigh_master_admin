import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key, required this.icon, required this.onClicked});

  final IconData icon;
  final Function() onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          width: MediaQuery.of(context).size.width/10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          )
      ),
    );
  }
}
