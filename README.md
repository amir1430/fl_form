## add your schema
```dart
class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlSchemaProivder(
      schema: {
        'email': (value) {
          return switch (value) {
            final String text when RegExp(r'^\S+@\S+\.\S+$').hasMatch(text) =>
              null,
            _ => 'Invalid email address'
          };
        },
      },
      child: const MaterialApp(
        home: Scaffold(
          body: MyHome(),
        ),
      ),
    );
  }
}

class MyHome extends HookWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlFormBuilder(
      child: Body(),
    );
  }
}
```

# create FlFormTextEditingController and assign it to textField

```dart
class Body extends HookWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useFlFormTextEditingController(
      name: 'email_controller',
      schemaName: 'email',
    );

    final isFormValid = useIsFormValid();
    final formData = useFormData();

    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            errorText: controller.errorMessage,
          ),
        ),
        FilledButton(
          onPressed: !isFormValid ? null : () {},
          child: const Text('Confirm'),
        ),
        Text(formData.toString()),
      ],
    );
  }
}
```

## Available Hooks
- useFlFormTextEditingController: create auto dispose [FlFormTextEditingController]
- useIsFormValid: check nearest [FlForm] to find out is valid or not
- useFormData: get nearest [FlForm] data in Map format
- useFormValue: get info of given [FlFormTextEditingController] name and return [FlFormzInput?]