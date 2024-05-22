import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master_admin/Data/db_service.dart';
import 'package:weigh_master_admin/Presentation/adding_page.dart';
import 'package:weigh_master_admin/Presentation/buy_request.dart';
import 'package:weigh_master_admin/constants/custom_side_bar.dart';

class HomePageDetails extends StatefulWidget {
  const HomePageDetails({super.key});

  @override
  State<HomePageDetails> createState() => _HomePageDetailsState();
}

class _HomePageDetailsState extends State<HomePageDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomSideBar(
            //     icon: CupertinoIcons.shopping_cart,
            //     onClicked: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => ViewBuyRequest()));
            //     }),
            // SizedBox(
            //   height: 20,
            // ),
            // CustomSideBar(
            //     icon: Icons.message,
            //     onClicked: () {
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (context) => AddProductPage()));
            //     }),
            // SizedBox(
            //   height: 20,
            // ),
            CustomSideBar(
                icon: Icons.add,
                onClicked: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddProductPage()));
                })
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Consumer<DbService>(builder: (context, service, child) {
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Product Data")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data!.docs;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, crossAxisSpacing: 30),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: height / 3,
                                width: width / 3,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            data[index]["image"]))),
                              ),
                              Text(
                                data[index]["name"],
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data[index]["discription"]} (${data[index]["type"]})",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "₹ ${data[index]["rate"].toString()}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                });
          }),
        )
      ],
    );
  }
}
