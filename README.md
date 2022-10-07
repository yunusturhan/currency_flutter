# currency_flutter

Bu proje Dijital Sahne stajyer eğitimimde yapılmıştır.<br> 
Proje içerisinde güncel kur fiyatları , altın ve gümüş fiyatları listelenmektedir. Bunların güncel kur üzerinden sepete eklenmesi ve daha sonrasında firebase kaydedilmesiyle geçmişteki fiyatlarla şimdiki fiyatlar arasında karşılaştırmalar yapılabilmektedir.<br> 
API servisleri https://collectapi.com tarafından sağlanmıştır.(Belli bir kullanımı ücretsizdir.)<br> 
State Yönetimi GetX ile yapılmıştır.<br> 
Verilerin saklanması local olarak hive , online olarak da firebase kullanılarak yapılmıştır.<br> 
Prejede multi-language özelliği mevcuttur. Türkçe ve İngilizce olarak kullanıma hazırdır.<br> 
<br> 
<br> 

Projede kullanılan bazı paketler;<br> 
animated_bottom_navigation_bar: Animasyonlu navigation bar yapımında kullanıldı. https://pub.dev/packages/animated_bottom_navigation_bar<br> 
font_awesome_flutter: Çeşitli ikonlar için kullanıldı. https://pub.dev/packages/font_awesome_flutter<br> 
shimmer: Yazıya efektif vermek için kullanıldı. https://pub.dev/packages/shimmer<br> 
floating_action_buble: Floating action buttonun açılır menü haline getirilmesinde kullanıldı. https://pub.dev/packages/floating_action_bubble<br> 
fluttertoast: Uyarı gösterimi için kullanıldı. https://pub.dev/packages/fluttertoast<br> 
hive: Localde veri tutmak için kullanıldı. NOT: Bunun yanında generator de eklemelisiniz. https://pub.dev/packages/hive<br> 
pie_chart: Eklenen birimlerin grafikle gösterilmesinde kullanıldı. https://pub.dev/packages/pie_chart<br> 
