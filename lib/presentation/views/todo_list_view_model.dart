import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';

class TodoListViewModel extends ChangeNotifier {
  final List<TodoItemDto> _todos = [];

  List<TodoItemDto> get todos => _todos;

  addItem() {
    final random = Random();
    final id = random.nextInt(1000);
    _todos.add(
      TodoItemDto(
        id,
        'Item $id',
        'eu sou o item',
      ),
    );

    notifyListeners();
  }

  removeItem(int id) {
    _todos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    addItem();
    addItem();
  }
}
