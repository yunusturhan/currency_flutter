import 'package:biletinial_doviz/constants.dart';
import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../translation/strings.dart';
import 'message_detail_list.dart';

class MessageDetailPage extends StatelessWidget {
  MessageDetailPage({Key? key}) : super(key: key);

  TextEditingController textMessageController=TextEditingController();
  MessageController messageController =Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.h,),
            Container(
              
              height: 15.h,
                width: 100.w,
                child:InkWell(
                    onTap:(){
                      groupList(context);

                    },child: Center(child: Text(messageController.title ?? "",style: TextStyle(fontSize: 14.sp),))),
            color: Colors.grey.shade300),
            Expanded(child:MessageDetailListPage()),
            TextField(
              controller: textMessageController,
              decoration: InputDecoration(
                suffixIcon: IconButton(icon:Icon(Icons.send,size: 3.h,),onPressed: (){

                  messageController.MessageDetailAdd(textMessageController.text, authController.firebaseUser.value!.email, ["${authController.firebaseUser.value!.email}"], messageController.doc ?? "");
                  messageController.update();
                  messageController.getMessageDetailList(messageController.doc ?? "");
                  textMessageController.text="";
                }),


                hintText:Strings().enterMessage.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: ()=>messageController.scrollDown(),

            )
          ],
        ),
      ),
    );
  }


  Future<void> groupList(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(() =>  AlertDialog(
              title: Text("Sohbet Üyeleri",style: TextStyle(fontSize: 16.sp),),
              content: Column(
                children: [
                  Divider(color: Colors.black,height: 1.h),
                  SizedBox(
                    height: 70.h,
                    width: 90.w,
                    child:Column(
                      children: [
                        Expanded(
                          child: ListView.builder(itemCount: messageController.groupList.length,itemBuilder: (context,index){
                            return Text(messageController.groupList[index]);

                          }),
                        ),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Kapat")),
                      ],
                    ) ,
                  ),
                ],
              )
          ));
        });
  }



}
