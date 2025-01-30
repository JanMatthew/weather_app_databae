import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/services/database.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailRegisterController = TextEditingController();
  final TextEditingController _passwordRegisterController = TextEditingController();
  final TextEditingController _emailLogController = TextEditingController();
  final TextEditingController _passwordLogController = TextEditingController();
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
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'assets/icon/weatherIcon.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Les Comarques de \nla Comunitat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child:  TextFormField(
                    controller: _emailLogController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'User',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _passwordLogController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom( 
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(110, 20),
                          maximumSize: const Size(110, 50)
                        ),
                        onPressed: () async {
                          if(await signIn(_emailLogController.text, _passwordLogController.text)){
                            final DatabaseService ds = DatabaseService(_emailLogController.text);
                            ds.updateUserData(_emailLogController.text);
                            Map<String,dynamic>? userData = await ds.getUserData();
                            var name = userData?['login'];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(name),
                                backgroundColor: Colors.green,
                               ),
                              );
                            context.push("/provinces/${_emailLogController.text}");
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login fallido'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          
                          
                        },
                        child: const Text("Login"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom( 
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(110, 20),
                          maximumSize: const Size(110, 50)
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Register"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _emailRegisterController,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _passwordRegisterController,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                      ),
                                      obscureText: true,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if(await signUp(_emailRegisterController.text,_passwordRegisterController.text)){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Registro exitoso'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        context.pop();
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Registro fallido'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text("Register"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ]
                  )
                )
                ] 
              ),
            ),
          ),
        ),
    );
  }

  Future<bool> signUp(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email:email,password: password);
      print("Usuario registrado exitosamente");
      return true;
    } catch(e){
      print("Error en el registro: $e");
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Inicio de sesión exitoso");
      return true;
    } catch(e){
      print("Error en el incio de sesión: $e");
      return false;
    }
  
  }

}




