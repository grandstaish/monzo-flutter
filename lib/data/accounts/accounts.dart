import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'accounts.g.dart';

abstract class AccountsResponse implements Built<AccountsResponse, AccountsResponseBuilder> {
  static Serializer<AccountsResponse> get serializer => _$accountsResponseSerializer;

  BuiltList<Account> get accounts;

  AccountsResponse._();
  factory AccountsResponse([updates(AccountsResponseBuilder b)]) = _$AccountsResponse;
}

abstract class Account implements Built<Account, AccountBuilder> {
  static Serializer<Account> get serializer => _$accountSerializer;

  String get id;

  DateTime get created;

  String get description;

  @nullable
  @BuiltValueField(wireName: 'sort_code')
  String get sortCode;

  @nullable
  @BuiltValueField(wireName: 'account_number')
  String get accountNumber;

  Account._();
  factory Account([updates(AccountBuilder b)]) = _$Account;
}
