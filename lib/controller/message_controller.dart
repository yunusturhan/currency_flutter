import 'package:biletinial_doviz/models/message_model.dart';
import 'package:biletinial_doviz/pages/message_pages/message_detail_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_controller.dart';
import '../models/message_detail_model.dart';
import 'firebase_save_controller.dart';

class MessageController extends GetxController{
  AuthController controllerAuth = Get.put(AuthController());
  RxList<Message> messageList = <Message>[].obs;
  RxList<MessageDetail> messageDetailList=<MessageDetail>[].obs;
  RxString groupName="".obs;
  final ScrollController controller = ScrollController();
  String? doc;
  int? usersLenght;
  String? title;
  RxList groupList=[].obs;
  RxList personList=[].obs;
  FirebaseSaveController controllerFirebase = Get.put(FirebaseSaveController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  init()async{
   await getMessageList();

  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getMessageList() async {
    messageList.clear();
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Message')
          .where('users',arrayContains: controllerAuth.firebaseUser.value!.email)
          .get();

      for(var data in snapshot.docs){
        messageList.add(Message(data["doc_id"],data["title"], data["users"]));
      }
      print(messageList.length);
    }catch(e){
      print(e.toString());
    }
  }


  Future<void> getMessageDetailList(String doc) async {
    messageDetailList.clear();
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Message').doc(doc).collection('MessageDetail')
          .orderBy('time',descending: false)
          .get();

      for(var data in snapshot.docs){
        messageDetailList.add(MessageDetail(data["content"], data["sender"], data["time"],data["readers"]));
      }
      print(messageDetailList.length);
    }catch(e){
      print(e.toString());
    }
  }


  Future<MessageDetail> MessageDetailAdd(String content, String? sender, List readers,String doc)async{
    var ref=FirebaseFirestore.instance.collection('Message')
        .doc(doc)
        .collection('MessageDetail');
    await ref.add({'content':content,'sender':sender,'time':DateTime.now(),'readers':readers});
    //for(var data in ref.docs)
    update();

    return MessageDetail(content, sender!, Timestamp.fromDate(DateTime.now()), readers);
  }


  void scrollDown() {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  Future<void> MessageReaderAdd()async {

    var ref=FirebaseFirestore.instance.collection('Message').doc(doc).collection('MessageDetail');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Message')
        .doc(doc)
        .collection('MessageDetail')
        .get();
    snapshot.docs.forEach((element) {
      ref.doc(element.id).update({'readers':FieldValue.arrayUnion(["${controllerAuth.firebaseUser.value!.email}"])});
    });
   // await ref.doc().update({'readers':FieldValue.arrayUnion(["${controllerAuth.firebaseUser.value!.email}"])});

  }
  
  Future<void> SingleMessageCreateControl(String sendMail,String name)async{
    var ref=FirebaseFirestore.instance.collection('Message').doc(doc).collection('MessageDetail');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Message')
        .where('users',isEqualTo: [controllerAuth.firebaseUser.value!.email,sendMail])
        .get();
    print(snapshot.docs.length);
    if(snapshot.docs.length==1){
      for (var element in snapshot.docs) {
        await MessageReaderAdd();

        await getMessageDetailList(element.id);
        doc =  element.id;
        title = name;
        await Get.toNamed( '/messageDetail');
        await getMessageList();
      }
    }
    else{
      var messageRef=FirebaseFirestore.instance.collection('Message');
      DocumentReference documentRef=await messageRef.add({});
      String doc_id=documentRef.id;
      await messageRef.doc(doc_id).set({'doc_id':doc_id,'title':"",'users':[sendMail,controllerAuth.firebaseUser.value!.email]});
      await MessageDetailAdd("", "", [],doc_id);
      snapshot =await FirebaseFirestore.instance.collection('Message').doc(doc_id).collection('MessageDetail').get();
      for(var docs in snapshot.docs){
        await docs.reference.delete();
      }
      await getMessageDetailList(doc_id);
      doc =  doc_id;
      title = name;
      await Get.toNamed( '/messageDetail');
      await getMessageList();
    }

  }

  Future<void> GroupMessageCreate(String groupName)async{
    var messageRef=FirebaseFirestore.instance.collection('Message');
    DocumentReference documentRef=await messageRef.add({});
    String doc_id=documentRef.id;
    groupList.add(controllerAuth.firebaseUser.value!.email);
    await messageRef.doc(doc_id).set({'doc_id':doc_id,'title':groupName,'users':groupList});
    await MessageDetailAdd("", "", [],doc_id);
    var snapshot =await FirebaseFirestore.instance.collection('Message').doc(doc_id).collection('MessageDetail').get();
    for(var docs in snapshot.docs){
      await docs.reference.delete();
    }
    await getMessageDetailList(doc_id);
    doc =  doc_id;
    title = groupName;
    await Get.toNamed( '/messageDetail');
    await getMessageList();

  }
  
}
