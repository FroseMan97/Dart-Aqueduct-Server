import 'dart:math';
import 'package:car_drivers/data/models/driver_model.dart';
import 'package:car_drivers/domain/models/add_driver_model.dart';
import 'package:meta/meta.dart';

import '../../car_drivers.dart';

class DriverDatasource {

  final ManagedContext context;

  DriverDatasource(this.context);

  Future<List<DriverModel>> getAllDrivers({String name}) async {
    final driverQuery = Query<DriverModel>(context);
    if (name != null) {
      driverQuery.where((h) => h.name).contains(name, caseSensitive: false);
    }
    final drivers = await driverQuery.fetch();
    return drivers;
  }

  Future<DriverModel> getDriver({
    @required int id,
  }) async {
    final driverQuery = Query<DriverModel>(context)
      ..where((h) => h.id).equalTo(id);

    final driver = await driverQuery.fetchOne();

    return driver;
  }

  // TODO add driver model dto
  Future<DriverModel> addDriver(AddDriverModel request) async {
    final addModel = DriverModel();
    addModel.name = request.name;
    addModel.avatar = request.avatar;
    final query = Query<DriverModel>(context)..values = addModel;
    final insertedDriver = await query.insert();

    return insertedDriver;
  }

  // TODO add driver model dto
  Future<int> deleteDriver(int id) async {

    final query = Query<DriverModel>(context)
    ..where((item) => item.id).equalTo(id);
    final deletedID = await query.delete();

    return deletedID;
  }

  Future<DriverModel> getRandomDriver() async {

    final driverQuery = Query<DriverModel>(context);
    final driverList = await driverQuery.fetch();
    final randomDriver = driverList == null || driverList.isEmpty
      ? null
      : driverList[Random().nextInt(driverList.length)];
    return randomDriver;
  }
}