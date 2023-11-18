import 'package:flutter/material.dart';
import 'package:flutter_database_app/ui/edicao_page.dart';

import '../domain/livro.dart';
import '../helpers/livro_helper.dart';
import 'cadastro_page.dart';


class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meus livros"),
      ),
      body: const ListBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}


class ListBody extends StatefulWidget {
  const ListBody({super.key});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  final livroHelper = LivroHelper();
  late Future<List> livros;

  @override
  void initState() {
    super.initState();
    print('Conectou com o BD');
    livros = livroHelper.getAll();
  }

  @override
  void dispose() {
    livroHelper.close();
    print('Fechou conexão com o BD');
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ListBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    onUpdateList();
    // Este método é chamado quando o widget é reconstruído
    // após o Navigator.pop, você pode reagir às alterações aqui
  }

  void onUpdateList(){
    setState(() {
      livros = LivroHelper().getAll();
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
      future: livros,
      builder: (context, snapshot) {
        return snapshot.hasData  ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ListItem(livro: snapshot.data![i], livroHelper: livroHelper, onUpdateList: onUpdateList);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final livroHelper;
  final Livro livro;
  final Function onUpdateList;
  const ListItem({super.key, required this.livro, required this.livroHelper, required this.onUpdateList,});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Editar livro!"),
          ));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EdicaoPage(
                livro.id,
                livro.titulo,
                livro.autor,
                livro.anoPublicacao,
                livro.avaliacao,
              ),
            ),
          ).then((result) {
            // Esta função será chamada após o Navigator.pop na tela de destino
            if (result != null && result is String && result == 'listaAtualizada') {
              // Atualize sua lista aqui chamando a função de callback
              onUpdateList();
            }
          });
        },
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${livro.titulo} foi excluído!"),
          ));
          print("ID do livro = ${livro.id}");
          livroHelper.deleteLivro(livro.id);
          onUpdateList();
        },
        child: ListTile(
        title: Text(livro.titulo),
    ),
      );
  }
}

