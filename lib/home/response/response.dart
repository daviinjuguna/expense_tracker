import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseResponse {
  final List<DocumentSnapshot> docs;
  final String error;

  //success
  FirebaseResponse.success(this.docs) : error = '';

  //error
  FirebaseResponse.error(this.error) : docs = [];

  bool get isError => error.isNotEmpty && docs.isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseResponse &&
        listEquals(other.docs, docs) &&
        other.error == error;
  }

  @override
  int get hashCode => docs.hashCode ^ error.hashCode;
}
