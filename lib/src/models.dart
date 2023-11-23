part of 'fl_form.dart';

final class FlFormzInput extends FormzInput<String, String>
    with FormzInputErrorCacheMixin<String, String> {
  FlFormzInput.pure({
    required this.name,
    required this.validation,
    String value = '',
  }) : super.pure(value);

  FlFormzInput.dirty({
    required this.name,
    required this.validation,
    String value = '',
  }) : super.dirty(value);

  final FlValidator validation;
  final String name;

  @override
  String? validator(String value) => validation(value);
}

typedef FlValidator = String? Function(String value);
typedef FlFormData = Map<String, FlFormzInput>;
typedef FlSchemaData = Map<String, FlValidator>;
