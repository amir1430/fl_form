part of 'fl_formz.dart';

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

    if ((currentForm?.isPure ?? true) && !form.value.isPure && text.isEmpty) {
      return;
    }

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

  void changeAllToPure() {
    value = {
      for (final f in value.entries)
        f.key: FlFormzInput.pure(
          name: f.value.name,
          validation: f.value.validation,
        ),
    };
  }

  void remove(String name) {
    value = {
      for (final f in value.entries)
        if (f.key != name) f.key: f.value,
    };
  }
}
