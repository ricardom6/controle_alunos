import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:controle_alunos/model/aluno.dart';

class AlunoHelper {
  static final AlunoHelper _instance = AlunoHelper.internal();

  AlunoHelper.internal();

  factory AlunoHelper() => _instance;
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, "aluno.db");
    final String sql = "CREATE TABLE aluno ("
        "c_id INTEGER PRIMARY KEY,"
        "c_nome TEXT,"
        "c_email TEXT,"
        "c_telefone TEXT,"
        "c_instituicao TEXT,"
        "c_path_img TEXT)";
    return await openDatabase(pathDB, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
    });
  }

  Future<Aluno> insert(Aluno aluno) async {
    Database dbAluno = await db;
    aluno.id = await dbAluno.insert("aluno", aluno.toMap());
    return aluno;
  }

  Future<Aluno> selectById(int id) async {
    Database dbAluno = await db;
    List<Map> maps = await dbAluno.query("aluno",
        columns: [
          "c_id",
          "c_nome",
          "c_email",
          "c_telefone",
          "c_instituicao",
          "c_path_img"
        ],
        where: "c_id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Aluno.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List> selectAll() async {
    Database dbAluno = await db;
    List list = await dbAluno.rawQuery("SELECT * FROM aluno");
    List<Aluno> lsAluno = List();
    for (Map m in list) {
      lsAluno.add(Aluno.fromMap(m));
    }
    return lsAluno;
  }

  Future<int> update(Aluno aluno) async {
    Database dbAluno = await db;
    return await dbAluno.update("aluno", aluno.toMap(),
        where: "c_id = ?", whereArgs: [aluno.id]);
  }

  Future<int> delete(int id) async {
    Database dbAluno = await db;
    return await dbAluno.delete("aluno", where: "c_id = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbAluno = await db;
    dbAluno.close();
  }
}
