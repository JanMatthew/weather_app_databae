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
      path: '/regions/:provinceId/:email',
      builder: (context,state){ 
        final String email = state.pathParameters['email']!;
        final int provinceId = int.parse(state.pathParameters['provinceId']!);
        return ComarquesScreen(provinceId: provinceId,user: email,);
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
      path: '/info_1/:provinceId/:regionId/:email',
      builder: (context,state) {
        final String email = state.pathParameters['email']!;
        final int provinceId = int.parse(state.pathParameters['provinceId']!);
        final int regionId = int.parse(state.pathParameters['regionId']!);
        return InfoComarca1Screen(provinceId: provinceId, regionId: regionId,user: email,);
      }
    ),
    GoRoute(
      name: 'info comarca 2',
      path: '/info_2',
      builder: (context,state) => const InfoComarca2Screen()
    ),
  ]
);