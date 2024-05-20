import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master_admin/constants/custom_colors.dart';
import 'package:weigh_master_admin/Presentation/home_page_details.dart';
import 'package:weigh_master_admin/Presentation/notification_page.dart';
import 'package:weigh_master_admin/Presentation/order_and_rent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> items = [
    "Home",
    "Notifications",
    "Order / Rent",
    "Warranty",
    "Service",
  ];

  List <Widget> pages=[
    HomePageDetails(),
    NotificationPage(),
    OrderAndRent(),
    Text("data"),
    Text("data"),
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.backgroundGreen,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.search),
        ),
        title: SizedBox(
          height: 80,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(width: MediaQuery.of(context).size.width/10,),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: Text(items.elementAt(index),
                            style: TextStyle(
                                color:
                                current == index ? Colors.blueGrey : Colors.white70)),
                      )
                  ),
                );
              }),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: CustomColors.backgroundGreen,
        child: pages[current],
      ),
    );
  }
}
