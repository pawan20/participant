import 'package:get_it/get_it.dart';
import 'package:participant/services/auth_service.dart';
import 'package:participant/services/participant_data_source_service.dart';

GetIt locator = GetIt.I;

Future<void> setupLocator() async {
  GetIt.I.registerLazySingleton(
    () => ParticipantDataSourceService(),
  );

  GetIt.I.registerLazySingleton(
    () => AuthService(),
  );

  return GetIt.I.allReady();
}
