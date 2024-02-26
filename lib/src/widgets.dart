part of 'fl_formz.dart';

class FlFormBuilder extends HookWidget {
  const FlFormBuilder({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final form = useMemoized(FlFormNotifier.new);
    final controller = useStreamController<FlFormEvent>();

    useEffect(() => form.dispose, []);
    useEffect(() => controller.close, []);

    return FlForm(
      formNotifier: form,
      controller: controller,
      child: child,
    );
  }
}

class FlForm extends InheritedNotifier<FlFormNotifier> {
  const FlForm({
    required this.formNotifier,
    required StreamController<FlFormEvent> controller,
    required super.child,
    super.key,
  }) : _controller = controller;

  final FlFormNotifier formNotifier;
  final StreamController<FlFormEvent> _controller;

  @override
  FlFormNotifier get notifier => formNotifier;

  Stream<FlFormEvent> get stream => _controller.stream;

  static FlForm of(BuildContext context) {
    final form = context.dependOnInheritedWidgetOfExactType<FlForm>();
    assert(form != null, 'Connot find [FlForm] in given [BuildContext]');

    return form!;
  }

  void toPure({String? name}) {
    final event = name == null
        ? FlFormToPure()
        : FlFormTextEditingControllerToPure(name: name);

    if (name != null) {
      _controller.add(event);
      notifier.changeToPure(name);

      return;
    }

    _controller.add(event);
    notifier.changeAllToPure();
  }

  bool get isValid {
    final values = notifier.value.values;

    if (values.isEmpty) {
      return false;
    }
    return Formz.validate([...values]);
  }

  @override
  bool updateShouldNotify(FlForm oldWidget) {
    return true;
  }
}

class FlSchemaProivder extends InheritedWidget {
  const FlSchemaProivder({
    required super.child,
    super.key,
    this.schema = const {},
  });

  final FlSchemaData schema;

  static FlSchemaProivder? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FlSchemaProivder>();
  }

  @override
  bool updateShouldNotify(FlSchemaProivder oldWidget) {
    return true;
  }
}
