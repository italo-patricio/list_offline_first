import 'package:list_offline_first/domain/models/base_entity.dart';

abstract class Mapper<In extends BaseEntity, Out extends BaseEntity> {
  Out fromJson(In input);
}
