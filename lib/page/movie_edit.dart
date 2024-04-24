
import 'package:ets_ppb/database/movie_database.dart';
import 'package:flutter/material.dart';
import 'package:ets_ppb/model/movie.dart';
import 'package:ets_ppb/widget/movie_form_widget.dart';

class MovieEdit extends StatefulWidget {
  final Movie? movie;

  const MovieEdit({super.key, this.movie});

  @override
  State<MovieEdit> createState() => _MovieEditState();
}

class _MovieEditState extends State<MovieEdit> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  final moviesDB = MovieDatabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.movie?.title ?? '';
    description = widget.movie?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: MovieFormWidget(
          title: title,
          description: description,
          onChangedTitle: (title) =>
            setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: addOrUpdate,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdate() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      title: title,
      description: description
    );

    await moviesDB.update(movie);
  }
  
  Future addMovie() async {
    final movie = Movie(
        title: title,
        description: description,
        addedTime: DateTime.now(),
    );

    await moviesDB.create(movie);
  }

}
