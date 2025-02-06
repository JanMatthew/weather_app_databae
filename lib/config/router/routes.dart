import 'package:weather_app/presentation/screens/favorites.dart';
import 'package:weather_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: '/',
      builder: (context,state) => const LoginScreen()
    ),
    GoRoute(
      name: 'provinces',
      path: '/provinces/:email',
      builder: (contest,state){
        final String email = state.pathParameters['email']!;
        return ProvinciesScreen(user: email);
      }
    ),
    GoRoute(
      name: 'regions',
      path: '/regions/:province/:email',
      builder: (context,state){ 
        final String email = state.pathParameters['email']!;
        final String province = state.pathParameters['province']!;
        return ComarquesScreen(provincia: province,user: email,);
      }
    ),
    GoRoute(
      name: 'favorites',
      path: '/favorites/:email',
      builder: (context,state){ 
        final String email= state.pathParameters['email']!;
        return FavoritesScreen(user: email);
      }
    ),
    GoRoute(
      name: 'info comarca 1',
      path: '/info_1/:region/:email',
      builder: (context,state) {
        final String email = state.pathParameters['email']!;
        final String region = state.pathParameters['region']!;
        return InfoComarca1Screen(comarca: region,user: email,);
      }
    ),
    GoRoute(
      name: 'info comarca 2',
      path: '/info_2',
      builder: (context,state) => const InfoComarca2Screen()
    ),
  ]
);