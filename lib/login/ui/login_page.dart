import 'package:day2/home_nav/ui/home_nav.dart';
import 'package:day2/login/controller/login_controller.dart';
import 'package:day2/signup/ui/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AutovalidateMode autovalidateMode;
  late bool passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Image.asset('assets/images/l.webp',height: 250,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    } else if (value!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: const Text("Email"),
                      suffixIcon: const Icon(Icons.email_outlined),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: Colors.lightGreen)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              const BorderSide(color: Colors.lightBlue)))),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    label: const Text("Password"),
                    // suffixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.lightGreen)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.lightBlue))),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
                onPressed: () {
                 validateInput();
                },
                child: const Text("Login")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No Account Yet!"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SignupPage();
                      }));
                    },
                    child: const Text("Sign Up"))
              ],
            )
          ],
        ),
      ),
    );
  }

  void validateInput() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      loginController.loginUser(email: emailController.text,password: passwordController.text);
      // Navigator.push(context,
      // MaterialPageRoute(builder: (BuildContext context){return HomeNav();}));
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }
}
