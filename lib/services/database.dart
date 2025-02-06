
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {

  final String email;
  DatabaseService(this.email);

Future updateFavoriteCounties(String newCountie) async {
    String safeEmail = email.replaceAll('.', '_');
    final db = FirebaseDatabase.instance.ref('favsLists/$safeEmail');
    List<String> favCounties = await getFavoriteCounties();
    favCounties.add(newCountie);
    print(newCountie);
    return db.update({'favsRegions':favCounties});
}

Future<List<String>> getFavoriteCounties() async {
  try {
    // Obtén el documento desde Firestore
    String safeEmail = email.replaceAll('.', '_');
    final db = FirebaseDatabase.instance.ref('favsLists/$safeEmail');
    final snapshot = await db.get();
    
    if (snapshot.exists) {
      
      Map<String, dynamic> data = Map<String, dynamic>.from(snapshot.value as Map);

      // Verifica si el campo 'fav_counties' existe y no es null
      if (data.containsKey('favsRegions') && data['favsRegions'] != null) {
        print(data['favsRegions']);
        List<dynamic> favList = data['favsRegions'];
        
        print(favList);
        return favList.map((item) => item.toString()).toList();
      } else {
        print("No existe fav counties");
        return []; // Devuelve una lista vacía si el campo no existe o es null
      }
    } else {
      print("Usuario no encontrado en la base de datos. Creando entrada...");
      
      await FirebaseDatabase.instance.ref('favsLists').child(safeEmail).set({
        'favsRegions': []
      });

      return []   ; // Devuelve una lista vacía si el documento no existe
    }
  } catch (e) {
    print('Error al obtener los datos: $e');
    return []; // Devuelve una lista vacía en caso de error
  }
  
}

  Future deleteFavoriteCountie(String countyToDelete) async {
  try {
    // Obtén la lista actual de favoritos
    List<String> favoriteCounties = await getFavoriteCounties();

    // Si el elemento está en la lista, elimínalo
    if (favoriteCounties.contains(countyToDelete)) {
      favoriteCounties.remove(countyToDelete);
      print(favoriteCounties);
      String safeEmail = email.replaceAll('.', '_');
      // Actualiza la lista en la base de datos
      await FirebaseDatabase.instance.ref('favsLists/$safeEmail').update({
        'favsRegions': favoriteCounties,
      });
    }
  } catch (e) {
    print('Error al eliminar el favorito: $e');
  }
}

  Future<Map<String,dynamic>?> getUserData() async{
    try{
      String safeEmail = email.replaceAll('.', '_');
      final snapshot = await FirebaseDatabase.instance.ref('favsLists/$safeEmail').get();
    
      if(snapshot.exists){
        return snapshot.value as Map<String,dynamic>;
      }
      else{
        return null;
      }
    
    } catch(e){
      print('Error al obtener los datos');
      return null;
    }
  }
}