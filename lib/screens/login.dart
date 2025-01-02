import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/api/helpers/response_status.dart';
import 'package:readers_circle/providers/login_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/widgets/buton.dart';

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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 36.0, right: 36.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("signIn",
                    style: TextStyle(
                        fontSize: 28,
                        color: CustomColors.black,
                        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                        fontWeight: FontWeight.bold)).tr(),

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
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: CustomColors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                          hintText: tr("mobile"),
                          hintStyle: TextStyle(
                              fontSize: 16.0, color: CustomColors.broder),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                                color: CustomColors.broder, width: 0.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<LoginProvider>(context, listen: false)
                                .login(
                                    phone: _phoneController.text,
                                    password: _passwordController.text);
                          }
                        },
                        decoration: InputDecoration(
                            fillColor: CustomColors.white,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                            hintText: tr("promptPassword"),
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: CustomColors.broder,
                                fontWeight: FontWeight.w400),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                  color: CustomColors.button, width: 0.5),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText == true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Can't be empty";
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

                Consumer<LoginProvider>(
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
                )

                //Login Button
                ,
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
                                  color: CustomColors.black)).tr()),
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
