part of 'fl_form.dart';

class FlFormBuilder extends HookWidget {
  const FlFormBuilder({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final form = useMemoized(FlFormNotifier.new);

    useEffect(() => form.dispose, []);

    return FlForm(
      formNotifier: form,
      child: child,
    );
  }
}

class FlForm extends InheritedNotifier<FlFormNotifier> {
  const FlForm({
    required this.formNotifier,
    required super.child,
    super.key,
  });

  final FlFormNotifier formNotifier;

  @override
  FlFormNotifier get notifier => formNotifier;

  static FlForm of(BuildContext context) {
    final form = context.dependOnInheritedWidgetOfExactType<FlForm>();
    assert(form != null, 'Connot find [FlForm] in given [BuildContext]');

    return form!;
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
