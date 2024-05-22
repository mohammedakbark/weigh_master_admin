import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master_admin/Data/db_service.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Consumer<DbService>(builder: (context, service, child) {
          return StreamBuilder(
              stream: service.getAllFeedBack().asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = service.listOFFeedback;
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: width * .4,
                      child: data.isEmpty
                          ? const Center(
                              child: Text("No Reviews"),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: height / 10,
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * .03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].username,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(data[index].email),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${data[index].suggession} ${data[index].experience}",
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Expanded(child: SizedBox()),
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.red, width: 2)),
                                          onPressed: () {
                                            service.deletReview(
                                                data[index].feedbackid);
                                          },
                                          child:
                                              const Text("Remove This Review"))
                                      // OutlineButton(

                                      //     onPressed: () {},
                                      //     child: )
                                      // const Text("9.55 PM"),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 15,
                                  ),
                              itemCount: data.length),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Loading"),
                  );
                }
              });
        }),
        Expanded(
          child: Consumer<DbService>(builder: (context, service, child) {
            return SizedBox(
              // width: width / 2,
              child: FutureBuilder(
                  future: service.getAllProduct(),
                  builder: (context, sbnapshot) {
                    if (sbnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    log(service.productLists.length.toString());
                    final data = sbnapshot.data!.docs;
                    ;
                    return data.isEmpty
                        ? const Center(
                            child: Text("No Product"),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: width / 5,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              data[index]["image"]))),
                                  child: Column(
                                    children: [
                                      Text(
                                        data[index]["name"],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                  }),
            );
          }),
        )
      ],
    );
  }
}
