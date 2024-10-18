import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/yandex_map/presentation/bloc/data_bloc.dart';
import 'package:untitled/yandex_map/presentation/pages/dialogs/warning_dialog.dart';
import 'package:untitled/yandex_map/presentation/pages/order_page.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';


@Singleton(env:['user'])
class YandexCoderRepository {
   YandexCoderRepository(){
    print("CREATE YandexCoderRepository");
  }
 static final YandexGeocoder geo = YandexGeocoder(
      apiKey: "dedda165-4ebd-416a-aac5-453233375976");

  Future<String> getAddressByMyGeo(double lat, double lon,
      BuildContext context) async {
    final GeocodeResponse _address = await geo.getGeocode(
      ReverseGeocodeRequest(
        pointGeocode: (lat:lat, lon: lon),
      ),
    );
    print("first name::");
    final String address = _address.firstAddress!.formatted!;
    print(_address.firstAddress!.components!.first.name=="Россия");
    if(_address.firstAddress!.components!.first.name=="Россия"){
      WarningMyPosDialog.showDialog(context, title: "title", text: address);
    }else{
      WarningDialog.showDialog(context, title: "title",
          text:"Доставка в Ваш регион не доступна.Выключите впн или введите свой адрес вручную в поле поиска");
    }
    if (!context.mounted) {
      return '';
    }
    //  showMod(_address.firstAddress!.formatted!,context);
    print("/////////////////||||||||||???????????");
    print(_address.firstAddress?.formatted);
    return '';
  }

  Future<String> getAddressInfo(double lat, double lon,
      BuildContext context) async {
    final GeocodeResponse _address = await geo.getGeocode(
      ReverseGeocodeRequest(
        pointGeocode: (lat:lat, lon: lon),
      ),
    );
    print(_address.firstAddress!.components!.first.name);
    if (!context.mounted) return '';
    WarningDialog.showDialog(context, title: "title", text:_address.firstAddress!.formatted!);
    //  showMod(_address.firstAddress!.formatted!,context);
    print("/////////////////||||||||||???????????");
    print(_address.firstAddress?.formatted);
    return '';
  }

}






