import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class SubjectRecord extends FirestoreRecord {
  SubjectRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('subject')
          : FirebaseFirestore.instance.collectionGroup('subject');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('subject').doc(id);

  static Stream<SubjectRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubjectRecord.fromSnapshot(s));

  static Future<SubjectRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubjectRecord.fromSnapshot(s));

  static SubjectRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubjectRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubjectRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubjectRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubjectRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubjectRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubjectRecordData({
  String? name,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubjectRecordDocumentEquality implements Equality<SubjectRecord> {
  const SubjectRecordDocumentEquality();

  @override
  bool equals(SubjectRecord? e1, SubjectRecord? e2) {
    return e1?.name == e2?.name;
  }

  @override
  int hash(SubjectRecord? e) => const ListEquality().hash([e?.name]);

  @override
  bool isValidKey(Object? o) => o is SubjectRecord;
}
