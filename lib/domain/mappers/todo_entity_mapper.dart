import 'package:list_offline_first/domain/dtos/todo_item_dto.dart';
import 'package:list_offline_first/domain/mappers/mapper.dart';
import 'package:list_offline_first/domain/models/todo_entity.dart';

class TodoEntityMapper implements Mapper<Map<String, dynamic>, TodoEntity> {
  @override
  TodoEntity fromJson(Map<String, dynamic> input) {
    return TodoEntity.fromJson(input);
  }
}
