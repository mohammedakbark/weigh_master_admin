import 'package:flutter/material.dart';
import 'package:weigh_master_admin/constants/custom_colors.dart';

class ViewBuyRequest extends StatelessWidget {
  const ViewBuyRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundGreen,
      appBar: AppBar(
        title: Text(
          "Buy / Rent Request",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );  
  }
}
