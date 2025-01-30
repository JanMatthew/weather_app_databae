import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import '../repositories/favsList_repository.dart';

class UpdateFavsList implements UseCase<void, FavslistEntity> {
  final FavsListRepository repository;

  UpdateFavsList(this.repository);

  @override
  Future<Either<Failure, void>> call(FavslistEntity favsList) {
    return repository.updateFavsList(favsList);
  }
}