import 'dart:async';

abstract class Storage<T> {
  Future<T> getValue();

  Future<Null> setValue(T value);
}
