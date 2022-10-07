import 'package:cloud_firestore/cloud_firestore.dart';

class BasketHistory {
  String email;
  String type;
  double unit_price;
  double piece;
  Timestamp time;

  BasketHistory(
    this.email,
    this.type,
    this.unit_price,
    this.piece,
    this.time
  );

}
