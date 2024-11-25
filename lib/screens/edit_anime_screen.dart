import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/anime.dart';

class EditAnimeScreen extends StatefulWidget {
  final Anime anime;

  EditAnimeScreen({required this.anime});

  @override
  _EditAnimeScreenState createState() => _EditAnimeScreenState();
}

class _EditAnimeScreenState extends State<EditAnimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  late TextEditingController _titleController;
  late TextEditingController _genreController;
  late TextEditingController _episodesController;
  late TextEditingController _ratingController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _studioController;
  late String _status;

  final List<String> _statusOptions = [
    'Em andamento',
    'Finalizado',
    'Não iniciado',
    'Pausado',
    'Abandonado'
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.anime.title);
    _genreController = TextEditingController(text: widget.anime.genre);
    _episodesController =
        TextEditingController(text: widget.anime.episodes.toString());
    _ratingController =
        TextEditingController(text: widget.anime.rating.toString());
    _descriptionController =
        TextEditingController(text: widget.anime.description);
    _imageUrlController = TextEditingController(text: widget.anime.imageUrl);
    _studioController = TextEditingController(text: widget.anime.studio);
    _status = widget.anime.status;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _genreController.dispose();
    _episodesController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _studioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Anime'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título do Anime',
                  hintText: 'Ex: Naruto',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título do anime';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(
                  labelText: 'Gênero',
                  hintText: 'Ex: Ação, Aventura',
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o gênero';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _episodesController,
                decoration: InputDecoration(
                  labelText: 'Número de Episódios',
                  hintText: 'Ex: 24',
                  prefixIcon: Icon(Icons.tv),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de episódios';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.watch_later),
                  border: OutlineInputBorder(),
                ),
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(
                  labelText: 'Avaliação (0-10)',
                  hintText: 'Ex: 8.5',
                  prefixIcon: Icon(Icons.star),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a avaliação';
                  }
                  final rating = double.tryParse(value);
                  if (rating == null || rating < 0 || rating > 10) {
                    return 'Por favor, insira uma avaliação válida entre 0 e 10';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: 'URL da Imagem',
                  hintText: 'Ex: https://exemplo.com/imagem.jpg',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da imagem';
                  }
                  if (!Uri.tryParse(value)!.isAbsolute) {
                    return 'Por favor, insira uma URL válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _studioController,
                decoration: InputDecoration(
                  labelText: 'Estúdio',
                  hintText: 'Ex: Studio Ghibli',
                  prefixIcon: Icon(Icons.movie),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o estúdio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite uma breve descrição do anime...',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedAnime = Anime(
                      id: widget.anime.id,
                      title: _titleController.text,
                      genre: _genreController.text,
                      episodes: int.parse(_episodesController.text),
                      status: _status,
                      rating: double.parse(_ratingController.text),
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                      studio: _studioController.text,
                    );

                    try {
                      await _databaseHelper.updateAnime(updatedAnime);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Anime atualizado com sucesso!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.pop(context, true);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao atualizar anime: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  'ATUALIZAR ANIME',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
