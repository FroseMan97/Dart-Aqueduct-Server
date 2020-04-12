import '../car_drivers.dart';

class DriverDBModel extends ManagedObject<_CarDriver> implements _CarDriver {

}

class _CarDriver {
  @primaryKey
  int id;

  @Column()
  String name;

  @Column(nullable: true)
  String avatar;
}