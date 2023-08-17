import 'package:flutter/material.dart';
import 'package:list_offline_first/data/repositories/local/generic_repository_local_impl.dart';
import 'package:list_offline_first/domain/mappers/todo_entity_mapper.dart';
import 'package:list_offline_first/presentation/views/todo_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      
  runApp(TodoApp(
    sharedPreferences: sharedPreferences,
  ));
}

class TodoApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const TodoApp({super.key, required this.sharedPreferences});

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
        sharedRepository:
            GenericRepositoryLocalImpl(sharedPreferences, TodoEntityMapper()),
      ),
    );
  }
}
