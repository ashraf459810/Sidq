// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradpool/Core/network/network_info.dart';
// import 'package:tradpool/features/add_auction/data/datasources/add_item_remote_data.dart';
// import 'package:tradpool/features/add_auction/data/repositories/add_item_repositroyimp.dart';
// import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';
// import 'package:tradpool/features/add_auction/domain/usecases/add_auction_use_case.dart';
// import 'package:tradpool/features/add_auction/domain/usecases/get_brands_for_sub_use_case.dart';
// import 'package:tradpool/features/add_auction/domain/usecases/get_main_category_use_case.dart';
// import 'package:tradpool/features/add_auction/domain/usecases/get_sub_categories_use_case.dart';
// import 'package:tradpool/features/add_auction/domain/usecases/upload_file_use_case.dart';
// import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
// import 'package:tradpool/features/auction_details/data/data_source/add_bid_remote_data.dart';
// import 'package:tradpool/features/auction_details/data/data_source/get_auction_details_remote_data.dart';
// import 'package:tradpool/features/auction_details/data/data_source/get_step_remote_data.dart';
// import 'package:tradpool/features/auction_details/data/repository/add_bid_repository_imp.dart';
// import 'package:tradpool/features/auction_details/data/repository/get_step_repository_imp.dart';
// import 'package:tradpool/features/auction_details/domain/repository/add_bid_repositroy.dart';
// import 'package:tradpool/features/auction_details/domain/repository/get_auctions_repository.dart';
// import 'package:tradpool/features/auction_details/domain/repository/get_step_repository.dart';
// import 'package:tradpool/features/auction_details/domain/use_case/add_bid_use_case.dart';
// import 'package:tradpool/features/auction_details/domain/use_case/auction_details_use_case.dart';
// import 'package:tradpool/features/auction_details/domain/use_case/get_step_use_case.dart';
// import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';
// import 'package:tradpool/features/home/data/remote_data_source/remote_data_source.dart';
// import 'package:tradpool/features/home/data/repository/all_auctions_repository.dart';
// import 'package:tradpool/features/home/domain/repository/all_auctions_repository.dart';
// import 'package:tradpool/features/home/domain/use_case/all_auctions_use_case.dart';
// import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';

// import 'package:tradpool/features/login/data/datasources/login_remote_data.dart';
// import 'package:tradpool/features/login/data/repositories/login_repositroy_imp.dart';
// import 'package:tradpool/features/login/domain/repositories/login_repository.dart';
// import 'package:tradpool/features/login/domain/usecases/login_use_case.dart';
// import 'package:tradpool/features/login/presentation/bloc/log_in_bloc.dart';

// import 'package:tradpool/features/register/data/datasources/register_remote_data.dart';
// import 'package:tradpool/features/register/data/repositories/register_repositoryimp.dart';
// import 'package:tradpool/features/register/domain/repositories/register_repository.dart';
// import 'package:tradpool/features/register/domain/usecases/register_use_case.dart';
// import 'package:tradpool/features/register/presentation/bloc/register_bloc.dart';
// import 'package:tradpool/features/sell/data/datasources/get_auctions_remote_data.dart';
// import 'package:tradpool/features/sell/data/repositories/user_auction_repository_imp.dart';
// import 'package:tradpool/features/sell/domain/repositories/user_auctions_repositroy.dart';
// import 'package:tradpool/features/sell/domain/usecases/user_auctions_use_case.dart';
// import 'package:tradpool/features/sell/presentation/bloc/sell_bloc.dart';
// import 'package:tradpool/features/verfication/data/datasources/verfication_local_data.dart';
// import 'package:tradpool/features/verfication/data/datasources/verfication_remote_data.dart';
// import 'package:tradpool/features/verfication/data/repositories/verfication_repository_impl.dart';
// import 'package:tradpool/features/verfication/domain/repositories/verfication_repository.dart';
// import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';
// import 'package:tradpool/features/verfication/domain/usecases/verfication_use_case.dart';
// import 'package:tradpool/features/verfication/presentation/bloc/verfication_bloc.dart';

// import 'features/auction_details/data/repository/auction_details_repository_imp.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   //! Features
//   // Bloc
//   sl.registerFactory(
//     () => RegisterBloc(
//       sl(),
//     ),
//   );

//   sl.registerFactory(
//     () => SellBloc(
//       sl(),
//     ),
//   );

//   sl.registerFactory(
//     () => LogInBloc(
//       sl(),
//     ),
//   );
//   sl.registerFactory(
//     () => HomeBloc(
//       sl(),
//     ),
//   );

//   sl.registerFactory(
//     () => VerficationBloc(sl(), sl()),
//   );

//   sl.registerFactory(
//     () => AddItemBloc(sl(), sl(), sl(), sl(), sl()),
//   );

//   sl.registerFactory(
//     () => AuctionDetailsBloc(sl(), sl(), sl()),
//   );

//   // Use cases
//   sl.registerLazySingleton<GetStepUseCase>(
//     () => GetStepUseCaseImp(
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<AuctionDetailsUseCase>(
//     () => AuctionDetailsUseCaseImp(
//       sl(),
//     ),
//   );
//   sl.registerLazySingleton<AddBidUseCase>(
//     () => AddBidUseCaseImp(
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton(() => AllAuctionsUseCase(sl()));
//   sl.registerLazySingleton(() => SaveToken(sl()));
//   sl.registerLazySingleton(() => GetToken(sl()));
//   sl.registerLazySingleton(() => SetIsVerify(sl()));
//   sl.registerLazySingleton(() => GetIsVerify(sl()));
//   sl.registerLazySingleton(() => UserAuctionsUseCase(sl()));
//   sl.registerLazySingleton(() => UploadFileUseCase(sl()));
//   sl.registerLazySingleton(() => GetMainCategoriesUseCase(sl()));
//   sl.registerLazySingleton(() => BrandsForSubCategoryUseCase(sl()));
//   sl.registerLazySingleton(() => GetSubCategoriesUseCase(sl()));
//   sl.registerLazySingleton(() => AddAuctionUseCase(sl()));
//   sl.registerLazySingleton(() => RegisterUseCase(sl()));

//   sl.registerLazySingleton(() => LoginUseCase(sl()));

//   sl.registerLazySingleton(() => VerficationUseCase(sl()));

//   // Repository

//   sl.registerLazySingleton<GetStepRepository>(
//     () => GetStepRepositoryImp(
//       sl(),
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<GetAuctionDetailsRspository>(
//     () => AuctionDetailsImp(
//       sl(),
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<AddBidRepository>(
//     () => AddBidRespositoryImp(
//       sl(),
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<AddItemRepository>(
//     () => AddItemRepositoryImp(
//       sl(),
//       sl(),
//     ),
//   );
//   sl.registerLazySingleton<AllAuctionsRepository>(
//     () => AllAuctionsRespositoryImp(
//       sl(),
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<UserAuctionsRepository>(
//     () => UserAuctionsRepositoryImp(
//       sl(),
//       sl(),
//     ),
//   );

//   sl.registerLazySingleton<RegisterRepository>(
//     () => RegisterRepositoryImpl(
//       sl(),
//       sl(),
//     ),
//   );
//   sl.registerLazySingleton<VerficationRepository>(
//     () => VerficationRepositoryImp(sl(), sl(), sl()),
//   );

//   sl.registerLazySingleton<LoginRepository>(
//     () => LoginRepositoryImp(
//       sl(),
//       sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<GetStepRemoteData>(
//     () => GetStepRemoteDataImpl(sl(), sl()),
//   );

//   sl.registerLazySingleton<GetAuctionDetailsRemoteData>(
//     () => GetAuctionRemoteDataImp(sl(), sl()),
//   );

//   sl.registerLazySingleton<AddBidRemoteDate>(
//     () => AddBidRemoteDataImp(sl(), sl()),
//   );

//   sl.registerLazySingleton<UserAuctionsRemoteData>(
//     () => UserAuctionsRmoteDataImpl(sl(), sl()),
//   );
//   sl.registerLazySingleton<AllAuctionsRemoteData>(
//     () => AllAuctionsRemoteDataImp(sl(), sl()),
//   );
//   sl.registerLazySingleton<AddItemRemoteData>(
//     () => AddItemRemoteDataImp(sl()),
//   );
//   sl.registerLazySingleton<RegisterRemoteData>(
//     () => RegisterRemoteDateImpl(sl()),
//   );
//   sl.registerLazySingleton<VerficationLocatData>(
//     () => VerficationLocalDataImpl(sl()),
//   );
//   sl.registerLazySingleton<VerficationRemoteDate>(
//     () => VerficationRemoteDataImpl(
//       sl(),
//     ),
//   );
//   sl.registerLazySingleton<LoginRemoteDate>(
//     () => LoginRemoteDateImp(sl()),
//   );
//   //! Core
//   sl.registerLazySingleton<NetworkInf>(() => NetworkInfImpl(sl()));

//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => DataConnectionChecker());
// }
