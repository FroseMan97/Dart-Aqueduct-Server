import 'package:car_drivers/data/models/driver_model.dart';
import 'package:car_drivers/domain/entity/driver_entity.dart';

class DriverMapper {
  static List<DriverEntity> mapModelsToEntities(List<DriverModel> models) {
    return models
        .map(mapModelToEntity)
        .toList();
  }

  static List<DriverModel> mapEntitiesToModels(List<DriverEntity> entities) {
    return entities.map(mapEntityToModel).toList();
  }

  static DriverEntity mapModelToEntity(DriverModel model) {
    return DriverEntity(
      id: model.id,
      name: model.name,
      avatar: model.avatar,
    );
  }

  static DriverModel mapEntityToModel(DriverEntity entity) {
    return DriverModel()
        ..name = entity.name
        ..id = entity.id
        ..avatar = entity.avatar;
  }
}