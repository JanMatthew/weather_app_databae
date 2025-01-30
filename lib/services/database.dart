
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String email;
  DatabaseService(this.email);

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String login) async {
    return await brewCollection.doc(email).set({
      'login':login
    });
  }

  Future updateFavoriteCounties(String newCountie) async {
    List<String> favoriteCounties = await getFavoriteCounties();
    favoriteCounties.add(newCountie);
    return await brewCollection.doc(email).set({
      'fav_counties': favoriteCounties,
    });
  }

Future<List<String>> getFavoriteCounties() async {
  try {
    // Obtén el documento desde Firestore
    DocumentSnapshot snapshot = await brewCollection.doc(email).get();

    if (snapshot.exists) {
      // Asegúrate de que los datos sean un Map válido
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Verifica si el campo 'fav_counties' existe y no es null
      if (data.containsKey('fav_counties') && data['fav_counties'] != null) {
        List<dynamic> fav = data['fav_counties'];
        return fav.map((item) => item.toString()).toList();
      } else {
        print("No existe fav counties");
        return []; // Devuelve una lista vacía si el campo no existe o es null
      }
    } else {
      print("Snapshot no exitst");
      return []; // Devuelve una lista vacía si el documento no existe
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

      // Actualiza la lista en la base de datos
      await brewCollection.doc(email).update({
        'fav_counties': favoriteCounties,
      });
    }
  } catch (e) {
    print('Error al eliminar el favorito: $e');
  }
}

  Future<Map<String,dynamic>?> getUserData() async{
    try{
      DocumentSnapshot snapshot = await brewCollection.doc(email).get();
    
      if(snapshot.exists){
        return snapshot.data() as Map<String,dynamic>;
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