import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list_offline_first/presentation/views/todo_list_view_model.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late TodoListViewModel _todoListViewModel;

  _TodoListPageState() {
    _todoListViewModel = TodoListViewModel();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await _todoListViewModel.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: _todoListViewModel,
        builder: (context, _) {
          return ListView.builder(
            itemCount: _todoListViewModel.todos.length,
            itemBuilder: (context, i) {
              final item = _todoListViewModel.todos[i];

              return Slidable(
                endActionPane: ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                      label: 'Remove',
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      onPressed: (_) {
                        removeItem(item.id);
                      })
                ]),
                child: ListTile(
                  title: Text(item.title),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addItem, child: const Icon(Icons.plus_one)),
    );
  }

  void addItem() {
    _todoListViewModel.addItem();
  }

  void removeItem(int id) {
    _todoListViewModel.removeItem(id);
  }
}
