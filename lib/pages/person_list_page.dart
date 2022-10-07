import 'package:biletinial_doviz/translation/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/firebase_save_controller.dart';
class PersonListPage extends StatelessWidget {
  const PersonListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseSaveController controllerFirebase = Get.find(tag : "FirebaseSaveController");


    return ListView.builder(itemCount: controllerFirebase.personList.length,itemBuilder: (context,index){
      return Container(
        height: 15.h,
        decoration: BoxDecoration(
            border: Border.all(width: .25.h, color: Colors.grey.shade400),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: const Color.fromRGBO(26, 56, 72, 1)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    controllerFirebase.personList[index].name,
                    style:  TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),
                  Text(
                    controllerFirebase.personList[index].email,
                    style:  TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),

                ],
              ),
              SizedBox(width: 1.h,),
              ElevatedButton.icon(onPressed: (){},label: Text(Strings().sendMessage.tr),icon: Icon(Icons.add_comment_outlined,size: 2.h,),),
            ],
          ),
        ),
      );
    });
  }
}
