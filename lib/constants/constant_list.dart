import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstantList extends StatelessWidget {
  const ConstantList({super.key});

  @override
  Widget build(BuildContext context) {

    double width= MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 3,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: 250,
                      child: Text(
                          "Someone commended on your post: Around Heavy ball floor")),
                  Text("9.55 PM"),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
          itemCount: 15),
    );
  }
}
