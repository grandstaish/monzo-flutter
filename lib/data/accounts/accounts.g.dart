// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<AccountsResponse> _$accountsResponseSerializer =
    new _$AccountsResponseSerializer();
Serializer<Account> _$accountSerializer = new _$AccountSerializer();

class _$AccountsResponseSerializer
    implements StructuredSerializer<AccountsResponse> {
  @override
  final Iterable<Type> types = const [AccountsResponse, _$AccountsResponse];
  @override
  final String wireName = 'AccountsResponse';

  @override
  Iterable serialize(Serializers serializers, AccountsResponse object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'accounts',
      serializers.serialize(object.accounts,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Account)])),
    ];

    return result;
  }

  @override
  AccountsResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new AccountsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accounts':
          result.accounts.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(Account)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$AccountSerializer implements StructuredSerializer<Account> {
  @override
  final Iterable<Type> types = const [Account, _$Account];
  @override
  final String wireName = 'Account';

  @override
  Iterable serialize(Serializers serializers, Account object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'created',
      serializers.serialize(object.created,
          specifiedType: const FullType(DateTime)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    if (object.sortCode != null) {
      result
        ..add('sort_code')
        ..add(serializers.serialize(object.sortCode,
            specifiedType: const FullType(String)));
    }
    if (object.accountNumber != null) {
      result
        ..add('account_number')
        ..add(serializers.serialize(object.accountNumber,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Account deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new AccountBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sort_code':
          result.sortCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'account_number':
          result.accountNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$AccountsResponse extends AccountsResponse {
  @override
  final BuiltList<Account> accounts;

  factory _$AccountsResponse([void updates(AccountsResponseBuilder b)]) =>
      (new AccountsResponseBuilder()..update(updates)).build();

  _$AccountsResponse._({this.accounts}) : super._() {
    if (accounts == null)
      throw new BuiltValueNullFieldError('AccountsResponse', 'accounts');
  }

  @override
  AccountsResponse rebuild(void updates(AccountsResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountsResponseBuilder toBuilder() =>
      new AccountsResponseBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AccountsResponse) return false;
    return accounts == other.accounts;
  }

  @override
  int get hashCode {
    return $jf($jc(0, accounts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AccountsResponse')
          ..add('accounts', accounts))
        .toString();
  }
}

class AccountsResponseBuilder
    implements Builder<AccountsResponse, AccountsResponseBuilder> {
  _$AccountsResponse _$v;

  ListBuilder<Account> _accounts;
  ListBuilder<Account> get accounts =>
      _$this._accounts ??= new ListBuilder<Account>();
  set accounts(ListBuilder<Account> accounts) => _$this._accounts = accounts;

  AccountsResponseBuilder();

  AccountsResponseBuilder get _$this {
    if (_$v != null) {
      _accounts = _$v.accounts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountsResponse other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AccountsResponse;
  }

  @override
  void update(void updates(AccountsResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AccountsResponse build() {
    _$AccountsResponse _$result;
    try {
      _$result = _$v ?? new _$AccountsResponse._(accounts: accounts.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'accounts';
        accounts.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AccountsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Account extends Account {
  @override
  final String id;
  @override
  final DateTime created;
  @override
  final String description;
  @override
  final String sortCode;
  @override
  final String accountNumber;

  factory _$Account([void updates(AccountBuilder b)]) =>
      (new AccountBuilder()..update(updates)).build();

  _$Account._(
      {this.id,
      this.created,
      this.description,
      this.sortCode,
      this.accountNumber})
      : super._() {
    if (id == null) throw new BuiltValueNullFieldError('Account', 'id');
    if (created == null)
      throw new BuiltValueNullFieldError('Account', 'created');
    if (description == null)
      throw new BuiltValueNullFieldError('Account', 'description');
  }

  @override
  Account rebuild(void updates(AccountBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountBuilder toBuilder() => new AccountBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Account) return false;
    return id == other.id &&
        created == other.created &&
        description == other.description &&
        sortCode == other.sortCode &&
        accountNumber == other.accountNumber;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), created.hashCode),
                description.hashCode),
            sortCode.hashCode),
        accountNumber.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Account')
          ..add('id', id)
          ..add('created', created)
          ..add('description', description)
          ..add('sortCode', sortCode)
          ..add('accountNumber', accountNumber))
        .toString();
  }
}

class AccountBuilder implements Builder<Account, AccountBuilder> {
  _$Account _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _created;
  DateTime get created => _$this._created;
  set created(DateTime created) => _$this._created = created;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _sortCode;
  String get sortCode => _$this._sortCode;
  set sortCode(String sortCode) => _$this._sortCode = sortCode;

  String _accountNumber;
  String get accountNumber => _$this._accountNumber;
  set accountNumber(String accountNumber) =>
      _$this._accountNumber = accountNumber;

  AccountBuilder();

  AccountBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _created = _$v.created;
      _description = _$v.description;
      _sortCode = _$v.sortCode;
      _accountNumber = _$v.accountNumber;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Account other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Account;
  }

  @override
  void update(void updates(AccountBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Account build() {
    final _$result = _$v ??
        new _$Account._(
            id: id,
            created: created,
            description: description,
            sortCode: sortCode,
            accountNumber: accountNumber);
    replace(_$result);
    return _$result;
  }
}
