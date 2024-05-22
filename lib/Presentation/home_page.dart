import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master_admin/Presentation/login_page.dart';
import 'package:weigh_master_admin/Presentation/service.dart';
import 'package:weigh_master_admin/Presentation/warrenty_page.dart';
import 'package:weigh_master_admin/constants/custom_colors.dart';
import 'package:weigh_master_admin/Presentation/home_page_details.dart';
import 'package:weigh_master_admin/Presentation/review_page.dart';
import 'package:weigh_master_admin/Presentation/order_and_rent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = [
    "Home",
    "Review",
    "Order / Rent",
    "Warranty",
    "Service",
  ];

  List<Widget> pages = [
    const HomePageDetails(),
    const ReviewPage(),
    const OrderAndRent(),
    const WarrentyPage(),
    const ServicePage()
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(CupertinoIcons.search),
        // ),
        title: SizedBox(
          height: 80,
          child: Center(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: current == index
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(179, 0, 0, 0))),
                    )),
                  );
                }),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 244, 250, 255),
        child: pages[current],
      ),
    );
  }
}
