import 'package:get_it/get_it.dart';

import 'data/providers/providers.dart';
import 'interface/utility/utility.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => InterfaceUtility());
  locator.registerLazySingleton(() => AssociatesProvider());
  locator.registerLazySingleton(() => CompanyProvider());
}
