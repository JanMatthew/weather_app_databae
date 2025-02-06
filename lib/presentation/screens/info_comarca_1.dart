import 'package:flutter/material.dart';
import 'package:weather_app/date/counties.dart';
import 'package:weather_app/peticiones_http.dart';
import 'package:weather_app/services/database.dart';
import 'package:weather_app/widgets/widget_weather.dart';

class InfoComarca1Screen extends StatefulWidget {
  final String comarca;
  final String user;
  const InfoComarca1Screen({super.key,required this.comarca,required this.user});
  
  @override
  State<InfoComarca1Screen> createState()=>
    _InfoComarca1State(comarca: comarca,user:user);
}

class _InfoComarca1State extends State<InfoComarca1Screen>{
  final String comarca;
  final String user;
  
  String addDel = 'Añadir a favoritos';
  int _currentIndex = 0;
  Map<dynamic,dynamic> infoComarca = {};
  
  _InfoComarca1State({required this.comarca,required this.user});

  @override
  void initState() {
    super.initState();
    _loadData(); // Valida si la región/provincia está en favoritos al iniciar
  }

  Future<void> _loadData() async {
    try{
      final data = await obtenerInfoComarca(comarca: comarca);
      DatabaseService db = DatabaseService(user);
      List<String> favoriteCounties = await db.getFavoriteCounties();    

      setState(() {
        infoComarca = data;
        addDel = favoriteCounties.contains(comarca)
          ? 'Eliminar de favoritos'
          : 'Añadir a favoritos';
      });
    } catch (e) {
      print('Error al cargar la información: $e');
    }
  }
  
  List<Widget> get _pages => infoComarca.isEmpty 
    ? [Center(child: CircularProgressIndicator())]
    :[
    Center(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                infoComarca["img"],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 20),
                child:  Text(
                  infoComarca["comarca"],
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10),
                child: Text(
                  "Capital: " + infoComarca["capital"],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text(
                infoComarca["desc"],
                style: const TextStyle(
                  fontSize: 15
                ),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: TextButton(
                  onPressed: () async {
                    DatabaseService db = DatabaseService(user);
                    List<String> favoriteCounties = await db.getFavoriteCounties();
                    if(favoriteCounties.contains(comarca)){
                      setState(() {
                        addDel = 'Añadir a favoritos';
                      });
                      await db.deleteFavoriteCountie(comarca);

                      ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Eliminado de favoritos'),
                                backgroundColor: Colors.green,
                               ),
                              );
                    }else{
                      setState(() {
                        addDel = 'Eliminar de favoritos';
                      });
                      await db.updateFavoriteCounties(comarca);

                      ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Añadido a favoritos'),
                                backgroundColor: Colors.green,
                               ),
                              );
                    }
                    

                  } , 
                  child: Text(addDel)),
              )
            ],
          ),
    ),
    Center(
          child: Column(
            children: [
              WidgetWeather(latitud: infoComarca["latitud"], longitud: infoComarca["longitud"]),
              Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Poblacio:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5), // Espacio entre los textos
                            Text(
                              "Latitud:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 5), // Espacio entre los textos
                            Text(
                              "Longitud:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            infoComarca["poblacio"],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5), // Espacio entre los textos
                          Text(
                            infoComarca["latitud"].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5), // Espacio entre los textos
                          Text(
                            infoComarca["longitud"].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],

                      )
                    ],
                  )
                ],
              ),
            ),
            ],
          ),
      ),
    ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(title: const Text('Info')),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // El índice de la pestaña seleccionada
        onTap: (int index) {
          setState(() {
            _currentIndex = index;  
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'L Oratge',
          ),
        ],
      ),
    );
  }
}