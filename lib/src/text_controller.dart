part of 'fl_form.dart';

final class FlFormTextEditingController extends TextEditingController {
  FlFormTextEditingController({
    required this.name,
    super.text,
    this.validator,
    this.schemaName,
    this.schema,
    this.form,
  }) {
    super.addListener(_listener);
    final inheritedSchema = schema?.schema[schemaName];

    form?.notifier.add(
      text: text,
      validator: inheritedSchema ?? validator!,
      name: name,
    );
  }

  FlFormTextEditingController.fromValue({
    required TextEditingValue value,
    required this.name,
    this.validator,
    this.schemaName,
    this.schema,
    this.form,
  }) : super.fromValue(value) {
    super.addListener(_listener);
    final inheritedSchema = schema?.schema[schemaName];

    form?.notifier.add(
      text: text,
      validator: inheritedSchema ?? validator!,
      name: name,
    );
  }

  final String name;
  final FlSchemaProivder? schema;
  final FlForm? form;
  final String? schemaName;
  final FlValidator? validator;

  String? get errorMessage => form?.notifier.value[name]?.displayError;

  void _listener() {
    final v = schema?.schema[schemaName];

    form?.notifier.add(
      text: text,
      validator: v ?? validator!,
      name: name,
    );
  }

  @override
  void clear() {
    form?.notifier.changeToPure(name);

    super.clear();
  }

  @override
  void dispose() {
    super.removeListener(_listener);
    form?.notifier.remove(name);

    super.dispose();
  }
}
