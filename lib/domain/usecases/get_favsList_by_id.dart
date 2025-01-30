import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import '../repositories/favsList_repository.dart';

class GetFavslistById implements UseCase<FavslistEntity, String> {
  final FavsListRepository repository;

  GetFavslistById(this.repository);

  @override
  Future<Either<Failure, FavslistEntity>> call(String favsListId) {
    return repository.getFavsListById(favsListId);
  }
}
