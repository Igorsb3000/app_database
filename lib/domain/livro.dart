class Livro{

  static const String livroTable = "livro_table";
  static const String idColumn = "id";
  static const String tituloColumn = "titulo";
  static const String autorColumn = "autor";
  static const String anoPublicacaoColumn = "ano_publicacao";
  static const String avaliacaoColumn = "avaliacao";

  int id = 0;
  String titulo = '';
  String autor = '';
  int anoPublicacao = 0;
  double avaliacao = 0;

  Livro(this.titulo, this.autor, this.anoPublicacao, this.avaliacao);

  Livro.comId(this.id, this.titulo, this.autor, this.anoPublicacao, this.avaliacao);

  Livro.fromMap(Map map) {
    id = map[idColumn];
    titulo = map[tituloColumn];
    autor = map[autorColumn];
    anoPublicacao = map[anoPublicacaoColumn];
    avaliacao = map[avaliacaoColumn];
  }

  Map<String, dynamic> toMap() {
    return {
      tituloColumn: titulo,
      autorColumn: autor,
      anoPublicacaoColumn:anoPublicacao,
      avaliacaoColumn:avaliacao
    };
  }

  @override
  String toString() {
    return 'Livro{titulo: $titulo, autor: $autor, anoPublicacao: $anoPublicacao, avaliacao: $avaliacao}';
  }
}