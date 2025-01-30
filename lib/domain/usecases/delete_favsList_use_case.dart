import 'package:dartz/dartz.dart';
import 'package:weather_app/core/failure.dart';
import 'package:weather_app/core/usecase.dart';
import '../repositories/favsList_repository.dart';

class DeleteFavsList implements UseCase<void, String> {
  final FavsListRepository repository;

  DeleteFavsList(this.repository);

  @override
  Future<Either<Failure, void>> call(String favsListId) {
    return repository.deleteFavsList(favsListId);
  }
}
