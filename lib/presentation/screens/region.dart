import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/date/counties.dart';
import 'package:weather_app/peticiones_http.dart';

class ComarquesScreen extends StatelessWidget{
  final String user;
  final String provincia;
  const ComarquesScreen({super.key,required this.provincia, required this.user});

  @override 
  Widget build(BuildContext context){


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
      body: FutureBuilder(
        future: obtenerComarcasConImagen(provincia: provincia), 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return const Center(child: Text('Error al cargar favoritos'));
          }
          else if(snapshot.hasData){
            List<dynamic> comarcas = snapshot.data as List<dynamic>;
            if(comarcas.isEmpty){
              return const Center(child: Text("No hay provincias"));
            }
            else{
              return ListView.builder(itemCount: comarcas.length,
              itemBuilder: (context,index){
                return Padding(padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () => {
                      context.push("/info_1/${comarcas[index]['nom']}/$user")
                    },
                    child: Card(
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.network(
                            comarcas[index]["img"].toString(),
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,  
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 10),
                            child: Text(
                              comarcas[index]["nom"].toString(),
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
            );
            }
          }
          else{
            return const Center(child: Text("No se pudo cargar los datos"));
          }
        }
      )
    );
  }
}