import 'dart:convert';
import 'dart:math';

import 'package:list_offline_first/domain/mappers/mapper.dart';
import 'package:list_offline_first/domain/models/base_entity.dart';
import 'package:list_offline_first/domain/repositories/generic_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenericRepositoryLocalImpl implements GenericRepository {
  final SharedPreferences _sharedPreferences;
  final String keyNamePreferences;
  final Mapper _mapper;

  GenericRepositoryLocalImpl(
    this._sharedPreferences,
    this._mapper, {
    this.keyNamePreferences = 'generic_list',
  });

  @override
  Future<List?> findAll() {
    final List<String>? dataList =
        _sharedPreferences.getStringList(keyNamePreferences);

    final result = dataList
        ?.map((element) => _mapper.fromJson(jsonDecode(element)))
        .toList();

    return result != null ? Future.value(result) : Future.value(null);
  }

  @override
  Future<BaseEntity?> findById(int id) {
    final List<String>? dataList =
        _sharedPreferences.getStringList(keyNamePreferences);

    final result = dataList?.firstWhere(
        (element) => _mapper.fromJson(jsonDecode(element)).id == id);

    return result != null
        ? Future.value(_mapper.fromJson(jsonDecode(result)))
        : Future.value(null);
  }

  @override
  Future<BaseEntity> save(BaseEntity entity) {
    final List<String>? dataList =
        _sharedPreferences.getStringList(keyNamePreferences);
    final r = Random();
    entity.setId(r.nextInt(1000 + (dataList?.length ?? 0)));

    dataList?.add(jsonEncode(entity.toJson()));

    _sharedPreferences.setStringList(keyNamePreferences, dataList ?? []);

    return Future.value(entity);
  }

  @override
  Future<bool> update(int id, BaseEntity entity) {
    final List<String>? dataList =
        _sharedPreferences.getStringList(keyNamePreferences);

    var hasUpdate = false;

    final resultToSave = dataList
        ?.map((element) => _mapper.fromJson(jsonDecode(element)))
        .map((e) {
          if (e.id == id) {
            e.update(entity);
            hasUpdate = true;
          }
          return e;
        })
        .map((e) => jsonEncode(e.toJson()))
        .toList();

    if (hasUpdate) {
      _sharedPreferences.setStringList(keyNamePreferences, resultToSave ?? []);
    }

    return Future.value(hasUpdate);
  }

  @override
  Future delete(int id) async {
    final List<String>? dataList =
        _sharedPreferences.getStringList(keyNamePreferences);

    var hasDelete = false;

    final resultToSave = dataList
        ?.map((element) => _mapper.fromJson(jsonDecode(element)))
        .where((e) {
          if (e.id == id) {
            hasDelete = true;
            return false;
          }
          return true;
        })
        .map((e) => jsonEncode(e.toJson()))
        .toList();

    if (hasDelete) {
      _sharedPreferences.setStringList(keyNamePreferences, resultToSave ?? []);
    }

    return Future.value(hasDelete);
  }
}
