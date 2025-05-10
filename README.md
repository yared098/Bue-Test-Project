# buedelivery

A new Flutter project.

This Flutter project contains multiple demos
  Progress Bar Demo
  Sidebar Men
  Todo App (using BLoC)
  Articles App (API-based)


  1️⃣ Progress Bar Demo

    void main() {
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomProgressBarDemo()));
    }

  2️⃣ Sidebar Menu
    Uncomment this block in main.dart:

      void main() {
        runApp(
            const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            )
        );
    }
  3️⃣ Todo App with BLoC
    Uncomment this block:

        void main() {
            runApp(TodoApp());
        }
        class TodoApp extends StatelessWidget {
        final TaskRepository repository = TaskRepository();
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlocProvider(
                create: (_) => TaskBloc(repository)..add(LoadTasks()),
                child: const TodoHomePage(),
            ),
            );
          }
        }
    4️⃣ Articles App
      Uncomment this to test article API and UI:
       
        void main() {
            runApp(const ArticleApp());
        }






<!-- screenshots -->
![Fetch data from json placeholder](https://github.com/yared098/Bue-Test-Project/blob/main/screenshots/ONE1.png)




![Fetch data from json placeholder detial](https://github.com/yared098/Bue-Test-Project/blob/main/screenshots/SEVEN1.png)

![Drawer with Fade-In](https://github.com/yared098/Bue-Test-Project/blob/main/screenshots/five1.png)

![Custom Progress Bar](https://github.com/yared098/Bue-Test-Project/blob/main/screenshots/four2.png)


![Todo List](https://github.com/yared098/Bue-Test-Project/blob/main/screenshots/todo1.png)