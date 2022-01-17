import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/reverse_serach/data/datasources/upload_image_remote_data.dart';
import 'package:sidq/features/reverse_serach/data/repositories/upload_image_repository_imp.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/upload_image_repository.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';

import 'features/reverse_serach/presentation/bloc/reverse_serach_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(
    () => ReverseSerachBloc(
      sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCaseImp(
      sl(),
    ),
  );

  // Repository

  sl.registerLazySingleton<UploadImageRepostiry>(
    () => UploadImageRepositoryImp(
      sl(),
      sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UploadImageRemoteData>(
    () => UploadImageRemoteDataImp(sl(), sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<NetworkFunctions>(
    () => NetworkFunctionsImp(),
  );
  sl.registerLazySingleton(() => DataConnectionChecker());
}
