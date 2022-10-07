import 'package:biletinial_doviz/pages/person_list_page.dart';
import 'package:biletinial_doviz/translation/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/firebase_save_controller.dart';
class Person extends StatelessWidget {
  const Person({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseSaveController controllerFirebase = Get.find(tag : "FirebaseSaveController");

    return Scaffold(

      body: Center(child: Column(
        children: [
          SizedBox(height:5.h ,),
          Text(Strings().personList.tr.toUpperCase(),style: TextStyle(fontSize: 16.sp),),
          Expanded(
            child: PersonListPage()
          ),
        ],
      ),),
    );
  }
}
