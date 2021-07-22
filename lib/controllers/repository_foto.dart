import 'package:projeto_final/controllers/banco_de_dados.dart';
import 'package:projeto_final/models/foto.dart';

class Repository {
  BancoDeDados bancoDeDados = BancoDeDados();
  final String sqlSelect = 'SELECT * FROM fotos';
  final String sqlInsert =
      'INSERT INTO fotos (picture, date, latitude, longitude, titulo, descricao) VALUES (?, ?, ?, ?, ?, ?)';
  final String sqlDelete = 'DELETE FROM fotos WHERE id = ?';
  final String sqlUpdateDescricao =
      'UPDATE fotos SET descricao = ? WHERE id = ?';

  Future<List<Foto>> selectAll() async {
    return await bancoDeDados.db!
        .rawQuery(sqlSelect)
        .then((List<Map<String, Object?>> value) {
      List<Foto> fotos = [];
      for (Map<String, dynamic> fid in value) {
        fotos.add(Foto.fromMap(fid));
      }
      return fotos;
    });
  }

  Future<int> insert(Foto foto) async {
    return await bancoDeDados.db!.rawInsert(sqlInsert, [
      foto.picture,
      foto.date,
      foto.latitude,
      foto.longitude,
      foto.titulo,
      foto.descricao
    ]);
  }

  Future<void> updateDescricao(Foto foto) async {
    await bancoDeDados.db!
        .rawUpdate(sqlUpdateDescricao, [foto.descricao, foto.id]);
    return;
  }

  Future<void> delete(Foto foto) async {
    await bancoDeDados.db!.rawDelete(sqlDelete, [foto.id]);
    return;
  }

  Future<void> clearTable() async {
    await bancoDeDados.db!.delete('fotos');
    print('deleted');
    return;
  }
}
