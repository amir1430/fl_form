part of 'fl_formz.dart';

bool useIsFormValid() {
  final context = useContext();
  return context.isFormValid;
}

Map<String, FlFormzInput> useFormData() {
  final context = useContext();
  final notifier = FlForm.of(context).notifier;

  final formNotifier = useValueNotifier(notifier);

  return formNotifier.value.value;
}

FlFormzInput? useFormValue(String name) {
  return useFormData()[name];
}

FlForm? useFlForm() {
  final context = useContext();
  return FlForm.of(context);
}

class _FlFormTextEditingControllerCreator {
  const _FlFormTextEditingControllerCreator();
  FlFormTextEditingController call({
    required String name,
    String? text,
    FlValidator? validator,
    String? schemaName,
    List<Object>? keys,
  }) {
    return use(
      _FlFormTextEditingControllerHook(
        text: text,
        name: name,
        validator: validator,
        schemaName: schemaName,
        keys: keys,
      ),
    );
  }

  FlFormTextEditingController fromValue({
    required TextEditingValue value,
    required String name,
    FlValidator? validator,
    String? schemaName,
    List<Object>? keys,
  }) {
    return use(
      _FlFormTextEditingControllerHook.fromValue(
        value: value,
        name: name,
        validator: validator,
        schemaName: schemaName,
        keys: keys,
      ),
    );
  }
}

const useFlFormTextEditingController = _FlFormTextEditingControllerCreator();

class _FlFormTextEditingControllerHook
    extends Hook<FlFormTextEditingController> {
  const _FlFormTextEditingControllerHook({
    required this.text,
    required this.name,
    required this.validator,
    required this.schemaName,
    required super.keys,
  }) : value = null;

  const _FlFormTextEditingControllerHook.fromValue({
    required this.value,
    required this.name,
    required this.validator,
    required this.schemaName,
    required super.keys,
  }) : text = null;

  final String name;
  final TextEditingValue? value;
  final String? text;
  final FlValidator? validator;
  final String? schemaName;

  @override
  HookState<FlFormTextEditingController, Hook<FlFormTextEditingController>>
      createState() => __FlFormTextEditingControllerHookState();
}

class __FlFormTextEditingControllerHookState extends HookState<
    FlFormTextEditingController, _FlFormTextEditingControllerHook> {
  late final _controller = hook.value != null
      ? FlFormTextEditingController.fromValue(
          value: hook.value!,
          name: hook.name,
          validator: hook.validator,
          form: FlForm.of(context),
          schema: FlSchemaProivder.of(context),
          schemaName: hook.schemaName,
        )
      : FlFormTextEditingController(
          name: hook.name,
          schemaName: hook.schemaName,
          text: hook.text,
          validator: hook.validator,
          form: FlForm.of(context),
          schema: FlSchemaProivder.of(context),
        );

  @override
  FlFormTextEditingController build(BuildContext context) => _controller;

  @override
  void dispose() => _controller.dispose();

  @override
  String? get debugLabel => 'useFlFormTextEditingController';
}
