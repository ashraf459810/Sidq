import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidq/App/bloc/app_bloc.dart';
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
import 'package:sidq/features/news_details/data/datasources/add_comment.dart';
import 'package:sidq/features/news_details/data/datasources/news_details_remote_data.dart';
import 'package:sidq/features/news_details/data/repositories/add_comment_repository.dart';
import 'package:sidq/features/news_details/data/repositories/news_details_repository_imp.dart';
import 'package:sidq/features/news_details/domain/repositories/add_comment_repository.dart';
import 'package:sidq/features/news_details/domain/repositories/news_details_repositroy.dart';
import 'package:sidq/features/news_details/domain/usecases/add_comment_use_case.dart';
import 'package:sidq/features/news_details/domain/usecases/news_details_use_case.dart';
import 'package:sidq/features/news_details/presentation/bloc/news_details_bloc.dart';
import 'package:sidq/features/report_fake_news/data/remote_data/add_ticket.dart';
import 'package:sidq/features/news_details/data/datasources/add_vote.dart';
import 'package:sidq/features/report_fake_news/data/repositroy/add_ticket_repository.dart';
import 'package:sidq/features/news_details/data/repositories/add_vote_repositroy.dart';
import 'package:sidq/features/report_fake_news/domain/repository/add_ticket_repository.dart';
import 'package:sidq/features/news_details/domain/repositories/add_vote_repository.dart';
import 'package:sidq/features/report_fake_news/domain/use_case/add_ticket_use_case.dart';
import 'package:sidq/features/news_details/domain/usecases/add_vote_use_case.dart';
import 'package:sidq/features/reverse_serach/data/datasources/upload_image_remote_data.dart';
import 'package:sidq/features/reverse_serach/data/repositories/upload_image_repository_imp.dart';
import 'package:sidq/features/reverse_serach/domain/repositories/upload_image_repository.dart';
import 'package:sidq/features/reverse_serach/domain/usecases/upload_image_use_case.dart';

import 'core/navigatuin_service/navigation.dart';
import 'features/home/presentation/bloc/home_page_bloc.dart';
import 'features/report_fake_news/presentation/bloc/report_fake_news_bloc.dart';
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
    () => ReportFakeNewsBloc(
      sl(),
 
    ),
  );


sl.registerFactory(
    () => AppBloc(

    ),
  );

    sl.registerFactory(
    () => NewsDetailsBloc(
      sl(),sl(),sl()
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

  sl.registerLazySingleton<AddCommentUseCase>(
    () => AddCommentUseCaseImp(
      sl(),
    ),
  );
  
   sl.registerLazySingleton<AddVoteUseCase>(
    () => AddVoteUseCaseImp(
      sl(),
    ),
  );
   sl.registerLazySingleton<AddTicketUseCase>(
    () => AddTicketUseCaseImp(
      sl(),
    ),
  );
sl.registerLazySingleton<NewsDetailsUseCase>(
    () => NewsDetailsUseCaseImp(
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

  sl.registerLazySingleton<AddCommentRepository>(
    () => AddCommentRepositoryImp(
      sl(),
      sl(),
    ),
  );
   sl.registerLazySingleton<AddVoteRepository>(
    () => AddVoteRepositoryImp(
      sl(),
      sl(),
    ),
  );


  sl.registerLazySingleton<AddTicketRepository>(
    () => AddTicketRepositoryImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<NewsDetailsRepository>(
    () => NewsDetailsRepositoryImp(
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

   sl.registerLazySingleton<AddCommentRemoteData>(
    () => AddCommentRemoteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<AddVoteRemoteData>(
    () => AddVoteRemoteDataImp(sl(), sl()),
  );


   sl.registerLazySingleton<AddTicketRemoteData>(
    () => AddTicketRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<NewsDetailsRemoteData>(
    () => NewsDetaulsRemoteDataImp(sl(), sl()),
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
