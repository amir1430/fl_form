import 'package:fl_form/fl_formz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlSchemaProivder(
      schema: {
        // requeired
        'email': (value) {
          return switch (value) {
            final String text when RegExp(r'^\S+@\S+\.\S+$').hasMatch(text) =>
              null,
            _ => 'Invalid email address'
          };
        },

        // requeired
        'password': (value) {
          return switch (value) {
            String(:final length) when length < 12 =>
              'Password must contain 12 char',
            _ => null
          };
        },

        // optional
        'name': (value) {
          return switch (value) {
            String(:final isEmpty) when isEmpty => null,
            String(:final length) when length < 4 => 'Name must contain 4 char',
            _ => null
          };
        },
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Fl Form'),
          ),
          body: const MyHome(),
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

class Body extends HookWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useFlFormTextEditingController(
      name: 'email_controller',
      schemaName: 'email',
    );

    final passController = useFlFormTextEditingController(
      name: 'pass_controller',
      schemaName: 'password',
    );

    final nameController = useFlFormTextEditingController(
      name: 'name_controller',
      schemaName: 'name',
    );

    final isFormValid = useIsFormValid();
    final formData = useFormData();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              errorText: emailController.errorMessage,
              labelText: 'Email *',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: passController,
            decoration: InputDecoration(
              errorText: passController.errorMessage,
              labelText: 'Password *',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              errorText: nameController.errorMessage,
              labelText: 'Name (optional)',
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: !isFormValid ? null : () {},
            child: const Text('Confirm'),
          ),
          const SizedBox(height: 12),
          Text(formData.toString()),
        ],
      ),
    );
  }
}
