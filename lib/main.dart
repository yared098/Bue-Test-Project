import 'package:buedelivery/Q4/question4.dart';
import 'package:buedelivery/Q4/question5.dart';
import 'package:buedelivery/Q7/model/article.dart';
import 'package:buedelivery/Q7/services/article_service.dart';
// import 'package:buedelivery/Q4/question5.dart';
import 'package:buedelivery/Todo/blocs/task_bloc.dart';
import 'package:buedelivery/Todo/data/task_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() {
// for question 4
// runApp(const MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: CustomProgressBarDemo()));
// for question 5
// runApp(const MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: HomePage()));

// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'Todo/screens/home_page.dart' show HomePage;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final TaskRepository repository = TaskRepository();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (_) => TaskBloc(repository)..add(LoadTasks()),
//         child: const HomePage(),
//       ),
//     );
//   }
// }



// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticlePage());
  }
}

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  final ArticleService _service = ArticleService();
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = _service.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder:
                        (_) => CupertinoAlertDialog(
                          title: Text(article.title),
                          content: Text(article.body),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Close'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.body,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
