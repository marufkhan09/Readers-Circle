import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/widgets/buton.dart';
import 'package:readers_circle/widgets/pass_textfield.dart';
import 'package:readers_circle/widgets/single_selection.dart';
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
  late AuthProvider provider;
  var accountType = ["both", "borrower", "renter"];
  String selectedType = "both";
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    provider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
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
                controller: _firstNameController,
                hint: tr("fName"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("fieldRequired");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: _lastNameController,
                hint: tr("lName"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("fieldRequired");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: _emailController,
                hint: tr("emailHint"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("fieldRequired");
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return tr("invalidEmail");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextInput(
                controller: _phoneController,
                hint: tr("phone"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("fieldRequired");
                  } else if (!RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$')
                      .hasMatch(value)) {
                    return tr("invalidPhone");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              SingleChoice(
                options: accountType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              PasswordInput(
                controller: _passwordController,
                hint: tr("passwordHint"),
                obscureText: _obscurePassword,
                togglePasswordVisibility: _togglePasswordVisibility,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("fieldRequired");
                  }
                  if (value.length < 6) {
                    return tr("passwordTooShort");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              PasswordInput(
                controller: _confirmController,
                hint: tr("confirmPassword"),
                obscureText: _obscureConfirmPassword,
                togglePasswordVisibility: _toggleConfirmPasswordVisibility,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return tr("passwordsDoNotMatch");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CustomActionButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      provider
                          .registerCall(
                        fName: _firstNameController.text,
                        lName: _lastNameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        pass: _passwordController.text,
                        cPass: _confirmController.text,
                        type: selectedType,
                      )
                          .then((value) {
                        if (value == 200 || value == 201) {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginScreen);
                        }
                      });
                    }
                  },
                  child: provider.status == Status.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "register",
                          style: TextStyle(
                              fontSize: 16,
                              color: CustomColors.white,
                              fontWeight: FontWeight.bold),
                        ).tr(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    radius: 50,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text("signIn",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: CustomColors.black))
                          .tr(),
                    ),
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
