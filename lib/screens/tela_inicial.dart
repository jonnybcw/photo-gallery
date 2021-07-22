import 'package:flutter/material.dart';
import 'package:projeto_final/controllers/banco_de_dados.dart';
import 'package:projeto_final/controllers/controller.dart';
import 'package:projeto_final/screens/tela_cadastro.dart';
import 'package:projeto_final/screens/tela_visualizacao.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool loading = true;
  final Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    BancoDeDados db = BancoDeDados();
    db.openDb().then((value) {
      select();
    });
  }

  void select() {
    setState(() {
      loading = true;
    });
    controller.select().then((value) => {
          setState(() {
            loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galeria de fotos',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Apagar todas as imagens',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          'Você tem certeza que deseja apagar todas as imagens?'),
                      content: Text('Esta ação é irreversível.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            controller.clearTable();
                            select();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Apagar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          tooltip: 'Tirar uma foto',
          onPressed: () {
            controller.getImage().then((foto) async {
              if (foto != null) {
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TelaCadastro(
                    foto: foto,
                    controller: controller,
                  );
                }));
                select();
              }
            });
          }),
      body: loading
          ? Center(
              child: RefreshProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                select();
              },
              child: Center(
                child: controller.fotos.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 4, 0, 4),
                                        child:
                                            Text(controller.fotos[i].titulo!),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Data: ${DateTime.parse(controller.fotos[i].date!).day}'
                                              '/${DateTime.parse(controller.fotos[i].date!).month}/${DateTime.parse(controller.fotos[i].date!).year}'),
                                          Text(
                                              'Latitude: ${controller.fotos[i].latitude!.toStringAsFixed(4)}'),
                                          Text(
                                              'Longitude: ${controller.fotos[i].longitude!.toStringAsFixed(4)}'),
                                        ],
                                      ),
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return TelaVisualizacao(
                                            i: i,
                                            controller: controller,
                                          );
                                        }));
                                        select();
                                      },
                                      trailing: Image.memory(
                                          controller.fotos[i].picture!),
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.fotos.length,
                            ),
                          ),
                        ],
                      )
                    : Text('Nenhuma foto para listar.'),
              ),
            ),
    );
  }
}
