abstract class BaseEntity {
  int id;

  BaseEntity(this.id);

  @override
  bool operator ==(o) => o is BaseEntity && o.id == id;

  update(BaseEntity model);
  Map<String, dynamic> toJson();
  setId(int value) {
    id = value;
  }
}
