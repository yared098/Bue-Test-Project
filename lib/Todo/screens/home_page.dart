import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'New Task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<TaskBloc>().add(AddTask(controller.text));
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state.tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet'));
                }
                return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) {
                          context.read<TaskBloc>().add(ToggleComplete(task));
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(task.id!));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
