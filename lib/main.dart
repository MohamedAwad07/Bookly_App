import 'package:bookly/Layout/data/models/book_model/book_model.dart';
import 'package:bookly/services/app_router.dart';
import 'package:bookly/services/service_locator.dart';
import 'package:bookly/shared/Constants/color_manager.dart';
import 'package:bookly/shared/Constants/constants.dart';
import 'package:bookly/shared/Cubits/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/shared/Cubits/manger/newest_books_cubit/newset_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Layout/data/models/repos/home_repo_impl.dart';

void main() {
  setupServiceLocator();
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            getIt.get<HomeRepoImpl>(),
          )
            ..fetchFeaturedBooks()
        ),
        BlocProvider(
          create: (context) => NewsetBooksCubit(
            getIt.get<HomeRepoImpl>(),
          )..fetchNewestBooks(),
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: ColorManager.defaultColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
