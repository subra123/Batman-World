import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class TutorsRecord extends FirestoreRecord {
  TutorsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "subjects" field.
  List<DocumentReference>? _subjects;
  List<DocumentReference> get subjects => _subjects ?? const [];
  bool hasSubjects() => _subjects != null;

  // "creator" field.
  DocumentReference? _creator;
  DocumentReference? get creator => _creator;
  bool hasCreator() => _creator != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  void _initializeFields() {
    _subjects = getDataList(snapshotData['subjects']);
    _creator = snapshotData['creator'] as DocumentReference?;
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _category = snapshotData['category'] as String?;
    _location = snapshotData['location'] as LatLng?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tutors');

  static Stream<TutorsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TutorsRecord.fromSnapshot(s));

  static Future<TutorsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TutorsRecord.fromSnapshot(s));

  static TutorsRecord fromSnapshot(DocumentSnapshot snapshot) => TutorsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TutorsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TutorsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TutorsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TutorsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTutorsRecordData({
  DocumentReference? creator,
  String? name,
  String? description,
  String? category,
  LatLng? location,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'creator': creator,
      'name': name,
      'description': description,
      'category': category,
      'location': location,
    }.withoutNulls,
  );

  return firestoreData;
}

class TutorsRecordDocumentEquality implements Equality<TutorsRecord> {
  const TutorsRecordDocumentEquality();

  @override
  bool equals(TutorsRecord? e1, TutorsRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.subjects, e2?.subjects) &&
        e1?.creator == e2?.creator &&
        e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.category == e2?.category &&
        e1?.location == e2?.location;
  }

  @override
  int hash(TutorsRecord? e) => const ListEquality().hash([
        e?.subjects,
        e?.creator,
        e?.name,
        e?.description,
        e?.category,
        e?.location
      ]);

  @override
  bool isValidKey(Object? o) => o is TutorsRecord;
}
