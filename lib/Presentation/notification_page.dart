import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: width/3,
          child: ListView.separated(
              itemBuilder: (context, index){
                return SizedBox(
                  height: height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey,child: Icon(Icons.person, color: Colors.white,),),
                      SizedBox(
                        height: height/15,
                          width: width/8,
                          child: Text("Someone commended on your post: Around Heavy ball floor")
                      ),
                      Text("9.55 PM"),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index)=> SizedBox(height: 15,),
              itemCount: 15),
        ),
        SizedBox(
          width: width / 2.5,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: 12,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width/5,
                    color: Colors.blueGrey,
                  ),
                );
              }),
        )
      ],
    );
  }
}
