import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'failures.dart';

abstract class ValueObject<T> extends Equatable {
  Either<Failure, T> get value;

  @override
  List<Object?> get props => [value];

  /// Extracts the value safely to be used in other layers.
  T getValueSafely() {
    return value.fold(
        (_) => throw UnimplementedError('check value validation'), id);
  }
}
