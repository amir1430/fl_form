part of 'fl_form.dart';

extension FlFormX on BuildContext {
  bool get isFormValid => FlForm.of(this).isValid;
}
