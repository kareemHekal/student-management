import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../colors_app.dart'; // Import your app_colors

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();
  bool _passwordResetSent = false;

  @override
  void dispose() {
    _emailController.dispose(); // Release the controller
    super.dispose();
  }

  Future passwordReset(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Successfully"),
          content: Text(
            "Reset password link sent successfully! Check your email.",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      setState(() {
        _passwordResetSent = true; // Set the flag to true
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(
            e.message.toString(),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: app_colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: app_colors.orange), // Use your orange color
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: app_colors.green,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/1253.png",
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                textAlign: TextAlign.center,
                "Just enter your email and we will send you a reset password link.",
                style: TextStyle(color: app_colors.white), // Use your blue color
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: TextFormField(

                  cursorColor: app_colors.orange, // Use your blue color
                  style: TextStyle(color:app_colors.white, fontSize: 20),
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle:TextStyle(color: app_colors.white) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: app_colors.orange.withOpacity(0.1), // Use your orange color
                    filled: true,
                    prefixIcon: const Icon(Icons.email, color: app_colors.orange), // Use your orange color
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email';
                    } else if (!value.contains('@') || !value.contains('.')) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  passwordReset(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: app_colors.white, // Use your green color
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 18, color: app_colors.orange),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
