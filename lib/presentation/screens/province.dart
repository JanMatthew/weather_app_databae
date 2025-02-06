import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/date/counties.dart';
import 'package:weather_app/peticiones_http.dart';

class ProvinciesScreen extends StatelessWidget{
  final String user;
  const ProvinciesScreen({super.key,required this.user});



  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: obtenerProvincias(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return const Center(child: Text('Error al cargar favoritos'));
          }
          else if(snapshot.hasData){
            List<dynamic> provincias = snapshot.data as List<dynamic>;
            if(provincias.isEmpty){
              return const Center(child: Text("No hay provincias"));
            }
            else{
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sky.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.push("/regions/${provincias[2]["provincia"].toString()}/$user");
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    provincias[2]["img"].toString(),
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  provincias[2]["provincia"].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.push("/regions/${provincias[0]["provincia"].toString()}/$user");
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    provincias[0]["img"].toString(),
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover
                                  ),
                                ),
                                Text(
                                  provincias[0]["provincia"].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      shadows:[
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(4, 4)
                                        )
                                      ] 
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => {
                              context.push("/regions/${provincias[1]["provincia"].toString()}/$user")
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    provincias[1]["img"].toString(),
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover
                                  ),
                                ),
                                Text(
                                    provincias[1]["provincia"].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                        )
                                      ]
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              context.push("/favorites/$user");
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    provincies["provincies"][2]["img"].toString(),
                                    width: 20.0,
                                    height: 20.0,
                                    fit: BoxFit.cover
                                  ),
                                ),
                                const Text(
                                    "Favoritas",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      shadows:[
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(4, 4)
                                        )
                                      ] 
                                    )
                                )
                              ],
                            ),
                          ),
                        ),

                      ],
                  ),
                  ),
                ),
              );
            }
          }
          else{
            return const Center(child: Text("No se pudo cargar los datos"));
          }
        },
      )
    );
  }
}