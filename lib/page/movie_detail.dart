import 'package:flutter/material.dart';
import 'package:ets_ppb/model/movie.dart';

class MovieDetail extends StatefulWidget {
  final Movie? movie;

  const MovieDetail({super.key, required this.movie});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
