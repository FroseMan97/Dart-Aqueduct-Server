import 'package:aqueduct/managed_auth.dart';
import 'package:car_drivers/api/controllers/cars_controller.dart';
import 'package:car_drivers/api/controllers/drivers_controller.dart';
import 'package:car_drivers/api/controllers/random_controller.dart';
import 'package:car_drivers/data/datasource/car_datasource.dart';
import 'package:car_drivers/data/datasource/driver_datasource.dart';
import 'package:car_drivers/data/repository/car_repository_impl.dart';
import 'package:car_drivers/data/repository/driver_repository_impl.dart';
import 'package:car_drivers/domain/repository/car_repository.dart';
import 'package:car_drivers/domain/repository/driver_repository.dart';
import 'package:car_drivers/domain/usecase/collect_random_pair_usecase.dart';
import 'package:car_drivers/domain/usecase/create_car_usecase.dart';
import 'package:car_drivers/domain/usecase/create_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/delete_car_usecase.dart';
import 'package:car_drivers/domain/usecase/delete_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/get_car_usecase.dart';
import 'package:car_drivers/domain/usecase/get_cars_usecase.dart';
import 'package:car_drivers/domain/usecase/get_driver_usecase.dart';
import 'package:car_drivers/domain/usecase/get_drivers_usecase.dart';
import 'car_drivers.dart';
import 'api/controllers/register_controller.dart';
import 'data/models/user_model.dart';
import 'html_template.dart';

class AppChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  GetCarUsecase getCarUsecase;
  GetCarsUsecase getCarsUsecase;
  GetDriverUsecase getDriverUsecase;
  GetDriversUsecase getDriversUsecase;
  CreateCarUsecase createCarUsecase;
  CreateDriverUsecase createDriverUsecase;
  DeleteCarUsecase deleteCarUsecase;
  DeleteDriverUsecase deleteDriverUsecase;
  CollectRandomPairUsecase collectRandomPairUsecase;

  final HTMLRenderer htmlRenderer = HTMLRenderer();

  @override
  SecurityContext get securityContext {
    return SecurityContext()
      //..usePrivateKey("lib/certs/server_localhost.key", password: "1234")
      //..useCertificateChain("lib/certs/server_localhost.crt", password: "1234")
      ;
  }

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      "admin",
      "admin",
      "localhost",
      5432,
      "drivers",
    );

    context = ManagedContext(dataModel, persistentStore);

    final authStorage = ManagedAuthDelegate<UserModel>(context);
    authServer = AuthServer(authStorage);

    final CarDatasource carDatasource = CarDatasource(
      context,
    );
    final DriverDatasource driverDatasource = DriverDatasource(
      context,
    );
    final IDriverRepository driverRepository = DriverRepository(
      driverDatasource: driverDatasource,
    );
    final ICarRepository carRepository = CarRepository(
      carDatasource: carDatasource,
    );
    getCarUsecase = GetCarUsecase(
      carRepository,
    );
    getCarsUsecase = GetCarsUsecase(
      carRepository,
    );
    getDriverUsecase = GetDriverUsecase(
      driverRepository,
    );
    getDriversUsecase = GetDriversUsecase(
      driverRepository,
    );
    createCarUsecase = CreateCarUsecase(
      carRepository,
    );
    createDriverUsecase = CreateDriverUsecase(
      driverRepository,
    );
    deleteCarUsecase = DeleteCarUsecase(
      carRepository,
    );
    deleteDriverUsecase = DeleteDriverUsecase(
      driverRepository,
    );
    collectRandomPairUsecase = CollectRandomPairUsecase(
      carRepository,
      driverRepository,
    );
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route('/auth/token').link(
          () => AuthController(
            authServer,
          ),
        );

    router
        .route("/drivers/[:id]")
        //.link(() => Authorizer.bearer(authServer))
        .link(
          () => DriversController(
            getDriverUsecase,
            getDriversUsecase,
            deleteDriverUsecase,
            createDriverUsecase,
          ),
        );

    router
        .route('/cars/[:id]')
        //.link(() => Authorizer.bearer(authServer))
        .link(
          () => CarsController(
            createCarUsecase,
            deleteCarUsecase,
            getCarUsecase,
            getCarsUsecase,
          ),
        );

    router
        .route('/random')
        //.link(() => Authorizer.bearer(authServer))
        .link(
          () => RandomController(
            collectRandomPairUsecase,
          ),
        );

    router.route('/register').link(
          () => RegisterController(
            context,
            authServer,
          ),
        );

    return router;
  }

  @override
  Future<String> render(AuthRedirectController forController, Uri requestUri,
      String responseType, String clientID, String state, String scope) async {
    final map = {
      "response_type": responseType,
      "client_id": clientID,
      "state": state
    };
    map["path"] = requestUri.path;
    if (scope != null) {
      map["scope"] = scope;
    }

    return htmlRenderer.renderHTML("web/login.html", map);
  }
}
