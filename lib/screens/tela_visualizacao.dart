import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/controller.dart';

class TelaVisualizacao extends StatelessWidget {
  TelaVisualizacao({required this.i, required this.controller, Key? key})
      : super(key: key);

  final Controller controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.fotos[i].titulo!),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.remove(i).then((value) {
            Navigator.of(context).pop();
          });
        },
        label: Text('Excluir'),
      ),
      body: SingleChildScrollView(
        child: controller.fotos[i].picture != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.fotos[i].descricao!,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Image.memory(controller.fotos[i].picture!),
                    ),
                  ],
                ),
              )
            : Center(
                child: RefreshProgressIndicator(),
              ),
      ),
    );
  }
}
