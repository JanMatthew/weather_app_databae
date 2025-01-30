import 'package:weather_app/domain/entities/favsList.dart';

abstract class FavsListEvent {}

/// Evento para cargar todas las listas de favoritos desde la base de datos.
class LoadFavsListsEvent extends FavsListEvent {}

class StreamFavsListsEvent extends FavsListEvent {}

/// Evento para agregar una nueva lista de favoritos.
class AddFavsListEvent extends FavsListEvent {
  final FavslistEntity favsList;

  AddFavsListEvent(this.favsList);
}

/// Evento para actualizar una lista de favoritos existente.
class UpdateFavsListEvent extends FavsListEvent {
  final FavslistEntity favsList;

  UpdateFavsListEvent(this.favsList);
}

/// Evento para eliminar una lista de favoritos por su ID.
class DeleteFavsListEvent extends FavsListEvent {
  final String favsListId;

  DeleteFavsListEvent(this.favsListId);
}

/// Evento para obtener una lista de favoritos por su ID.
class GetFavsListByIdEvent extends FavsListEvent {
  final String favsListId;

  GetFavsListByIdEvent(this.favsListId);
}