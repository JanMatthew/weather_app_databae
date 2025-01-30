import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/date/counties.dart';

class ProvinciesScreen extends StatelessWidget{
  final String user;
  const ProvinciesScreen({super.key,required this.user});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
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
                      context.push("/regions/2/$user");
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            provincies["provincies"][2]["img"].toString(),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          provincies["provincies"][2]["provincia"].toString(),
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
                      context.push("/regions/0/$user");
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            provincies["provincies"][0]["img"].toString(),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover
                          ),
                        ),
                        Text(
                            provincies["provincies"][0]["provincia"].toString(),
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
                      context.push("/regions/1/$user")
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.network(
                            provincies["provincies"][1]["img"].toString(),
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover
                          ),
                        ),
                        Text(
                            provincies["provincies"][1]["provincia"].toString(),
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
      ),
    );
  }
}