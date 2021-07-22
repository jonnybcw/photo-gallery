import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/controller.dart';

class TelaCadastro extends StatefulWidget {
  TelaCadastro({required this.foto, required this.controller});
  final Uint8List foto;
  final Controller controller;

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Foto',
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          int fotoId = await widget.controller.inserir(widget.foto);
          Navigator.of(context).pop(fotoId);
        },
        label: Text('Salvar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.foto.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Image.memory(
                        widget.foto,
                        fit: BoxFit.contain,
                      ),
                    )
                  : RefreshProgressIndicator(),
              Text(
                'Título:',
                style: styleTitle(),
              ),
              SizedBox(
                height: 6,
              ),
              TextField(
                controller: widget.controller.caixaTitulo,
                decoration: styleTextField(),
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Descrição:',
                style: styleTitle(),
              ),
              SizedBox(
                height: 6,
              ),
              TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: widget.controller.caixaDescricao,
                minLines: 5,
                maxLines: 7,
                decoration: styleTextField(),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle styleTitle() {
    return TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
  }

  InputDecoration styleTextField() {
    return InputDecoration(
      border: const OutlineInputBorder(),
    );
  }
}
