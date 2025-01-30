import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/domain/entities/favsList.dart';

abstract class FavsListRepository {
  Future<Either<Failure, List<FavslistEntity>>> getFavsLists();

  Either<Failure, Stream<List<FavslistEntity>>> streamFavsLists();

  Future<Either<Failure, FavslistEntity>> getFavsListById(String favsListId);

  Future<Either<Failure, void>> addFavsList(FavslistEntity favsList);

  Future<Either<Failure, void>> updateFavsList(FavslistEntity favsList);

  Future<Either<Failure, void>> deleteFavsList(String favsListId);
}
