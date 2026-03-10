
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_store/app_store.dart';
import 'core/data/local_data/local_data_source.dart';
import 'core/data/new_remote/network_service.dart';

final getIt = GetIt.instance;

Future<void> configureInjection() async {
  /// data sources
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final AppStore appStore = AppStore();

  ///core
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<AppStore>(() => appStore);
  getIt.registerLazySingleton<NetworkService>(() => DioNetworkService());
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceSharedPreferences(getIt()));

}
