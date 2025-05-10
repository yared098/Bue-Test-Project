import 'package:buedelivery/sidebar/sidebarmenu.dart';
import 'package:buedelivery/progress/linearprogress.dart';
import 'package:buedelivery/articles/Screen/ArticlPage.dart';
import 'package:buedelivery/articles/model/article.dart';
import 'package:buedelivery/articles/services/article_service.dart';
import 'package:buedelivery/Todo/blocs/task_bloc.dart';
import 'package:buedelivery/Todo/data/task_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Todo/screens/home_page.dart' show HomePage, TodoHomePage;


// // for the progress bar
void main() {
runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: CustomProgressBarDemo()));

}



// // for the sidebar menu
// void main() {
// runApp(
//   const MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: HomePage()));
// }



// // for the todo app
// void main() {
//   runApp(TodoApp());
// }
// class TodoApp extends StatelessWidget {
//   final TaskRepository repository = TaskRepository();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (_) => TaskBloc(repository)..add(LoadTasks()),
//         child: const TodoHomePage(),
//       ),
//     );
//   }
// }






// //  for the article app
// void main() {
//   runApp(const ArticleApp());
// }
