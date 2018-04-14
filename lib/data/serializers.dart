import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:monzo_flutter/data/accounts/accounts.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AccountsResponse,
  Account
])
final Serializers serializers = (_$serializers.toBuilder()
    ..addPlugin(new StandardJsonPlugin())
    ..add(new DateTimeSerializer())).build();

class DateTimeSerializer implements PrimitiveSerializer<DateTime> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DateTime]);
  @override
  final String wireName = 'DateTime';

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType: FullType.unspecified}) {
    return DateTime.parse(serialized as String);
  }

  @override
  Object serialize(Serializers serializers, DateTime object,
      {FullType specifiedType: FullType.unspecified}) {
    return object.toIso8601String();
  }
}
