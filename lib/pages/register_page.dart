import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tank_tracker_app/components/my_button.dart';
import 'package:tank_tracker_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //sign up method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
    Navigator.pop(context); // Close the loading dialog
    showErrorMessage("Password doesn't match with confirm password");
    return; // Exit the function early
  }
    //try creating the user
    try {
      // Try to sign up
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      Navigator.pop(context); // Close loading dialog
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog
      //show error message
      showErrorMessage(e.code);
      
    }
  }
  //error message to the user
  void showErrorMessage(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 33, 96, 243),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,  // Ensure text is centered
            style: const TextStyle(
              color: Colors.white,  // Change to white for better contrast
              fontSize: 16,  
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
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
                      'Let\'s create your account',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 2, 32, 182),
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 25),
                    //email textbox
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Email address',
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    //password textbox
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    //confirm password textbox
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    
                    const SizedBox(height: 25),
                    MyButton(onTap: signUserUp, text: 'Sign Up'),
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
                          'Already a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login now",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                        )
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
  }

