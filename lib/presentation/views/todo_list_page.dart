import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:list_offline_first/domain/models/base_state.dart';
import 'package:list_offline_first/presentation/views/bottom_sheet_input/bottom_sheet_widget.dart';
import 'package:list_offline_first/presentation/views/todo_list_view_model.dart';

class TodoListPage extends StatefulWidget {
  final TodoListViewModel todoListViewModel;

  const TodoListPage({super.key, required this.todoListViewModel});

  @override
  State<TodoListPage> createState() =>
      // ignore: no_logic_in_create_state
      _TodoListPageState(todoListViewModel);
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
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await _todoListViewModel.loadData();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
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

            if (currentState is EmptyState ||
                _todoListViewModel.todos.isEmpty) {
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
          onPressed: () => addItem(context), child: const Icon(Icons.plus_one)),
    );
  }

  void addItem(context) {
    _settingModalBottomSheet(context);
  }

  void removeItem(int id) {
    _todoListViewModel.removeItem(id);
  }

  _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BottomSheetInput(
            onSave: (value) async {
              await _todoListViewModel.addItem(value);
              _todoListViewModel.loadData();
              Navigator.pop(context);
            },
            onCancel: () => Navigator.pop(context),
          );
        });
  }
}
