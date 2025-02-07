import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tank_tracker_app/components/my_button.dart';
import 'package:tank_tracker_app/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    // Validate inputs
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter Username and Password")),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Try to sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade600), borderRadius: BorderRadius.circular(14.0)),
                child: Center(child: Column(
                  children: [
                    Text("Authentication Error", style: TextStyle(fontWeight: FontWeight.bold)),
                    Center(child: Text(e.toString())),
                  ],
                ))));
          });
      /*// Handle wrong email
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Incorrect Email Address"),
              content: const Text("The email address you entered is not registered."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }

      // Handle wrong password
      else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Incorrect Password"),
              content: const Text("The password you entered is incorrect."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }

      // Handle other errors
      else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(e.message ?? 'An error occurred'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 124, 207, 246),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Icon(
                      Icons.account_circle,
                      color: const Color.fromARGB(255, 2, 32, 182),
                      size: 100.0,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Welcome back to your account',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 2, 32, 182),
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style:
                                TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButton(onTap: signUserIn, text: 'Login'),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
