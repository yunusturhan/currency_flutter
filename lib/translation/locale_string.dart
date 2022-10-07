import 'package:get/get.dart';
import 'en_worlds.dart';
import 'tr_worlds.dart';

class LocaleString extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>{
    'en_US': LocaleEN().localeEn,
    'tr_TR': LocaleTR().localeTr,
  };

}