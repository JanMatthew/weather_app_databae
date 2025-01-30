import 'package:weather_app/domain/entities/favsList.dart';

class FavsListModel {
  final String id;
  final String user;
  final List favsRegions;

  FavsListModel({required this.id, required this.user, required this.favsRegions});

  factory FavsListModel.fromJson(Map<String, dynamic> json, String id) {
    return FavsListModel(
      id: id,
      user: json['user'],
      favsRegions: json['favsRegions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'favsRegions': favsRegions,
    };
  }

  FavslistEntity toEntity() {
    return FavslistEntity(
      id: id,
      user: user,
      favsRegions: favsRegions,
    );
  }

  static FavsListModel fromEntity(FavslistEntity favsList) {
    return FavsListModel(
        id: favsList.id, user: favsList.user, favsRegions: favsList.favsRegions);
  }
}
