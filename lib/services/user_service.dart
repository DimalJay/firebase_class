import 'package:firebase_class/services/cloud_provider.dart';
import 'package:firebase_class/services/firebase_service.dart';
import 'package:firebase_class/services/user_model.dart';

class UserService implements CloudProvider<UserModel, List<UserModel>> {
  final CloudProvider provider;
  UserService(this.provider);

  factory UserService.firebase() => UserService(
        FirebaseCloudProvider('collection'),
      );

  @override
  Future<UserModel> create(Map<String, dynamic> map) async {
    return UserModel.fromMap(await provider.create(map));
  }

  @override
  Future<bool> createWithId(
      {required String id, required Map<String, dynamic> map}) async {
    return provider.createWithId(id: id, map: map);
  }

  @override
  Future<bool> delete({required String id}) {
    return provider.delete(id: id);
  }

  @override
  Stream<List<UserModel>> readCollection() {
    final snapshots = provider.readCollection() as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<UserModel> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(UserModel.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<UserModel>> readCollectionByFilter({
    required String field,
    required String isEqualTo,
  }) {
    final snapshots = provider.readCollectionByFilter(
        field: field, isEqualTo: isEqualTo) as Stream<CollectionRef>;

    return snapshots.map((snapshot) {
      List<UserModel> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(UserModel.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<List<UserModel>> readCollectionByOrder(String field) {
    final snapshots =
        provider.readCollectionByOrder(field) as Stream<CollectionRef>;
    return snapshots.map((snapshot) {
      List<UserModel> retVal = [];

      for (var element in snapshot.docs) {
        retVal.add(UserModel.fromMap(element));
      }

      return retVal;
    });
  }

  @override
  Stream<UserModel> readDoc(String id) {
    final ref = provider.readDoc(id) as Stream<DocumentRef>;
    return ref.map((value) => UserModel.fromMap(value));
  }

  @override
  Future<UserModel> readDocFuture(String id) async {
    return UserModel.fromMap(await provider.readDocFuture(id));
  }

  @override
  Future<bool> update(
      {required String id, required Map<String, dynamic> json}) {
    return provider.update(id: id, json: json);
  }
}
