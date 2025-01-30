import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import '../repositories/favsList_repository.dart';

class StreamFavsLists {
  final FavsListRepository repository;

  StreamFavsLists(this.repository);

  Either<Failure, Stream<List<FavslistEntity>>> call(NoParams params) {
    return repository.streamFavsLists();
  }
}
