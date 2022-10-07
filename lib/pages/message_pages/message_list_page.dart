import 'package:biletinial_doviz/auth_controller.dart';
import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
class MessageListPage extends StatelessWidget {
  MessageListPage({Key? key}) : super(key: key);

  MessageController messageController =Get.put(MessageController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {



    return ListView.builder(itemCount: messageController.messageList.length,itemBuilder: (context,index){
      String title="";
      if(messageController.messageList[index].users.length>2){
        title=messageController.messageList[index].title;
      }
      else{
        if(messageController.messageList[index].users[0]==authController.firebaseUser.value!.email){
          title=messageController.messageList[index].users[1];
        }
        else {
          title=messageController.messageList[index].users[0];

        }
      }
      return InkWell(
        onTap:()async{

          await messageController.MessageReaderAdd();

          await messageController.getMessageDetailList(messageController.messageList[index].doc_id);
          messageController.usersLenght =  messageController.messageList[index].users.length;
          messageController.doc =  messageController.messageList[index].doc_id;
          messageController.title = title;
          messageController.groupList.clear();
          messageController.messageList[index].users.forEach((element) {
            messageController.groupList.add(element);
          });
          await Get.toNamed( '/messageDetail');
          await messageController.getMessageList();
        },
        child: Container(
          height: 15.h,
          decoration: BoxDecoration(
              border: Border.all(width: .25.h, color: Colors.grey.shade400),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: const Color.fromRGBO(26, 56, 72, 1)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 5.w,),
                if(messageController.messageList[index].users.length>2)
                  CircleAvatar(child: Icon(
                      Icons.people_outline_outlined,size: 5.h,
                  ),),
                if(messageController.messageList[index].users.length==2)
                  CircleAvatar(child: Icon(
                      Icons.person_outline ,size: 5.h,
                  ),),
                SizedBox(width: 5.w,),
                Text(
                  title,
                  style:  TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DM Sans"),
                ),
                SizedBox(width: 1.h,),
              ],
            ),
          ),
        ),
      );
    });
  }








}