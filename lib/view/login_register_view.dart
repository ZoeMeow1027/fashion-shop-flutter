import 'package:fashionshop/ui/widget/outlined_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Login"), // TODO
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
                text: 'Username', controller: usernameController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
                text: 'Password', controller: passwordController),
          ),
          CheckboxListTile(
            title: const Text("Remember me?"),
            value: rememberLogin,
            onChanged: (newValue) {
              setState(() {
                rememberLogin = !rememberLogin;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    50), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text("Login"),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Forgot your account?',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // TODO: Forget your account?
                    },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign in with Google"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign in with Facebook"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    50), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text("No accounts? Register"),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Register"), // TODO
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
              text: 'Username',
              controller: usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
              text: 'Email',
              controller: emailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
              text: 'Password',
              controller: passwordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: customOutlinedTextField(
              text: 'Re-enter password',
              controller: reEnterPasswordController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                    50), // fromHeight use double.infinity as width and 40 is the height
              ),
              child: const Text("Register"),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Login now',
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign in with Google"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign in with Facebook"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
