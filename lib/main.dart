import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/bloc_observer.dart';
import 'package:movie_app/cubits/carousel_cubit/carousel_cubit.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_cubit.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_cubit.dart';
import 'package:movie_app/data/repo_impl.dart';
import 'package:movie_app/helper/dio_helper.dart';
import 'package:movie_app/pages/home_page.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CarouselCubit(repo: RepoImpl())..getPopularMovies()),
        BlocProvider(
            create: (context) =>
                TopMoviesCubit(repo: RepoImpl())..getTopMovies()),
        BlocProvider(
            create: (context) =>
                TopSeriesCubit(repo: RepoImpl())..getTopSeries()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
