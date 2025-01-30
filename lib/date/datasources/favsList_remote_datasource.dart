import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app/date/models/favsList_model.dart';

abstract class FavslistRemoteDataSource {
  Future<List<FavsListModel>> getFavsLists();
  Stream<List<FavsListModel>> streamFavsList();
  Future<FavsListModel?> getFavsListsById(String favsListId);
  Future<void> addFavsList(FavsListModel favsList);
  Future<void> updateFavsList(FavsListModel favsList);
  Future<void> deleteFavsList(String favsListId);
}

class FavsListRemoteDataSourceImpl implements FavslistRemoteDataSource {
  final FirebaseDatabase database;

  FavsListRemoteDataSourceImpl(this.database);

  @override
  Future<List<FavsListModel>> getFavsLists() async {
    List<FavsListModel> favsLists = [];
    final snapshot = await database.ref('favsLists').get();
    if (snapshot.value != null) {
      final favsListsMap = Map<String, dynamic>.from(snapshot.value as Map);
      return favsListsMap.entries
          .map((e) => FavsListModel.fromJson(Map<String, dynamic>.from(e.value), e.key))
          .toList();
    }
    return favsLists;
  }

  @override
  Stream<List<FavsListModel>> streamFavsList() {
    List<FavsListModel> favsLists = [];
    return database.ref('favsLists').onValue.map((event) {
      if (event.snapshot.value != null) {
        final favsListsMap = Map<String, dynamic>.from(event.snapshot.value as Map);
        return favsListsMap.entries
            .map((e) => FavsListModel.fromJson(Map<String, dynamic>.from(e.value), e.key))
            .toList();
      }
      return favsLists;
    });
  }

  @override
  Future<FavsListModel?> getFavsListsById(String favsListId) async {
    final snapshot = await database.ref('favsLists/$favsListId').get();
    if (snapshot.exists) {
      return FavsListModel.fromJson(
          Map<String, dynamic>.from(snapshot.value as Map), favsListId);
    }
    return null;
  }

  @override
  Future<void> addFavsList(FavsListModel favsList) async {
    await database.ref('favsLists').push().set(favsList.toJson());
  }

  @override
  Future<void> updateFavsList(FavsListModel favsList) async {
    await database.ref('favsLists/${favsList.id}').update(favsList.toJson());
  }

  @override
  Future<void> deleteFavsList(String favsListId) async {
    await database.ref('favsLists/$favsListId').remove();
  }
}