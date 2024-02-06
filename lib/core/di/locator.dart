import 'package:get_it/get_it.dart';
import 'package:mvvm_demo/core/services/http_delete_service.dart';
import 'package:mvvm_demo/core/services/http_get_service.dart';
import 'package:mvvm_demo/core/services/http_post_service.dart';
import 'package:mvvm_demo/core/services/http_update_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  //Repository
  locator.registerSingleton<HttpGetApiService>(HttpGetApiService());
  locator.registerSingleton<PostData>(PostData());
  locator.registerSingleton<DeleteApi>(DeleteApi());
  locator.registerSingleton<UpdateApi>(UpdateApi());
}
