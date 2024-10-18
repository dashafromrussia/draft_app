import 'package:injectable/injectable.dart';
import 'package:untitled/api_data/api_data.dart';


@LazySingleton(as:ApiData,env:['user'])
class UserApiData implements ApiData{
  @override
  String get baseUrl => "users";

}