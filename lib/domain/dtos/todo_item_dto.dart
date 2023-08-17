class TodoItemDto {
  final int id;
  final String title;
  final String description;
  final bool done;

  TodoItemDto(this.id, this.title, this.description, {this.done = false});
}
