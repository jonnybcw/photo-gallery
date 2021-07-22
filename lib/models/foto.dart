import 'dart:typed_data';

class Foto {
  int? id;
  Uint8List? picture;
  String? date;
  double? latitude;
  double? longitude;
  String? titulo;
  String? descricao;

  Foto(
      {this.picture,
      this.date,
      this.latitude,
      this.longitude,
      this.titulo,
      this.descricao});

  Foto.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.picture = map['picture'];
    this.date = map['date'];
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
    this.titulo = map['titulo'];
    this.descricao = map['descricao'];
  }

  @override
  String toString() {
    return '${date.toString()} - $latitude - $longitude - $titulo - $descricao';
  }
}
