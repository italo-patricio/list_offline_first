import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list_offline_first/domain/models/base_state.dart';
import 'package:list_offline_first/domain/repositories/generic_repository.dart';
import 'package:list_offline_first/presentation/views/todo_list_view_model.dart';

class TodoListPage extends StatefulWidget {
  final GenericRepository sharedRepository;

  const TodoListPage({super.key, required this.sharedRepository});

  @override
  State<TodoListPage> createState() =>
      _TodoListPageState(TodoListViewModel(sharedRepository));
}

class _TodoListPageState extends State<TodoListPage> {
  final TodoListViewModel _todoListViewModel;

  _TodoListPageState(this._todoListViewModel);

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
            final currentState = _todoListViewModel.currentState;
            if (currentState is InitState) {
              return const Center(
                child: Text('Awaiting init'),
              );
            }

            if (currentState is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (currentState is FailureState) {
              return const Center(
                child: Text('Alwesome is wrong, sorry try late again!'),
              );
            }

            if (currentState is EmptyState) {
              return const Center(
                child: Text('Nothing to see'),
              );
            }

            return ListView.builder(
              itemCount: _todoListViewModel.todos.length,
              itemBuilder: (context, i) {
                final item = _todoListViewModel.todos[i];

                return Slidable(
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
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
          }),
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
