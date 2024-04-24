import 'package:ets_ppb/page/movie_edit.dart';
import 'package:flutter/material.dart';
import 'package:ets_ppb/model/movie.dart';
import 'package:ets_ppb/database/movie_database.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_ppb/widget/movie_card_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Movie> movies;
  bool isLoading = false;
  final MovieDB = MovieDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    MovieDB.close();

    super.dispose();
  }

  Future<void> refreshMovies() async {
    setState(() {
      isLoading = true;
    });

    movies = await MovieDB.readAllMovies();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies',
          style: TextStyle(fontSize: 24, color: Colors.blueAccent)
        ),
      ),
      body: isLoading
            ? const CircularProgressIndicator()
            : movies.isEmpty
            ? const Center(
                child: Text('No Movies', style: TextStyle(fontSize: 24),),
            )
            : buildMovies(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MovieEdit()
            ));

            refreshMovies();
          }
      ),
    );
  }

  Widget buildMovies() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        movies.length,
            (index) {
          final movie = movies[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder:(context) => MovieEdit(movie: movie),
                ));

                refreshMovies();
              },
              child: MovieCardWidget(movie: movie, index: index),
            ),
          );
        },
      ));
}
