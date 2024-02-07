import 'package:get_it/get_it.dart';
import 'package:mvvm_demo/core/services/services.dart';

final locator = GetIt.instance;

void setupLocator() {
  //Repository
  locator.registerLazySingleton(() => ApiServices());
}
