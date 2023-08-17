import 'package:list_offline_first/domain/models/base_entity.dart';

abstract class GenericRepository {
  Future save(BaseEntity entity);
  Future findAll();
  Future findById(int id);
  Future update(int id, BaseEntity entity);
  Future delete(int id);
}
