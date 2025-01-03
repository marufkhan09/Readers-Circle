import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/providers/auth_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool tapped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                //Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInput(
                        onDone: (value) {
                          // Handle email value here
                        },
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        hint: tr("emailHint"),
                        validateOnInteraction: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PasswordInput(
                        onDone: (value) {
                          // Handle password value here
                        },
                        textInputAction: TextInputAction.done,
                        hint: tr("passwordHint"),
                        validateOnInteraction: true, // Validate while typing
                        obscureText: true, // Password is initially hidden
                        showPasswordToggle:
                            true, // Show/hide password toggle button
                      )
                    ],
                  ),
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
                            if (_formKey.currentState!.validate()) {
                              provider.login(
                                  phone: _phoneController.text,
                                  password: _passwordController.text);
                            }
                          },
                          child: provider.status == Status.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "signIn",
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
                      onTap: () async {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return WillPopScope(
                                onWillPop: () async => false,
                                child: AlertDialog(
                                  content: const SizedBox(
                                    height: 120,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                          "Demo",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16, height: 1.5),
                                        )),
                                        SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: CustomColors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Column(
                                        children: [
                                          TextButton(
                                              onPressed: () async {},
                                              child: const Center(
                                                child: Text(
                                                  "Demo",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
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
                        Navigator.pushNamed(context, Routes.register);
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
