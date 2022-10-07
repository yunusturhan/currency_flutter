import 'package:hive/hive.dart';
part 'basket_model.g.dart';

@HiveType(typeId: 0)
class Basket extends HiveObject{
  Basket({required this.type,required this.unit_price,required this.piece});
  @HiveField(0)
  String type;
  @HiveField(1)
  double unit_price;
  @HiveField(2)
  double piece;
}