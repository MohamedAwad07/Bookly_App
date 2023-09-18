import 'package:bookly/Layout/home_page.dart';
import 'package:bookly/modules/search%20view/search_view.dart';
import 'package:go_router/go_router.dart';
import '../modules/Book Details view/book_details.dart';
import '../modules/splash view/splash_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/HomeView',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/DetailsView',
        builder: (context, state) => const DetailsView(),
      ),
      GoRoute(
        path: '/SearchView',
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}
