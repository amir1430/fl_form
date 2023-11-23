part of 'fl_form.dart';

final class FlFormNotifier extends ValueNotifier<FlFormData> {
  FlFormNotifier() : super({});

  void add({
    required String text,
    required FlValidator validator,
    required String name,
    bool isLock = false,
  }) {
    final currentForm = value[name];

    final form = MapEntry(
      name,
      switch (currentForm) {
        null => FlFormzInput.pure(
            name: name,
            validation: validator,
            value: text,
          ),
        _ => FlFormzInput.dirty(
            name: name,
            validation: validator,
            value: text,
          )
      },
    );

    Future(() {
      value = {...value, form.key: form.value};
    });
  }

  void changeToPure(String name) {
    value = {
      for (final f in value.entries)
        if (f.key == name)
          f.key: FlFormzInput.pure(
            name: name,
            validation: f.value.validation,
          )
        else
          f.key: f.value,
    };
  }

  void remove(String name) {
    value = {
      for (final f in value.entries)
        if (f.key != name) f.key: f.value,
    };
  }
}
