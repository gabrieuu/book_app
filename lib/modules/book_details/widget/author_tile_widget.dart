import 'package:book_app/infra/client_http/client_http.dart';
import 'package:book_app/core/status.dart';
import 'package:book_app/model/author_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthorTileWidget extends StatefulWidget {
  final String authorId;

  const AuthorTileWidget({
    super.key,
    required this.authorId,
  });

  @override
  State<AuthorTileWidget> createState() => _AuthorTileWidgetState();
}

class _AuthorTileWidgetState extends State<AuthorTileWidget> {
  late final ClientHttp _httpClient;
  AuthorModel? _author;
  Status _status = Status.NAO_CARREGADO;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _httpClient = Modular.get<ClientHttp>();
    _loadAuthor();
  }

  Future<void> _loadAuthor() async {
    try {
      setState(() {
        _status = Status.CARREGANDO;
        _errorMessage = null;
      });

      // OpenLibrary API: /authors/{id}.json
      final response = await _httpClient.get(
        'https://openlibrary.org/authors/${widget.authorId}.json',
      );

      final author = AuthorModel.fromOpenLibrary(response);

      setState(() {
        _author = author;
        _status = Status.SUCESSO;
      });
    } catch (e) {
      setState(() {
        _status = Status.ERRO;
        _errorMessage = 'Erro ao carregar autor: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_status == Status.CARREGANDO) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_status == Status.ERRO) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 40),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Erro ao carregar autor',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[400]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadAuthor,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (_author == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.blue[600], size: 24),
              const SizedBox(width: 12),
              const Text(
                'Sobre o Autor',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Author Photo
          if (_author!.photoUrls != null && _author!.photoUrls!.isNotEmpty)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(_author!.photoUrls!.first),
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(color: Colors.blue[200]!, width: 2),
                ),
              ),
            )
          else
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.blue[200]!, width: 2),
                ),
                child: Icon(Icons.person, color: Colors.grey[400], size: 50),
              ),
            ),
          const SizedBox(height: 16),
          // Author Name
          Center(
            child: Text(
              _author!.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Full Name
          if (_author!.fullName != null && _author!.fullName!.isNotEmpty)
            Center(
              child: Text(
                _author!.fullName!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 16),
          // Birth/Death Dates
          if (_author!.dateOfBirth != null || _author!.dateOfDeath != null)
            Center(
              child: Text(
                '${_author!.dateOfBirth ?? '?'} - ${_author!.dateOfDeath ?? '?'}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          const SizedBox(height: 20),
          // Divider
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 16),
          // About
          Text(
            'Sobre',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _author!.about,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF2D3748),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
