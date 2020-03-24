import 'package:aqueduct/managed_auth.dart';
import 'package:car_drivers/controllers/cars_controller.dart';
import 'package:car_drivers/controllers/random_controller.dart';
import 'car_drivers.dart';
import 'controllers/car_drivers_controller.dart';
import 'controllers/register_controller.dart';
import 'html_template.dart';
import 'models/user_model.dart';

class AppChannel extends ApplicationChannel
    implements AuthRedirectControllerDelegate {
  ManagedContext context;
  AuthServer authServer;
  final HTMLRenderer htmlRenderer = HTMLRenderer();

  @override
  SecurityContext get securityContext {
    return SecurityContext()
      ..usePrivateKey("lib/certs/server_localhost.key", password: "1234")
      ..useCertificateChain("lib/certs/server_localhost.crt", password: "1234");
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

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route('/auth/token')
        .link(() => AuthController(authServer));

    router
        .route("/auth/code")
        .link(() => AuthRedirectController(authServer, delegate: this));

    router
        .route("/drivers/[:id]")
        //.link(() => Authorizer.bearer(authServer))
        .link(() => CarDriversController(context));
    
    router
        .route('/cars/[:id]')
        //.link(() => Authorizer.bearer(authServer))
        .link(() => CarsController(context));
    
    router
        .route('/random')
        //.link(() => Authorizer.bearer(authServer))
        .link(() => RandomController(context));

    router
        .route('/register')
        .link(() => RegisterController(context, authServer));

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
