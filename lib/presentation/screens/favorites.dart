import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/date/counties.dart';
import 'package:weather_app/peticiones_http.dart';
import 'package:weather_app/services/database.dart';

class FavoritesScreen extends StatelessWidget {
  final String user;
  const FavoritesScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context){
    DatabaseService db = DatabaseService(user);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Comarques De Valencia",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/provinces/$user");
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.6),
        elevation: 0,
      ),
      body: FutureBuilder<List<String>>(
        future: db.getFavoriteCounties(),
         builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return const Center(child: Text('Error al cargar favoritos'));
          }
          else if(snapshot.hasData){
            List<String> favs = snapshot.data!;

            if(favs.isEmpty){
              return const Center(child: Text("No hay favoritos aun"));
            }
            else{
              return ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context,index){
                return FutureBuilder(
                  future: obtenerInfoComarca(comarca: favs[index]), 
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return const Center(child: Text('Error al cargar favoritos'));
                    }
                    else if(snapshot.hasData){
                      Map<dynamic,dynamic> comarcaInfo = snapshot.data as Map<dynamic,dynamic>;
                      return Padding(padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => {
                          context.push("/info_1/${comarcaInfo["comarca"]}/$user")
                        },
                        child: Card(
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.network(
                                comarcaInfo["img"].toString(),
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,  
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10, left: 10),
                                child: Text(
                                  comarcaInfo["comarca"],
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(4, 4)
                                      )
                                    ],
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              )
                            ]
                          )
                        )
                      )
                      );
                    }
                    else{
                      return Center(child: Text("No se puedo cargar los datos"));
                    }
                  }
              );
              });
            }
          }
          else{
            return const Center(child: Text("No se pudo cargar los datos"));
          }
         },
      ),
    );
  }
}

