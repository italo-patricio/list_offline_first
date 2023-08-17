import 'package:flutter/foundation.dart';
import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';
import 'package:list_offline_first/domain/models/base_state.dart';
import 'package:list_offline_first/domain/models/todo_entity.dart';
import 'package:list_offline_first/domain/repositories/generic_repository.dart';

class TodoListViewModel extends ChangeNotifier {
  final GenericRepository<TodoEntity> _sharedRepository;

  BaseState _currentState = InitState<TodoItemDto>([]);

  final List<TodoEntity> _todos = [];

  TodoListViewModel(this._sharedRepository);

  List<TodoItemDto> get todos => _todos
      .map(
        (e) => TodoItemDto(
          e.id,
          e.title ?? '',
          e.description ?? '',
        ),
      )
      .toList();

  BaseState get currentState => _currentState;

  Future<void> addItem(Map<String, dynamic> value) async {
    final entity = TodoEntity(
      title: value['title'],
      description: value['description'],
    );

    try {
      await _sharedRepository.save(entity);
      _currentState = SuccessState(todos);
    } catch (e) {
      print(e);
      _currentState = FailureState([]);
    }

    notifyListeners();
  }

  removeItem(int id) async {
    _todos.removeWhere((e) => e.id == id);
    await _sharedRepository.delete(id);
    notifyListeners();
  }

  Future<void> loadData() async {
    enableLoading();
    _todos.clear();
    try {
      final results = await _sharedRepository.findAll();
      _todos.addAll(results);
      _currentState = SuccessState(todos);
    } catch (e) {
      print(e);
      _currentState = FailureState([]);
    }
    notifyListeners();
  }

  enableLoading() {
    _currentState = LoadingState([]);
    notifyListeners();
  }
}
