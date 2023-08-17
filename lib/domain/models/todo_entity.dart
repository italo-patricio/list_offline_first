import 'package:list_offline_first/domain/models/base_entity.dart';

class TodoEntity extends BaseEntity {
  String? title;
  String? description;
  bool done;

  TodoEntity({
    int? id,
    this.title,
    this.description,
    this.done = false,
  }) : super(id ?? -1);

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      done: json['done'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['done'] = done;

    return json;
  }

  @override
  update(model) {
    final entity = (model as TodoEntity);
    title = entity.title;
    description = entity.description;
    done = entity.done;
  }
}
