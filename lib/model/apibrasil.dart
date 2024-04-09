import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_biblioteca/model/book.dart';

class ApiBrasil {
  static Future<Book> getBookInfo(String isbn) async {
    final response =
        await http.get(Uri.parse('https://brasilapi.com.br/api/isbn/v1/$isbn'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Obter o título e o autor do livro
      String title = responseData['title'];
      String author = responseData['authors'][0];

      // Normalizar o título e o autor para uso em uma URL
      String normalizedTitle = normalizeForUrl(title);
      String normalizedAuthor = normalizeForUrl(author);

      // Obter a URL da imagem da capa do livro usando a API bookcover
      final coverResponse = await http.get(Uri.parse(
          'https://api.bookcover.longitood.com/bookcover?book_title=$normalizedTitle&author_name=$normalizedAuthor'));
      String coverUrl;

      if (coverResponse.statusCode == 200) {
        final Map<String, dynamic> coverData = json.decode(coverResponse.body);
        coverUrl = coverData['url'];
      } else {
        // Caso não seja possível obter a URL da capa, usar uma capa genérica
        coverUrl =
            'https://btequipamentos.agilecdn.com.br/imagemindisponivel.jpg';
      }

      // Criar e retornar o objeto Book com todas as informações
      return Book.fromJson({
        ...responseData,
        'coverUrl': coverUrl,
      });
    } else {
      throw Exception('Falha ao carregar informações do livro');
    }
  }

  static String normalizeForUrl(String input) {
    // Lista de caracteres inválidos para URLs
    const invalidCharacters = r'[^a-zA-Z0-9\- ]';

    // Substituir caracteres inválidos
    String normalized = input.replaceAll(RegExp(invalidCharacters), '');

    return normalized;
  }
}
