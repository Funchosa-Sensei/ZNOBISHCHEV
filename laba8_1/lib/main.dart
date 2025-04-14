import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogImage {
  final String url;
  const DogImage({required this.url});

  factory DogImage.fromJson(dynamic json) {
    return DogImage(url: json as String);
  }
}

List<DogImage> parseDogImages(String responseBody) {
  final Map<String, dynamic> parsed = jsonDecode(responseBody);
  final List<dynamic> images = parsed['message'];
  return images.map<DogImage>((json) => DogImage.fromJson(json)).toList();
}

Future<List<DogImage>> fetchDogImages(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://dog.ceo/api/breeds/image/random/50'),
  );
  if (response.statusCode == 200) {
    return compute(parseDogImages, response.body);
  } else {
    throw Exception('Ошибка загрузки изображений собак');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Dog Gallery', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dog Gallery')),
      body: FutureBuilder<List<DogImage>>(
        future: fetchDogImages(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки'));
          } else if (snapshot.hasData) {
            return DogGallery(dogImages: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class DogGallery extends StatelessWidget {
  final List<DogImage> dogImages;
  const DogGallery({Key? key, required this.dogImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: dogImages.length,
      itemBuilder: (context, index) {
        final imageUrl = dogImages[index].url;
        return Card(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder:
                (context, error, stackTrace) => const Icon(Icons.broken_image),
          ),
        );
      },
    );
  }
}
