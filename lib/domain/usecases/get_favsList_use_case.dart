import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import '../repositories/favsList_repository.dart';

class GetFavsLists implements UseCase<List<FavslistEntity>, NoParams> {
  final FavsListRepository repository;

  GetFavsLists(this.repository);

  @override
  Future<Either<Failure, List<FavslistEntity>>> call(NoParams params) {
    return repository.getFavsLists();
  }
}