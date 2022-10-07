import 'package:hive/hive.dart';
part 'language.g.dart';

@HiveType(typeId: 1)
class Language extends HiveObject{
  Language({required this.name,required this.code,required this.country});
  @HiveField(0)
  String name;
  @HiveField(1)
  String code;
  @HiveField(2)
  String country;
}