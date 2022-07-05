import 'package:flutter/foundation.dart';

@immutable
abstract class CloudProvider<DOC, COLL> {
  Future<DOC> create(Map<String, dynamic> map);

  Future<bool> createWithId({
    required String id,
    required Map<String, dynamic> map,
  });

  Stream<DOC> readDoc(String id);
  Future<DOC> readDocFuture(String id);

  Stream<COLL> readCollection();

  Stream<COLL> readCollectionByOrder(String field);

  Stream<COLL> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  });

  Future<bool> update({
    required String id,
    required Map<String, dynamic> json,
  });

  Future<bool> delete({required String id});
}
