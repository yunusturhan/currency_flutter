import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:biletinial_doviz/pages/basket.dart';
import 'package:biletinial_doviz/pages/coal.dart';
import 'package:biletinial_doviz/pages/currency_pages/currency.dart';
import 'package:biletinial_doviz/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../auth_controller.dart';
import '../controller/firebase_save_controller.dart';
import 'package:sizer/sizer.dart';

import '../translation/strings.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

   AuthController controllerAuth = Get.put(AuthController());
   FirebaseSaveController firebaseSaveController=Get.put(FirebaseSaveController(),tag:  "FirebaseSaveController");
   MessageController messageController=Get.put(MessageController());
   List page=[CurrencyScreen(),CoalScreen()];

   @override
   Widget build(BuildContext context) {
     return Obx(() =>Scaffold(
       body:Center(child: Column(
         children: [
           Shimmer.fromColors(
               baseColor: Colors.black,
               highlightColor: Colors.grey,
               child: Text(Strings().liveTransactions.tr.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp),)),
           Container(
               height: 30.h,
               child: StreamBuilder(builder: (BuildContext contex,snapshot){
                 return ListView.separated(itemCount: firebaseSaveController.dataList.length,itemBuilder: (BuildContext context,int index){
                   return Container(
                     height: 10.h,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Text("${firebaseSaveController.dataList[index].type}",style: TextStyle(fontSize:12.sp),),
                         Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                           Text("${Strings().time.tr}: ${(firebaseSaveController.dataList[index].time as Timestamp).toDate().hour}:${(firebaseSaveController.dataList[index].time as Timestamp).toDate().minute}:"
                               "${(firebaseSaveController.dataList[index].time as Timestamp).toDate().second}:${(firebaseSaveController.dataList[index].time as Timestamp).toDate().millisecond}"
                               " ${(firebaseSaveController.dataList[index].time as Timestamp).toDate().day}/${(firebaseSaveController.dataList[index].time as Timestamp).toDate().month}/${(firebaseSaveController.dataList[index].time as Timestamp).toDate().year}",style: TextStyle(fontSize:12.sp),),
                           Text("${Strings().piece.tr} : ${firebaseSaveController.dataList[index].piece}",style: TextStyle(fontSize:12.sp),),

                         ],),
                         Divider(thickness: 2,),
                       ],
                     ),
                   );


                 }, separatorBuilder: (BuildContext context, int index) {
                   return SizedBox();
                 },);
               })
           ),
           Expanded(child: page[firebaseSaveController.currentTab.value])
         ],
       ),),
       bottomNavigationBar: AnimatedBottomNavigationBar(
           height: Get.height/12,
           gapLocation: GapLocation.center,
           backgroundColor: Colors.black,
           activeColor: Colors.white,
           inactiveColor: Colors.grey,
           icons: [FontAwesomeIcons.moneyCheckDollar,FontAwesomeIcons.coins],iconSize: 3.h,
           activeIndex:firebaseSaveController.currentTab.value,
           onTap:(int value) => firebaseSaveController.changeTabIndex(value)),
       floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,
         onPressed:()=>Get.to(()=>BasketPage()),child:Icon(FontAwesomeIcons.basketShopping,size: 3.h,color: Colors.white,),),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       endDrawer: MyDrawer()
     ));
   }





}
