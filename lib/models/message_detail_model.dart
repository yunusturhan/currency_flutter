import 'package:cloud_firestore/cloud_firestore.dart';
class MessageDetail{
  String content;
  String sender;
  Timestamp time;
  List readers;

MessageDetail(this.content,this.sender,this.time,this.readers);

}