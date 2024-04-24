import 'package:path/path.dart';
import 'package:ets_ppb/database/database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ets_ppb/model/movie.dart';

class MovieDatabase extends DatabaseService {
  @override
  Future<void> createTable(Database database, int version) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    ${MovieFields.id} ${DatabaseService.type['id']},
    ${MovieFields.title} ${DatabaseService.type['text']},
    ${MovieFields.description} ${DatabaseService.type['text']},
    ${MovieFields.addedTime} ${DatabaseService.type['text']}
    );"""
    );
  }

  @override
  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, tableName);
  }

  Future<Movie> create(Movie movie) async {
    final db = await super.database;

    final id = await db.insert(tableName, movie.toJson());
    return movie.copy(id: id);
  }

  Future<Movie> readMovie(int id) async {
    final db = await super.database;

    final maps = await db.query(
        tableName,
        columns: MovieFields.values,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]
    );

    if(maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('Id $id is not found');
    }
  }

  Future<List<Movie>> readAllMovies() async {
    final db = await super.database;

    final noteLists = await db.query(
        tableName,
        orderBy: '${MovieFields.addedTime} ASC'
    );

    return noteLists.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> update(Movie movie) async {
    final db = await super.database;

    return await db.update(
      tableName,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await super.database;

    return await db.delete(
        tableName,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]
    );
  }
}