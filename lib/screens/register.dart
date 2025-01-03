import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/widgets/buton.dart';
import 'package:readers_circle/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Image.asset("assets/images/icon.png"),
              TextInput(
                onDone: (value) {
                  _firstNameController.text = value!;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                hint: tr("firstName"),
                validateOnInteraction: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                onDone: (value) {
                  _lastNameController.text = value!;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                hint: tr("lastName"),
                validateOnInteraction: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                onDone: (value) {
                  _emailController.text = value!;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                hint: tr("emailHint"),
                validateOnInteraction: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                onDone: (value) {
                  _phoneController.text = value!;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.phone,
                hint: tr("phoneNumber"),
                validateOnInteraction: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CustomActionButton(
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {
                          //   provider.loginCall(
                          //       email: _emailController.text,
                          //       password: _passwordController.text);
                          // }
                        },
                        child: provider.status == Status.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "register",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.bold),
                              ).tr()),
                  );
                },
              ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      radius: 50,
                      onTap: ()  {
                        Navigator.pushReplacementNamed(context, Routes.loginScreen);
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("login",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      color: CustomColors.black))
                              .tr()),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
