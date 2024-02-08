import 'package:get_it/get_it.dart';
import 'package:mvvm_demo/core/repos/services.dart';
import 'package:mvvm_demo/core/viewmodels/user_details_view_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  //Repository
  locator.registerLazySingleton(() => ApiServices());
  locator.registerLazySingleton(() => UserDetailsViewModel());
}
