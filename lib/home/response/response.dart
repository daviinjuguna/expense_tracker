import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

@freezed
class FirebaseResponse with _$FirebaseResponse {
  factory FirebaseResponse.success(List<DocumentSnapshot> doc) = _Success;
  factory FirebaseResponse.error(String message) = _Error;
}
