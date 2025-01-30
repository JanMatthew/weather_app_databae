import 'package:weather_app/date/datasources/favsList_remote_datasource.dart';
import 'package:weather_app/domain/usecases/add_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/delete_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/get_favsList_by_id.dart';
import 'package:weather_app/domain/usecases/get_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/stream_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/update_favsList_use_case.dart';
import 'package:weather_app/presentation/blocs/favsLists/favsLists_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_database/firebase_database.dart';
import 'date/repositories/favsList_repository_impl.dart';
import 'domain/repositories/favsList_repository.dart';

final getIt = GetIt.instance;

void injectDependencies() {
  // Firebase Realtime Database
  getIt
      .registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);

  // Data Sources
  getIt.registerLazySingleton<FavslistRemoteDataSource>(
      () => FavsListRemoteDataSourceImpl(getIt<FirebaseDatabase>()));

  // Repositories
  getIt.registerLazySingleton<FavsListRepository>(
      () => FavslistRepositoryImpl(getIt<FavslistRemoteDataSource>()));

  // Use Cases
  getIt.registerLazySingleton(() => GetFavsLists(getIt<FavsListRepository>()));
  getIt.registerLazySingleton(() => AddFavsList(getIt<FavsListRepository>()));
  getIt.registerLazySingleton(() => UpdateFavsList(getIt<FavsListRepository>()));
  getIt.registerLazySingleton(() => DeleteFavsList(getIt<FavsListRepository>()));
  getIt.registerLazySingleton(() => GetFavsLists(getIt<FavsListRepository>()));
  getIt.registerLazySingleton(() => StreamFavsLists(getIt<FavsListRepository>()));

  // Bloc
  getIt.registerFactory(() => FavsListBloc(
        getFavsLists: getIt<GetFavsLists>(),
        addFavsList: getIt<AddFavsList>(),
        updateFavsList: getIt<UpdateFavsList>(),
        deleteFavsList: getIt<DeleteFavsList>(),
        getFavsListById: getIt<GetFavslistById>(),
        streamFavsLists: getIt<StreamFavsLists>(),
      ));
}