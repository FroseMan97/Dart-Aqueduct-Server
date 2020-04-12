import 'package:car_drivers/car_drivers.dart';

class AddDriverModel extends Serializable {

  String name;
  String avatar;

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name,
      "avatar": avatar,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    avatar = object['avatar'] as String;
  }
  
}