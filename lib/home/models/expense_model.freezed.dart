// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) {
  return _ExpenseModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseModel {
  String get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseModelCopyWith<ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseModelCopyWith<$Res> {
  factory $ExpenseModelCopyWith(
          ExpenseModel value, $Res Function(ExpenseModel) then) =
      _$ExpenseModelCopyWithImpl<$Res, ExpenseModel>;
  @useResult
  $Res call(
      {String uid,
      String title,
      String? description,
      double amount,
      DateTime date});
}

/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res, $Val extends ExpenseModel>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? description = freezed,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpenseModelCopyWith<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  factory _$$_ExpenseModelCopyWith(
          _$_ExpenseModel value, $Res Function(_$_ExpenseModel) then) =
      __$$_ExpenseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String title,
      String? description,
      double amount,
      DateTime date});
}

/// @nodoc
class __$$_ExpenseModelCopyWithImpl<$Res>
    extends _$ExpenseModelCopyWithImpl<$Res, _$_ExpenseModel>
    implements _$$_ExpenseModelCopyWith<$Res> {
  __$$_ExpenseModelCopyWithImpl(
      _$_ExpenseModel _value, $Res Function(_$_ExpenseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? title = null,
    Object? description = freezed,
    Object? amount = null,
    Object? date = null,
  }) {
    return _then(_$_ExpenseModel(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpenseModel implements _ExpenseModel {
  _$_ExpenseModel(
      {required this.uid,
      required this.title,
      this.description,
      required this.amount,
      required this.date});

  factory _$_ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseModelFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final String? description;
  @override
  final double amount;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'ExpenseModel(uid: $uid, title: $title, description: $description, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpenseModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, title, description, amount, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpenseModelCopyWith<_$_ExpenseModel> get copyWith =>
      __$$_ExpenseModelCopyWithImpl<_$_ExpenseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseModelToJson(
      this,
    );
  }
}

abstract class _ExpenseModel implements ExpenseModel {
  factory _ExpenseModel(
      {required final String uid,
      required final String title,
      final String? description,
      required final double amount,
      required final DateTime date}) = _$_ExpenseModel;

  factory _ExpenseModel.fromJson(Map<String, dynamic> json) =
      _$_ExpenseModel.fromJson;

  @override
  String get uid;
  @override
  String get title;
  @override
  String? get description;
  @override
  double get amount;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$_ExpenseModelCopyWith<_$_ExpenseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
