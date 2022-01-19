import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/core/network/network_info.dart';
import 'package:sidq/core/remote_data_function/http_methods.dart';
import 'package:sidq/features/home/data/datasources/get_categroy_remote_data.dart';
import 'package:sidq/features/home/data/datasources/get_news_remote.dart';
import 'package:sidq/features/home/data/repositories/get_category_repository_imp.dart';
import 'package:sidq/features/home/data/repositories/get_news_repository_imp.dart';
import 'package:sidq/features/home/domain/repositories/get_category_repositroy.dart';
import 'package:sidq/features/home/domain/repositories/get_news_repository.dart';
import 'package:sidq/features/home/domain/usecases/get_category_use_case.dart';
import 'package:sidq/features/home/domain/usecases/get_news_use_case.dart';
import 'package:sidq/features/reverse_serach/data/datasources/upload_image_remote_data.dart';
import 'package:sidq/features/reverse_serach/data/repositories/upload_image_repository_imp.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/upload_image_repository.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';

import 'core/navigatuin_service/navigation.dart';
import 'features/home/presentation/bloc/home_page_bloc.dart';
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
  sl.registerFactory(
    () => NavigationBarBloc(sl(), sl()),
  );

  // Use cases
  sl.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCaseImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<GetCategroyUseCase>(
    () => GetCategoryUseCaseImp(
      sl(),
    ),
  );
  sl.registerLazySingleton<GetNewsUseCase>(
    () => GetNewsUseCaseImp(
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

  sl.registerLazySingleton<GetCategoryRepository>(
    () => GetCategoryRepositroyImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<GetNewsRepository>(
    () => GetNewsRepositoryImp(
      sl(),
      sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UploadImageRemoteData>(
    () => UploadImageRemoteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<GetCategoryRemoteData>(
    () => GetCategortyRemteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<GetNewsRemoteData>(
    () => GetMixedNewsRemoteDataImp(sl(), sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<NetworkFunctions>(
    () => NetworkFunctionsImp(),
  );
  sl.registerLazySingleton<NetworkInf>(
    () => NetworkInfImpl(),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton(() => NavigationService());
}
