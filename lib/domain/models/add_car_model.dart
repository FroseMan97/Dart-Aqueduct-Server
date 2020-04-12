import 'package:car_drivers/car_drivers.dart';

class AddCarModel extends Serializable {

  String name;
  String photo;

  @override
  Map<String, dynamic> asMap() {
    return {
      "name": name,
      "photo": photo,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    name = object['name'] as String;
    photo = object['photo'] as String;
  }
  
}