import 'package:biletinial_doviz/controller/firebase_save_controller.dart';
import 'package:biletinial_doviz/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth_controller.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';

import '../translation/strings.dart';

class HistoryPage extends StatelessWidget {
   HistoryPage({Key? key}) : super(key: key);

   FirebaseSaveController firebaseSaveController=Get.find(tag:  "FirebaseSaveController");
   AuthController controllerAuth = Get.put(AuthController());
   final gradientList = <List<Color>>[
     [
       Color.fromRGBO(223, 250, 92, 1),
       Color.fromRGBO(129, 250, 112, 1),
     ],
     [
       Color.fromRGBO(129, 182, 205, 1),
       Color.fromRGBO(91, 253, 199, 1),
     ],
     [
       Color.fromRGBO(175, 63, 62, 1.0),
       Color.fromRGBO(254, 154, 92, 1),
     ]
   ];

   @override
   Widget build(BuildContext context) {
     var sortMap={ for (var e in firebaseSaveController.sortList) e.type : e.total };
     print(sortMap);

     return Scaffold(
         body: Center(
           child: Obx(() => Column(
             children: [
               SizedBox(height: 5.h,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   InkWell(
                     child: Image.asset(
                       "assets/images/back_button.png",
                       height: 3.h,
                       width: 3.w,
                       color: Get.theme.cardColor,
                     ),
                     onTap: () {
                       Navigator.pop(context);
                     },
                   ),
                    Text(
                      Strings().history.tr.toUpperCase(),
                     style: TextStyle(
                          fontSize: 20.sp, fontFamily: "DM Sans"),
                   ),
                   SizedBox()
                 ],
               ), //Üst panel

               if(sortMap.isNotEmpty) PieChart(dataMap: sortMap,
                 animationDuration: Duration(milliseconds: 800),
                 chartLegendSpacing: 32,
                 chartRadius: MediaQuery.of(context).size.width / 2,
                 //colorList: colorList,
                 //initialAngleInDegree: 0,
                 //chartType: ChartType.ring,
                 ringStrokeWidth: 32,
                 // centerText: "HYBRID",
                 gradientList: gradientList,
                 emptyColorGradient: [
                   Color(0xff6c5ce7),
                   Colors.blue,
                 ],

               ),

               Expanded(
                 child: ListView.separated(itemBuilder:(BuildContext context,index){
                   return ExpansionPanelList(
                     animationDuration: Duration(milliseconds: 1000),
                     dividerColor: Colors.red,
                     elevation: 2,
                     children: [
                       ExpansionPanel(
                         body: Container(
                             height: 25.h,
                             child: ListView.separated(itemCount: firebaseSaveController.dataList.length,itemBuilder: (BuildContext context,int icindex){
                               if((firebaseSaveController.dataList[icindex].time as Timestamp).toDate().day==firebaseSaveController.tarihList[index].day && (firebaseSaveController.dataList[icindex].time as Timestamp).toDate().month==firebaseSaveController.tarihList[index].month &&(firebaseSaveController.dataList[icindex].time as Timestamp).toDate().year==firebaseSaveController.tarihList[index].year ){
                                 return Container(
                                   height: 10.h,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       Text("${firebaseSaveController.dataList[icindex].type}",style: TextStyle(fontSize: 16.sp),),
                                       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                                         Text("${Strings().piece.tr}: ${firebaseSaveController.dataList[icindex].piece}",style: TextStyle(fontSize: 12.sp),),
                                         Text("${Strings().unitPrice.tr} : ${firebaseSaveController.dataList[icindex].unit_price}",style: TextStyle(fontSize: 12.sp),),

                                       ],),
                                       Divider(thickness: 2,)
                                     ],
                                   ),
                                 );
                               }
                               else return SizedBox();

                             }, separatorBuilder: (BuildContext context, int index) {
                               return SizedBox();
                             },)
                         ),
                         headerBuilder: (BuildContext context, bool isExpanded) {
                           return Container(
                             decoration: BoxDecoration(color: Colors.grey.shade300),
                             padding: EdgeInsets.all(10),
                             child: Center(
                               child: Text("${firebaseSaveController.tarihList[index].day} / ${firebaseSaveController.tarihList[index].month} / ${firebaseSaveController.tarihList[index].year}",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold,color: Colors.green)),
                             ),
                           );
                         },
                         isExpanded: firebaseSaveController.tarihList[index].expanded,
                       )
                     ],
                     expansionCallback: (int item, bool status) => firebaseSaveController.changeExpension(index,status),expandedHeaderPadding: EdgeInsets.all(5),);
                 },
                   itemCount: firebaseSaveController.tarihList.length,
                   separatorBuilder: (BuildContext context, index){
                     return SizedBox();
                   },
                 ),
               ),
             ],
           ),
           ),
         ),
        endDrawer: MyDrawer(),
     );
   }
}