import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('');

class FirebaseData {
  static Stream<QuerySnapshot> getAllData(String nameCollection) {
    CollectionReference notesItemCollection =
        _mainCollection.doc().collection('items');
    return notesItemCollection.snapshots();
  }
}
