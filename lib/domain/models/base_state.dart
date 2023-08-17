import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';

abstract class BaseState<T> {
  final List<T> todos;

  BaseState(this.todos);
}

class InitState<T> extends BaseState<T> {
  InitState(super.todos);
}
class LoadingState<T> extends BaseState<T> {
  LoadingState(super.todos);
}
class EmptyState<T> extends BaseState<T> {
  EmptyState(super.todos);
}
class SuccessState<T> extends BaseState<T> {
  SuccessState(super.todos);
}
class FailureState<T> extends BaseState<T> {
  FailureState(super.todos);
}
