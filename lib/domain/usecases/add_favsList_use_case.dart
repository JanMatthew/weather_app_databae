import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import '../repositories/favsList_repository.dart';

class AddFavsList implements UseCase<void, FavslistEntity> {
  final FavsListRepository repository;

  AddFavsList(this.repository);

  @override
  Future<Either<Failure, void>> call(FavslistEntity favsList) {
    return repository.addFavsList(favsList);
  }
}
