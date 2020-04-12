


import '../../car_drivers.dart';

class CarModel extends ManagedObject<_Car> implements _Car {}

class _Car {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column(nullable: true)
  String photo;

}