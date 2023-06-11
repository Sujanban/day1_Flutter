import 'package:day2/login/ui/login_page.dart';
import 'package:day2/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupController signupController = Get.put(SignupController());
  bool passwordVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AutovalidateMode autovalidateMode;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Image.asset(
              'assets/images/l.webp',
              height: 200,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: const Text("Name"),
                      // suffixIcon: const Icon(Icons.remove_red_eye),
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
                controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: const Text("Address"),
                      // suffixIcon: const Icon(Icons.home),
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
            ElevatedButton(onPressed: () {validateInput();}, child: const Text("SignUp")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }));
                      // signupController.signupUser();
                    },
                    child: const Text("Login"))
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
      signupController.signupUser(name: nameController.text,address: addressController.text, email: emailController.text,password: passwordController.text);
      // Navigator.push(context,
      // MaterialPageRoute(builder: (BuildContext context){return HomeNav();}));
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }
}
