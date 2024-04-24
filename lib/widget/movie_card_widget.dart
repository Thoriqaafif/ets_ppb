import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ets_ppb/model/movie.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget({super.key, required this.movie, required this.index});

  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(movie.addedTime);
    final height = 100.0;

    return Card(
      color: Colors.white54,
      child: Container(
        padding: const EdgeInsets.all(6),
        height: height,
        child: Row(
          children: [
            Image.asset(
              'images/black-panther.jpg',
              height: 80.0,
            ),
            Column(
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 14, color: Colors.black26),
                )
              ]
            )
          ]
        )
      ),
    );
  }
}
