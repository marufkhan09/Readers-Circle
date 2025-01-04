import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/widgets/buton.dart';
import 'package:readers_circle/widgets/pass_textfield.dart';
import 'package:readers_circle/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SharedPref sharedPref = SharedPref();
  late AuthProvider provider;
  bool _obscurePassword = true;
  @override
  void initState() {
    super.initState();
    // // Remove the provider initialization from here
    // _emailController.text = "masuda@gmail.com";
    // _passwordController.text = "123456Ma#";
  }

  preferenceCheck() async {
    var count = await sharedPref.readInt("preferences") ?? 0;
    if (count > 0) {
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, Routes.preferences);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the provider in the build method
    provider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: CustomColors.grey,
      appBar: AppBar(
        backgroundColor: CustomColors.grey,
        actions: [
          TextButton(
              onPressed: () {
                // Toggle between en and bn
                Locale newLocale = context.locale.languageCode == 'en'
                    ? const Locale('bn')
                    : const Locale('en');
                context.setLocale(newLocale);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border:
                          Border.all(width: 1, color: CustomColors.secondary)),
                  child: const Text("ln").tr()))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("signIn",
                        style: TextStyle(
                            fontSize: 28,
                            color: CustomColors.black,
                            fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                            fontWeight: FontWeight.bold))
                    .tr(),

                const SizedBox(
                  height: 10,
                ),
                Text("loginSubTitle",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                    )).tr(),

                const SizedBox(
                  height: 50,
                ),
                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(
                        height: 10,
                      ),
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
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomActionButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          provider
                              .loginCall(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((val) {
                            if (val == 200) {
                              preferenceCheck();
                            }
                          });
                        }
                      },
                      child: provider.status == Status.loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "signIn",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.white,
                                  fontWeight: FontWeight.bold),
                            ).tr()),
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      radius: 50,
                      onTap: () async {},
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("forgotPassword",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      color: CustomColors.black))
                              .tr()),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dontHaveAccount",
                            style: TextStyle(
                                fontSize: 14, color: CustomColors.black))
                        .tr(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.register);
                      },
                      child: const Text("register",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: CustomColors.primary,
                                  fontWeight: FontWeight.bold))
                          .tr(),
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
}
