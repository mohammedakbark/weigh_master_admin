import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weigh_master_admin/Data/Model/productModel.dart';
import 'package:weigh_master_admin/Data/db_service.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  var productnameController = TextEditingController();
  var productRateController = TextEditingController();
  var productDiscription = TextEditingController();
  String selectedItem = "";
  final _formKey = GlobalKey<FormState>();
  List<String> items = ["Buy", "Rent"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Product",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DbService>(builder: (context, dbController, child) {
                return dbController.processingImage
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          dbController.pickImageinWeb();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 160, 203, 161)),
                          height: 200,
                          width: 250,
                          child: dbController.imageBytes != null
                              ? Image.memory(dbController.imageBytes!)
                              : const Icon(Icons.image),
                        ),
                      );
              }),
              const SizedBox(
                height: 20,
              ),
              customeTextfiled(
                controller: productnameController,
                hintText: "Product Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              customeTextfiled(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                controller: productRateController,
                hintText: "Product Rate",
              ),
              const SizedBox(
                height: 20,
              ),
              customeTextfiled(
                controller: productDiscription,
                hintText: "Product Discription",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .2,
                child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Select type";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: "Product Type",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder()),
                    items: items
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (selectedItemV) {
                      selectedItem = selectedItemV!;
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DbService>(builder: (context, dbSer, chuld) {
                return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // if (dbSer.imageurl != null) {
                        dbSer
                            .storeProduct(ProductModel(
                                image: dbSer.imageurl ?? "",
                                discription: productDiscription.text,
                                name: productnameController.text,
                                rate: double.parse(productRateController.text),
                                type: selectedItem))
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Product Added Successful!")));
                          Navigator.of(context).pop();
                        });
                        // }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           backgroundColor: Colors.green,
                        //           content: Text(
                        //               "Somthing went wrong ,Try again!")));
                        // }
                      }
                    },
                    child: const Text("Submit"));
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class customeTextfiled extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  String hintText;
  customeTextfiled({
    super.key,
    this.keyboardType,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .2,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(),
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none),
      ),
    );
  }
}
