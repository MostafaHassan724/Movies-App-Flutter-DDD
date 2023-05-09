import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {}
}

class _AuthPageState extends State<AuthPage> {
  // Declare the text controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Declare a boolean variable to indicate the loading state
  bool _isLoading = false;

  // Declare a method to handle the sign in logic
  void _signIn() async {
    // Get the email and password from the text controllers
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Validate the input fields
    if (email.isEmpty || password.isEmpty) {
      // Show a snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Set the loading state to true and update the UI
    setState(() {
      _isLoading = true;
    });

    // TODO: Implement the sign in logic using your preferred authentication service

    // Set the loading state to false and update the UI
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add a logo to the page
              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 16),
              // Add a text field for email input
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              // Add a text field for password input
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // Add a button to trigger the sign in method
              ElevatedButton(
                onPressed: _signIn,
                child: Text('Sign In'),
              ),
              // Add a circular progress indicator to show the loading state
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
