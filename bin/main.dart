import 'package:car_drivers/car_drivers.dart';
import 'package:car_drivers/channel.dart';

Future main() async {
  final app = Application<AppChannel>()
      ..options.configurationFilePath = "config.yaml"
      ..options.address = '172.20.10.3'
      //..options.address = '192.168.137.243'
      ..options.port = 8080;

  final count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}