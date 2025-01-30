import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/date/datasources/favsList_remote_datasource.dart';
import 'package:weather_app/date/models/favsList_model.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import 'package:weather_app/domain/repositories/favsList_repository.dart';

class FavslistRepositoryImpl implements FavsListRepository {
  final FavslistRemoteDataSource remoteDataSource;

  FavslistRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<FavslistEntity>>> getFavsLists() async {
    try {
      final favsListsModels = await remoteDataSource.getFavsLists();
      final FavslistEntity = favsListsModels.map((FavsListModel){
        return FavsListModel.toEntity();
      }).toList();
      return Right(FavslistEntity);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Either<Failure, Stream<List<FavslistEntity>>> streamFavsLists() {
    try {
      Stream<List<FavsListModel>> favsListModel = remoteDataSource.streamFavsList();
      Stream<List<FavslistEntity>> favslistEntity = favsListModel.map((favsListModelList) {
        return favsListModelList.map((favsListModel) => favsListModel.toEntity()).toList();
      });
      return Right(favslistEntity);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FavslistEntity>> getFavsListById(String favsListId) async {
    try {
      final favsList = await remoteDataSource.getFavsListsById(favsListId);
      if (favsList != null) return Right(favsList.toEntity());
      return Left(ServerFailure());
      } catch (_) {
        return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavsList(FavslistEntity favsList) async {
    try {
      await remoteDataSource.addFavsList(FavsListModel.fromEntity(favsList));
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateFavsList(FavslistEntity favsList) async {
    try {
      await remoteDataSource.updateFavsList(FavsListModel.fromEntity(favsList));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavsList(String favsListId) async {
    try {
      await remoteDataSource.deleteFavsList(favsListId);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}