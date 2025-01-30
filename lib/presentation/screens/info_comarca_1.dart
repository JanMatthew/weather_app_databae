import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/date/counties.dart';
import 'package:weather_app/domain/entities/favsList.dart';
import 'package:weather_app/presentation/blocs/favsLists/favsLists_bloc.dart';
import 'package:weather_app/presentation/blocs/favsLists/favsLists_event.dart';
import 'package:weather_app/services/database.dart';
import 'package:weather_app/widgets/widget_weather.dart';

class InfoComarca1Screen extends StatefulWidget {
  final int provinceId;
  final int regionId;
  final String user;
  final String? favsListId;
  final FavslistEntity? favsList;
  const InfoComarca1Screen({super.key,required this.provinceId, required this.regionId,required this.user, this.favsListId, this.favsList});
  
  @override
  State<InfoComarca1Screen> createState()=>
    _InfoComarca1State(provinceId: provinceId,regionId: regionId,user:user);
}

class _InfoComarca1State extends State<InfoComarca1Screen>{
  final int provinceId;
  final int regionId;
  final String user;
  final String? favsListId;
  final FavslistEntity? favsList;
  
  String addDel = 'Añadir a favoritos';
  int _currentIndex = 0;
  

  Map get comarca => provincies["provincies"][provinceId]["comarques"][regionId];
  
  List<Widget> get _pages => [
    Center(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                comarca["img"],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 20),
                child:  Text(
                  comarca["comarca"],
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.grey
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,bottom: 10),
                child: Text(
                  "Capital: " + comarca["capital"],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text(
                comarca["desc"],
                style: const TextStyle(
                  fontSize: 15
                ),
              )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: TextButton(
                  onPressed: () async {
                    String countie = "$regionId,$provinceId";
                    if(widget.favsListId != null){
                      final favoriteCounties = "";
                      if(favoriteCounties.contains(countie)){
                          setState(() {
                            addDel = 'Añadir a favoritos';
                        });

                      final favsList = FavslistEntity(
                            id: widget.favsListId!,
                            user: user, 
                            favsRegions: 
                      );

                      context.read<FavsListBloc>().add(DeleteFavsListEvent(widget.favsListId!));

                      ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Eliminado de favoritos'),
                                  backgroundColor: Colors.green,
                                ),
                                );
                    }
                    else{
                      setState(() {
                        addDel = 'Eliminar de favoritos';
                      });

                        final favsRegionsList = context.read<FavsListBloc>().getFavsListById(widget.favsListId!);
                        final favsList = FavslistEntity(
                          id: widget.favsListId!,
                          user: user, 
                          favsRegions: context.read<FavsListBloc>().add(GetFavsListByIdEvent(widget.favsListId!))
                        );
                        context.read<FavsListBloc>().add(UpdateFavsListEvent(favsList));
                        ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Añadido a favoritos'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                      
                  }else{
                    final favsList = FavslistEntity(
                          id: widget.favsListId ?? DateTime.now().toString(),
                          user: user, 
                          favsRegions: [countie]
                        );
                        context.read<FavsListBloc>().add(AddFavsListEvent(favsList));
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
              WidgetWeather(latitud: comarca["coordenades"][0], longitud: comarca["coordenades"][1]),
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
                            comarca["poblacio"],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5), // Espacio entre los textos
                          Text(
                            comarca["coordenades"][0].toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 5), // Espacio entre los textos
                          Text(
                            comarca["coordenades"][1].toString(),
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

  _InfoComarca1State({required this.provinceId, required this.regionId,required this.user, this.favsListId, this.favsList});


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