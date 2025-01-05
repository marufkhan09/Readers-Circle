import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/order_provider.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/toast.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const PaymentScreen({super.key, required this.data});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool paymentSuccess = false;
  late OrderProvider orderProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: paymentSuccess == false
            ? SingleChildScrollView(
                child: Card(
                  child: SizedBox(
                    height: 420,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/bkashlogo.png', // Add a mock logo here.
                              height: 80,
                            ),
                          ),
                          const Divider(
                            thickness: 10,
                            color: Colors.pinkAccent,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                width: 1, color: Colors.grey)),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.brown.shade200,
                                        )),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Readers Circle",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                        Text(
                                          "Invoice" +
                                              "${widget.data["invoice"]}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text("৳${widget.data["totalPrice"]}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            color: Colors.pinkAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Your Bkash Account Number ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 48,
                                  child: TextFormField(
                                    controller: _mobileController,

                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign
                                        .center, // Aligns the text in the middle
                                    decoration: const InputDecoration(
                                      filled:
                                          true, // Enables the background color
                                      fillColor: Colors
                                          .white, // Sets the background color to white

                                      labelStyle: TextStyle(
                                          color: Colors
                                              .grey), // Optional, to style the label
                                      hintText: '01XXXXXXXXX',
                                      hintStyle: TextStyle(
                                          color: Colors
                                              .grey), // Optional, to style the hint
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey, // Grey border
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors
                                              .grey, // Grey border for enabled state
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors
                                              .pinkAccent, // Highlight border when focused
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'By clicking on ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Colors.white, // Default text color
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Confirm, ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight
                                                  .bold // Subtle grey color
                                              ),
                                        ),
                                        TextSpan(
                                          text: 'You are agreeing to the ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight
                                                  .bold // Subtle grey color
                                              ),
                                        ),
                                        TextSpan(
                                          text: 'terms & conditions',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight
                                                  .bold // Subtle grey color
                                              ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  showMessageToast(message: "User Cancelled");
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey.shade300,
                                  height: 40,
                                  child: const Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                              Container(
                                width: 1,
                                color: Colors.grey,
                                height: 40,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  if (_mobileController.text != null &&
                                      _mobileController.text.isNotEmpty &&
                                      RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$')
                                          .hasMatch(_mobileController.text)) {
                                    // Input is valid, proceed with logic

                                    if (widget.data["from"] == "rent") {
                                      log("From rent");
                                      context
                                          .read<OrderProvider>()
                                          .rentCall(data: widget.data)
                                          .then((value) {
                                        if (value == 200 || value == 201) {
                                          Navigator.pushReplacementNamed(
                                              context, Routes.confirmation);
                                        } else {
                                          setState(() {
                                            paymentSuccess = true;
                                          });
                                          showMessageToast(message: "Failed");
                                          Navigator.pushReplacementNamed(
                                              context, Routes.dashboard);
                                        }
                                      });
                                    } else {
                                      log("From order");
                                      context
                                          .read<OrderProvider>()
                                          .buyCall(data: widget.data)
                                          .then((value) {
                                        if (value == 200 || value == 201) {
                                          Navigator.pushReplacementNamed(
                                              context, Routes.confirmation);
                                        } else {
                                          setState(() {
                                            paymentSuccess = true;
                                          });
                                          showMessageToast(message: "Failed");
                                          Navigator.pushReplacementNamed(
                                              context, Routes.dashboard);
                                        }
                                      });
                                    }
                                  } else {
                                    // Handle invalid input
                                    showMessageToast(
                                        message: "Invalid phone number");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.grey.shade300,
                                  height: 40,
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
