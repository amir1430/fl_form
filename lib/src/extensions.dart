part of 'fl_formz.dart';

extension FlFormX on BuildContext {
  bool get isFormValid => FlForm.of(this).isValid;
}
