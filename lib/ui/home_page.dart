import 'package:flutter/material.dart';
import 'package:flutter_database_app/ui/cadastro_page.dart';
import 'package:flutter_database_app/ui/catalogo_page.dart';
import 'package:flutter_database_app/ui/list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Meus livros"),
      ),
      body: HomeBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroPage(),
                ),
              ),
              child: Text("Cadastrar Livro"),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  minimumSize: const Size(150, 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              ),
              child: Text("Lista dos Livros"),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  minimumSize: const Size(150, 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CatalogoPage(),
                ),
              ),
              child: Text("Catálogo dos Livros"),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  minimumSize: const Size(150, 50)),
            ),
          ),
        ],
      ),
    );
  }
}
