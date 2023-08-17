import 'package:flutter/material.dart';
import 'package:list_offline_first/data/repositories/local/generic_repository_local_impl.dart';
import 'package:list_offline_first/domain/mappers/todo_entity_mapper.dart';
import 'package:list_offline_first/presentation/views/todo_list_page.dart';
import 'package:list_offline_first/presentation/views/todo_list_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final repository =
      GenericRepositoryLocalImpl(sharedPreferences, TodoEntityMapper());
  final viewModel = TodoListViewModel(repository);

  runApp(TodoApp(
    todoListViewModel: viewModel,
  ));
}

class TodoApp extends StatelessWidget {
  final TodoListViewModel todoListViewModel;
  const TodoApp({super.key, required this.todoListViewModel});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo generic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoListPage(
        todoListViewModel: todoListViewModel,
      ),
    );
  }
}
