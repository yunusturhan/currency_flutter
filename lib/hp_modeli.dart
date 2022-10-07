import 'package:biletinial_doviz/controller/firebase_save_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPageModeli extends StatefulWidget {
  HistoryPageModeli({Key? key}) : super(key: key);

  @override
  State<HistoryPageModeli> createState() => _HistoryPageModeliState();
}

class _HistoryPageModeliState extends State<HistoryPageModeli> {
  FirebaseSaveController firebaseSaveController=Get.put(FirebaseSaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height:30,),
          Text("History ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),

          Container(
            height: 500,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(

              itemCount: itemData.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 1000),
                  dividerColor: Colors.red,
                  elevation: 1,
                  children: [
                    ExpansionPanel(
                      body: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          itemData[index].discription,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              letterSpacing: 0.3,
                              height: 1.3),
                        ),
                      ),
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            itemData[index].headerItem,
                            style: TextStyle(
                              color: itemData[index].colorsItem,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      isExpanded: itemData[index].expanded,
                    )
                  ],
                  expansionCallback: (int item, bool status) {
                    setState(() {
                      itemData[index].expanded = !itemData[index].expanded;
                      print(firebaseSaveController.getBasketHistoryData());
                    });
                  },
                );
              },
            ),
          ),
        ],
      ) ,
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem: 'Android',
      discription:
      "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
      colorsItem: Colors.green,
    ),
  ];
}
class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;

  ItemModel({this.expanded: false, required this.headerItem, required this.discription,required this.colorsItem,});
}