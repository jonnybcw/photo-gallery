import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:projeto_final/controllers/repository_foto.dart';
import 'package:projeto_final/models/foto.dart';

class Controller {
  List<Foto> fotos = [];

  ImagePicker picker = ImagePicker();

  TextEditingController caixaTitulo = TextEditingController();
  TextEditingController caixaDescricao = TextEditingController();

  Repository repository = Repository();

  Future<void> select() async {
    return await repository.selectAll().then((value) => fotos = value);
  }

  Future<int> inserir(Uint8List fotoUint) async {
    return Location.instance.getLocation().then((location) async {
      Foto foto = Foto(
          picture: fotoUint,
          date: DateTime.now().toString(),
          latitude: location.latitude,
          longitude: location.longitude,
          titulo: caixaTitulo.text,
          descricao: caixaDescricao.text);
      caixaTitulo.clear();
      caixaDescricao.clear();
      return await repository.insert(foto);
    });
  }

  Future<void> remove(int i) async {
    Foto foto = fotos[i];
    return await repository.delete(foto);
  }

  Future getImage() async {
    var image = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 25,
        maxHeight: 1024,
        maxWidth: 1024);
    if (image != null) {
      var bytes = await image.readAsBytes();
      return bytes;
    }
  }

  Future<void> clearTable() async {
    await repository.clearTable();
    return;
  }
}
