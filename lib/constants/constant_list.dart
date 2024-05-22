import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master_admin/Data/Model/buy_product_model.dart';
import 'package:weigh_master_admin/Data/db_service.dart';

class ConstantList extends StatelessWidget {
  bool isOrder = false;
  ConstantList({super.key, required this.isOrder});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 3,
      child: Consumer<DbService>(builder: (context, service, chil) {
        return FutureBuilder(
            future: service.getAllBroughtProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<BuyProductModel> data = [];
              if (isOrder == true) {
                data = service.listOfBuy
                    .where((element) => element.productModel.type == "Buy")
                    .toList();
              } else {
                data = service.listOfBuy
                    .where((element) => element.productModel.type == "Rent")
                    .toList();
              }

              return data.isEmpty
                  ? const Center(
                      child: Text("No Data"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    data[index].productModel.image),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].productModel.name,
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Text(data[index].productModel.discription),
                                  ],
                                ),
                              ),
                              Text(data[index].boughtDate),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: data.length);
            });
      }),
    );
  }
}
