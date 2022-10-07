import 'package:biletinial_doviz/auth_controller.dart';
import 'package:biletinial_doviz/controller/language_controller.dart';
import 'package:biletinial_doviz/pages/history_page.dart';
import 'package:biletinial_doviz/pages/person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../pages/message_pages/message_page.dart';
import '../translation/strings.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AuthController controllerAuth = Get.put(AuthController());
    LanguageController controllerLanguage=Get.put(LanguageController());



    return Drawer(child: Column(
      children: [
        DrawerHeader(child:Text("${controllerAuth.firebaseUser.value!.email}")),
        ElevatedButton(onPressed: (){ Get.to(()=>HistoryPage());}, child: Text(Strings().history.tr,style: TextStyle(fontSize: 16.sp),)),


        ElevatedButton(onPressed: (){
          Get.isDarkMode==true ?Get.changeTheme(ThemeData.light()):Get.changeTheme(ThemeData.dark());
        }, child: Text("tema",style: TextStyle(fontSize: 16.sp))
        ),
        ElevatedButton(onPressed: (){
          controllerLanguage.buildLanguageDialog(context);

        }, child: Text(Strings().changeLanguage.tr,style: TextStyle(fontSize: 16.sp))
        ),




        ElevatedButton(onPressed: (){

          Get.to(()=>Person());

        }, child:Text(Strings().personList.tr,style: TextStyle(fontSize: 16.sp))),

        ElevatedButton(onPressed: (){

          Get.to(()=>MessagePage());

        }, child:Text("Message",style: TextStyle(fontSize: 16.sp))),














        ElevatedButton(onPressed: (){

          controllerAuth.signOut();

        }, child:Text(Strings().signOut.tr,style: TextStyle(fontSize: 16.sp))),


      ],
    ));
  }

}