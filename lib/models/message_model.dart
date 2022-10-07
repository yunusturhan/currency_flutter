import 'package:cloud_firestore/cloud_firestore.dart';
class Message{
  String doc_id;
  List users;
  String title;

  Message(this.doc_id,this.title,this.users,);
}