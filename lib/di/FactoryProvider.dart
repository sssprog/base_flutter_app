import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FactoryProvider<T> extends Provider<_Factory<T>> {
  FactoryProvider({super.key, required Create<T> create})
    : super(
        create: (context) {
          return _Factory(() => create(context));
        },
      );
}

class _Factory<T> {
  final T Function() factoryMethod;

  _Factory(this.factoryMethod);

  T call() => factoryMethod();
}

extension AppContextExtensions on BuildContext {
  T readNewInstance<T>() {
    return read<_Factory<T>>()();
  }
}
