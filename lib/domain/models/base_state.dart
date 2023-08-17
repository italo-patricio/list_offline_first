import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';

abstract class BaseState {
  final List<TodoItemDto> todos;

  BaseState(this.todos);
}

class InitState extends BaseState {
  InitState(super.todos);
}
class LoadingState extends BaseState {
  LoadingState(super.todos);
}
class EmptyState extends BaseState {
  EmptyState(super.todos);
}
class SuccessState extends BaseState {
  SuccessState(super.todos);
}
class FailureState extends BaseState {
  FailureState(super.todos);
}
