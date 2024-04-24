import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/movie_database.dart';
import '../model/movie.dart';
import '../page/movie_edit.dart';

class MovieDetail extends StatefulWidget {
  final int noteId;

  const MovieDetail({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<MovieDetail> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<MovieDetail> {
  late Movie note;
  bool isLoading = false;
  final moviesDB = MovieDatabase();

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await moviesDB.readMovie(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            note.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(note.createdTime),
            style: const TextStyle(color: Colors.white38),
          ),
          const SizedBox(height: 8),
          Text(
            note.description,
            style:
            const TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await NotesDB.delete(widget.noteId);

      Navigator.of(context).pop();
    },
  );
}