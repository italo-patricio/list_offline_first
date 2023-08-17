import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';
import 'package:list_offline_first/domain/models/base_state.dart';
import 'package:list_offline_first/domain/repositories/generic_repository.dart';

class TodoListViewModel extends ChangeNotifier {
  final GenericRepository _sharedRepository;

  BaseState _currentState = InitState([]);

  final List<TodoItemDto> _todos = [];

  TodoListViewModel(this._sharedRepository);

  List<TodoItemDto> get todos => _todos;

  BaseState get currentState => _currentState;

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

    // _sharedRepository.save(

    // );

    _currentState = SuccessState(todos);

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
