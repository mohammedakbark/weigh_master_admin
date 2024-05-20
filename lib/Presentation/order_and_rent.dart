import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weigh_master_admin/constants/constant_list.dart';

class OrderAndRent extends StatefulWidget {
  const OrderAndRent({super.key});

  @override
  State<OrderAndRent> createState() => _OrderAndRentState();
}

class _OrderAndRentState extends State<OrderAndRent> {
  bool orderList = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  orderList = true;
                });
              },
              child: Text("Order", style:  TextStyle(color: orderList? Colors.blueGrey:Colors.white),),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  orderList = false;
                });
              },
              child: Text("Rent", style:  TextStyle(color: orderList? Colors.white:Colors.blueGrey),),
            ),
          ],
        ),
        SizedBox(
          height: height / 1.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstantList(),
              ConstantList(),
            ],
          ),
        ),
      ],
    );
  }
}
