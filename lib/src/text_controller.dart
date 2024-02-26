part of 'fl_formz.dart';

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
    _sub = _createSubscription();
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
    _sub = _createSubscription();
  }
  late StreamSubscription<FlFormEvent>? _sub;

  final String name;
  final FlSchemaProivder? schema;
  final FlForm? form;
  final String? schemaName;
  final FlValidator? validator;

  String? get errorMessage => form?.notifier.value[name]?.displayError;

  StreamSubscription<FlFormEvent>? _createSubscription() {
    return form?.stream
        .where(
      (event) =>
          event is FlFormTextEditingControllerToPure || event is FlFormToPure,
    )
        .listen((event) {
      clear();
    });
  }

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
    _sub = null;
    _sub?.cancel();

    form?.notifier.remove(name);

    super.dispose();
  }
}
