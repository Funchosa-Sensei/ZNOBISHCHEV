import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лента новостей КубГАУ',
      theme: ThemeData(primarySwatch: Colors.green),
      home: NewsScreen(),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: Bidi.stripHtmlIfNeeded(json['TITLE'] ?? ''),
      date: json['ACTIVE_FROM'] ?? '',
      description: Bidi.stripHtmlIfNeeded(json['PREVIEW_TEXT'] ?? ''),
      imageUrl: json['PREVIEW_PICTURE_SRC'] ?? '',
    );
  }
}

class NewsResponse {
  final List<NewsItem> newsItems;

  NewsResponse({required this.newsItems});

  factory NewsResponse.fromJson(dynamic json) {
    if (json is List) {
      final items =
          json
              .map((item) => NewsItem.fromJson(item as Map<String, dynamic>))
              .toList();
      return NewsResponse(newsItems: items);
    }
    if (json is Map<String, dynamic> && json.containsKey('news')) {
      final newsArray = json['news'] as List<dynamic>;
      final items =
          newsArray
              .map((item) => NewsItem.fromJson(item as Map<String, dynamic>))
              .toList();
      return NewsResponse(newsItems: items);
    }
    return NewsResponse(newsItems: []);
  }
}

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsItem>> futureNews;

  Future<List<NewsItem>> fetchNews() async {
    final url =
        'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final newsResponse = NewsResponse.fromJson(decodedData);
        return newsResponse.newsItems;
      } else {
        throw Exception('Ошибка загрузки новостей: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Не удалось получить новости: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Лента новостей КубГАУ')),
      body: FutureBuilder<List<NewsItem>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет новостей'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final newsItem = newsList[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (newsItem.imageUrl.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Image.network(
                              newsItem.imageUrl,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'Ошибка загрузки изображения',
                                );
                              },
                            ),
                          ),
                        Text(
                          newsItem.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          newsItem.date,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(newsItem.description),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
