import 'package:aqueduct/managed_auth.dart';
import 'package:car_drivers/car_drivers.dart';

class UserModel extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {}