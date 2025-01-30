import 'package:equatable/equatable.dart';
import '../../../domain/entities/favsList.dart';

class FavslistsState extends Equatable {
  final List<FavslistEntity> favsLists;
  final bool isLoading;
  final String? errorMessage;

  const FavslistsState({
    this.favsLists = const <FavslistEntity>[],
    this.isLoading = false,
    this.errorMessage,
  });

  FavslistsState copyWith({
    List<FavslistEntity>? favsLists,
    bool? isLoading,
    String? errorMessage,
  }) {
    return FavslistsState(
      favsLists: favsLists ?? this.favsLists,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [favsLists, isLoading, errorMessage];
}
