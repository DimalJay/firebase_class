import 'package:cloud_firestore/cloud_firestore.dart';
import 'cloud_provider.dart';

typedef DocumentRef = DocumentSnapshot<Map<String, dynamic>>;
typedef CollectionRef = QuerySnapshot<Map<String, dynamic>>;

class FirebaseCloudProvider
    implements CloudProvider<DocumentRef, CollectionRef> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final String collection;
  FirebaseCloudProvider(this.collection);

  @override
  Future<DocumentRef> create(Map<String, dynamic> map) async =>
      await _firebaseFirestore
          .collection(collection)
          .add(map)
          .then((value) => value.get());

  @override
  Stream<DocumentRef> readDoc(String id) =>
      _firebaseFirestore.collection(collection).doc(id).snapshots();

  @override
  Stream<CollectionRef> readCollectionByFilter(
          {required String field, required String isEqualTo}) =>
      _firebaseFirestore
          .collection(collection)
          .where(field, isEqualTo: isEqualTo)
          .snapshots();

  Future<CollectionRef> readCollectionByFilterFuture(
          {required String field, required String isEqualTo}) =>
      _firebaseFirestore
          .collection(collection)
          .where(field, isEqualTo: isEqualTo)
          .get();

  @override
  Stream<CollectionRef> readCollectionByOrder(String field) =>
      _firebaseFirestore.collection(collection).orderBy(field).snapshots();

  @override
  Future<bool> update(
          {required String id, required Map<String, dynamic> json}) async =>
      await _firebaseFirestore
          .collection(collection)
          .doc(id)
          .update(json)
          .then((value) => true);

  @override
  Future<bool> delete({required String id}) async => await _firebaseFirestore
      .collection(collection)
      .doc(id)
      .delete()
      .then((value) => true);

  @override
  Future<bool> createWithId(
      {required String id, required Map<String, dynamic> map}) async {
    return await _firebaseFirestore
        .collection(collection)
        .doc(id)
        .set(map)
        .then((value) => true);
  }

  @override
  Stream<CollectionRef> readCollection() {
    return _firebaseFirestore.collection(collection).snapshots();
  }

  Future<CollectionRef> readCollectionFuture() {
    return _firebaseFirestore.collection(collection).get();
  }

  @override
  Future<DocumentRef> readDocFuture(String id) {
    return _firebaseFirestore.collection(collection).doc(id).get();
  }
}
