import 'package:buedelivery/Todo/Model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../data/task_model.dart';
import '../data/task_repository.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  AddTask(this.title);
}

class DeleteTask extends TaskEvent {
  final int id;
  DeleteTask(this.id);
}

class ToggleComplete extends TaskEvent {
  final Task task;
  ToggleComplete(this.task);
}

class TaskState {
  final List<Task> tasks;
  TaskState(this.tasks);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskState([])) {
    on<LoadTasks>((event, emit) async {
      final tasks = await repository.getTasks();
      emit(TaskState(tasks));
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(Task(title: event.title));
      add(LoadTasks());
    });

    on<DeleteTask>((event, emit) async {
     print('Deleting task with ID ${event.id}');
      await repository.deleteTask(event.id);
      print('Task with ID ${event.id} deleted');
      add(LoadTasks());
    });

    on<ToggleComplete>((event, emit) async {
      final updated = Task(
        id: event.task.id,
        title: event.task.title,
        isCompleted: !event.task.isCompleted,
      );
      await repository.updateTask(updated);
      add(LoadTasks());
    });
  }
}
