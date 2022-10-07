import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth_controller.dart';
import '../../controller/message_controller.dart';
import '../../models/message_detail_model.dart';
import 'package:sizer/sizer.dart';

class MessageDetailListPage extends GetView<MessageController> {

  MessageDetailListPage({Key? key}) : super(key: key);
  MessageController messageController = Get.put(MessageController());
  AuthController authController = Get.put(AuthController());

  List<MessageDetail> messageDetail = [];


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Obx(() =>ListView.builder(
              itemCount: messageController.messageDetailList.length,
              controller: messageController.controller,
              itemBuilder: (context, index) {
                if (messageController.messageDetailList[index].sender ==
                    authController.firebaseUser.value!.email) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(1.h),
                        height: 7.h,
                        width: 80.w,
                        decoration: BoxDecoration(color: Colors.green.shade100,borderRadius: BorderRadius.circular(5.h)),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 3.h,top: .5.h),
                              child: Text(messageController.messageDetailList[index].content,style: TextStyle(fontSize: 16.sp),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 3.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${(messageController.messageDetailList[index].time as Timestamp).toDate().hour}:${(messageController.messageDetailList[index].time as Timestamp).toDate().minute}",style: TextStyle(fontSize: 10.sp),),
                                  Icon(Icons.done_all,color: messageController.usersLenght==messageController.messageDetailList[index].readers.length ? Colors.green.shade700:Colors.grey.shade700,size: 2.25.h,),

                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                else{
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(1.h),
                        height: 7.h,
                        width: 80.w,
                        decoration: BoxDecoration(color: Colors.blue.shade100,borderRadius: BorderRadius.circular(5.h)),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 3.h,top: .5.h),
                              child: Text(messageController.messageDetailList[index].content,style: TextStyle(fontSize: 16.sp),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 3.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${(messageController.messageDetailList[index].time as Timestamp).toDate().hour}:${(messageController.messageDetailList[index].time as Timestamp).toDate().minute}",style: TextStyle(fontSize: 10.sp),),
                                  Icon(Icons.done_all,color: messageController.usersLenght==messageController.messageDetailList[index].readers.length ? Colors.green.shade700:Colors.grey.shade700,size: 2.25.h),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
              }
          ),
    ));
}

}