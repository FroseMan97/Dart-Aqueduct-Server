import 'dart:math';

import 'package:car_drivers/car_drivers.dart';
import 'package:car_drivers/data/models/car_model.dart';
import 'package:car_drivers/domain/models/add_car_model.dart';
import 'package:meta/meta.dart';

class CarDatasource {
  final ManagedContext context;

  CarDatasource(this.context);

  Future<List<CarModel>> getAllCars({String name}) async {
    final carQuery = Query<CarModel>(context);
    if (name != null) {
      carQuery.where((h) => h.name).contains(name, caseSensitive: false);
    }
    final cars = await carQuery.fetch();

    return cars;
  }

  /// Получить авто по его id
  @Operation.get('id')
  Future<CarModel> getCar({
    @required int id,
  }) async {
    final carQuery = Query<CarModel>(context)..where((h) => h.id).equalTo(id);

    final car = await carQuery.fetchOne();

    return car;
  }

  // TODO create model dto
  Future<CarModel> addCar(AddCarModel request) async {

    final addModel = CarModel();
    addModel.name = request.name;
    addModel.photo = request.photo;
    final query = Query<CarModel>(context)..values = addModel;
    final insertedCar = await query.insert();

    return insertedCar;
  }

  // TODO create delete model dto
  Future<int> deleteCar(int id) async {
    final query = Query<CarModel>(context)
      ..where((item) => item.id).equalTo(id);

    final deletedID = await query.delete();

    return deletedID;
  }

  Future<CarModel> getRandomCar() async {
    final carQuery = Query<CarModel>(context);
    final carList = await carQuery.fetch();
    final randomCar = carList == null || carList.isEmpty
      ? null
      : carList[Random().nextInt(carList.length)];
    return randomCar;
  }
}
