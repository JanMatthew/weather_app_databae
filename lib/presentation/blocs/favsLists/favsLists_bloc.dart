import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/usecase.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import 'package:weather_app/domain/usecases/add_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/delete_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/get_favsList_by_id.dart';
import 'package:weather_app/domain/usecases/get_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/stream_favsList_use_case.dart';
import 'package:weather_app/domain/usecases/update_favsList_use_case.dart';
import 'package:weather_app/presentation/blocs/favsLists/favsLists_event.dart';
import 'package:weather_app/presentation/blocs/favsLists/favsLists_state.dart';

class FavsListBloc extends Bloc<FavsListEvent, FavslistsState> {
  final GetFavsLists getFavsLists;
  final AddFavsList addFavsList;
  final UpdateFavsList updateFavsList;
  final DeleteFavsList deleteFavsList;
  final GetFavslistById getFavsListById;
  final StreamFavsLists streamFavsLists;

  FavsListBloc(
      {required this.getFavsLists,
      required this.addFavsList,
      required this.updateFavsList,
      required this.deleteFavsList,
      required this.getFavsListById,
      required this.streamFavsLists})
      : super(const FavslistsState()) {
    on<LoadFavsListsEvent>(_onLoadFavsLists);
    on<StreamFavsListsEvent>(_onStreamFavsLists);
    on<AddFavsListEvent>(_onAddFavsList);
    on<UpdateFavsListEvent>(_onUpdateFavsList);
    on<DeleteFavsListEvent>(_onDeleteFavsList);
    on<GetFavsListByIdEvent>(_onGetFavsListById);
  }

  Future<void> _onLoadFavsLists(
      LoadFavsListsEvent event, Emitter<FavslistsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getFavsLists(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: "Error cargando listas de favoritos")),
      (favsLists) => emit(state.copyWith(isLoading: false, favsLists: favsLists)),
    );
  }

  Future<void> _onStreamFavsLists(
      StreamFavsListsEvent event, Emitter<FavslistsState> emit) async {
    await streamFavsLists(NoParams()).fold(
      (failure) async => state.copyWith(
        errorMessage: failure.toString(),
        isLoading: false,
      ),
      (stream) async {
        await emit.forEach<List<FavslistEntity>>(
          stream,
          onData: (favsLists) => state.copyWith(favsLists: favsLists, isLoading: false),
          onError: (error, stackTrace) => state.copyWith(
            errorMessage: error.toString(),
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> _onAddFavsList(
      AddFavsListEvent event, Emitter<FavslistsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await addFavsList(event.favsList);
    add(LoadFavsListsEvent());
  }

  Future<void> _onUpdateFavsList(
      UpdateFavsListEvent event, Emitter<FavslistsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await updateFavsList(event.favsList);
    add(LoadFavsListsEvent());
  }

  Future<void> _onDeleteFavsList(
      DeleteFavsListEvent event, Emitter<FavslistsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await deleteFavsList(event.favsListId);
    add(LoadFavsListsEvent());
  }

  Future<void> _onGetFavsListById(
      GetFavsListByIdEvent event, Emitter<FavslistsState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await getFavsListById(event.favsListId);
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: "Error cargando la lista de favoritos")),
      (favsList) => emit(state.copyWith(isLoading: false, favsLists: [favsList])),
    );
  }
}