import 'dart:io';
import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'package:http/http.dart' as http; // Per realitzar peticions HTTP

Future<dynamic> obtenerClima(
    {required double longitud, required double latitud}) async {
  String url =
      'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);

    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No se ha podido conectar');
  }
}

Future<dynamic> obtenerProvincias() async {
  String url =
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);

    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No se ha podido conectar');
  }
}

Future<dynamic> obtenerComarcas(
    {required String provincia}) async {
  String url =
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/$provincia';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);

    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No se ha podido conectar');
  }
}

Future<dynamic> obtenerComarcasConImagen(
    {required String provincia}) async {
  String url =
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);

    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No se ha podido conectar');
  }
}

Future<Map<dynamic,dynamic>> obtenerInfoComarca({required String comarca}) async {
  String url =
      'https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    print(result);

    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No se ha podido conectar');
  }
}