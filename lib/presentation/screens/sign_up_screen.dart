import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/application/core/providers.dart';
import 'package:movies/domain/auth/value_objects.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A form field to enter email address
            TextField(
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Email address',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (input) => ref
                  .watch(emailAddressTextProvider.notifier)
                  .state = EmailAddress(input),
            ),
            const SizedBox(height: 16.0),
            // A form field to enter password with obfuscation
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              onChanged: (input) => ref
                  .watch(passwordTextProvider.notifier)
                  .state = Password(input),
            ),
            const SizedBox(height: 32.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              obscureText: true,
              onChanged: (input) => ref
                  .watch(usernameTextProvider.notifier)
                  .state = Username(input),
            ),
            const SizedBox(height: 32.0),

            // A dropdown button for gender input
            DropdownButton<Gender>(
              value: ref.watch(genderEnumProvider),
              hint: const Text('Select your gender'),
              items: Gender.values.map((Gender value) {
                return DropdownMenuItem<Gender>(
                  value: value,
                  child: Text(value.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) {
                ref.watch(genderEnumProvider.notifier).state = value!;
              },
            ),
            const SizedBox(height: 16.0),
            // A button to show a date picker for birthday input
            ElevatedButton(
              child: const Text('Select your birthday'),
              onPressed: () async {
                // Show the date picker and get the selected date
                final dateOfBirth = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                ref.watch(dateOfBirthProvider.notifier).state = dateOfBirth!;
              },
            ),
            const SizedBox(height: 16.0),
            // A button to sign in with email and password
            ElevatedButton(
              onPressed: () {
                final emailAddressStr = ref
                    .read(emailAddressTextProvider.notifier)
                    .state
                    .getValueSafely();
                final passwordStr = ref
                    .read(passwordTextProvider.notifier)
                    .state
                    .getValueSafely();
                final usernameStr = ref
                    .read(usernameTextProvider.notifier)
                    .state
                    .getValueSafely();
                final gender = ref.read(genderEnumProvider.notifier).state.name;
                final dateOfBirth =
                    ref.read(dateOfBirthProvider.notifier).state.toString();
                ref
                    .read(authControllerNotifierProvider.notifier)
                    .signUpWithEmailAndPassword(
                      emailAddressStr: emailAddressStr,
                      passwordStr: passwordStr,
                      usernameStr: usernameStr,
                      gender: gender,
                      dateOfBirth: dateOfBirth,
                    );
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16.0),
            // A button with google symbol to be pressed
            ElevatedButton.icon(
              onPressed: () => ref
                  .read(authControllerNotifierProvider.notifier)
                  .signInWithGoogle(),
              icon: const Text('here!'),
              // icon: Image.asset('assets/images/google_logo.png', height: 24.0),
              label: const Text('Sign In With Google'),
            ),
          ],
        ),
      ),
    );
  }
}
