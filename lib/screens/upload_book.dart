import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/providers/preferences_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/widgets/buton.dart';
import 'package:readers_circle/widgets/custom_appbar.dart';
import 'package:readers_circle/widgets/text_field.dart';

class UploadBookScreen extends StatefulWidget {
  const UploadBookScreen({super.key});

  @override
  State<UploadBookScreen> createState() => _UploadBookScreenState();
}

class _UploadBookScreenState extends State<UploadBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _priceController = TextEditingController();
  final _rentPerDayController = TextEditingController();
  late PrefProvider prefProvider;
  int? categoryIndex; // Updated to nullable
  List<int> selectedSubcategories = [];
  int catId = 0;
  bool isForRent = true;
  bool isAvailableForRent = true;
  bool isAvailableToSell = true;
  late BookProvider bookProvider;

  @override
  void initState() {
    super.initState();
    prefProvider = Provider.of<PrefProvider>(context, listen: false);
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    prefProvider.getPreferences();
  }

  void _toggleSubcategorySelection(int index) {
    setState(() {
      if (selectedSubcategories.contains(index)) {
        selectedSubcategories.remove(index);
      } else {
        selectedSubcategories.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Upload Book"),
      body: SingleChildScrollView(
          child: context.watch<PrefProvider>().preferencesLoaded
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextInput(
                              controller: _titleController,
                              hint: tr("booktitle"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr("fieldRequired");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextInput(
                              controller: _authorController,
                              hint: tr("author"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr("fieldRequired");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextInput(
                              controller: _priceController,
                              hint: tr("price"),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return tr("fieldRequired");
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: CustomColors.black),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Card(
                                elevation: 0.0,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: categoryIndex,
                                    hint: const Text("Choose a category"),
                                    isExpanded: true,
                                    items: List.generate(
                                      context
                                          .read<PrefProvider>()
                                          .preferences
                                          .data!
                                          .length,
                                      (index) {
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(
                                            context
                                                .watch<PrefProvider>()
                                                .preferences
                                                .data![index]
                                                .categoryName!,
                                          ),
                                        );
                                      },
                                    ),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        categoryIndex = newValue;
                                        catId = categoryIndex! + 1;
                                        selectedSubcategories
                                            .clear(); // Reset subcategories
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (categoryIndex != null)
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomColors.black),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text("Choose subcategories")
                                          .tr(), // Header for subcategories
                                    ),
                                    ...context
                                        .watch<PrefProvider>()
                                        .preferences
                                        .data![categoryIndex!]
                                        .subcategories!
                                        .asMap()
                                        .entries
                                        .map(
                                      (entry) {
                                        final index = entry.key;
                                        final subcategory =
                                            entry.value.toString();
                                        return CheckboxListTile(
                                          title: Text(subcategory),
                                          value: selectedSubcategories
                                              .contains(index),
                                          onChanged: (_) {
                                            _toggleSubcategorySelection(index);
                                          },
                                        );
                                      },
                                    ).toList(),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 10),
                            // Variables to track the selected values for each option

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // For Rent
                                const Text(
                                  "For Rent:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("Yes"),
                                        value: true,
                                        groupValue: isForRent,
                                        onChanged: (value) {
                                          setState(() {
                                            isForRent = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("No"),
                                        value: false,
                                        groupValue: isForRent,
                                        onChanged: (value) {
                                          setState(() {
                                            isForRent = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Available for Rent
                                const Text(
                                  "Available for Rent:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("Yes"),
                                        value: true,
                                        groupValue: isAvailableForRent,
                                        onChanged: (value) {
                                          setState(() {
                                            isAvailableForRent = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("No"),
                                        value: false,
                                        groupValue: isAvailableForRent,
                                        onChanged: (value) {
                                          setState(() {
                                            isAvailableForRent = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Available to Buy
                                const Text(
                                  "Available to Buy:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("Yes"),
                                        value: true,
                                        groupValue: isAvailableToSell,
                                        onChanged: (value) {
                                          setState(() {
                                            isAvailableToSell = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<bool>(
                                        title: const Text("No"),
                                        value: false,
                                        groupValue: isAvailableToSell,
                                        onChanged: (value) {
                                          setState(() {
                                            isAvailableToSell = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextInput(
                                  controller: _rentPerDayController,
                                  hint: tr("rentPerDay"),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return tr("fieldRequired");
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomActionButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (categoryIndex == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(tr("selectCategory"))),
                              );
                              return;
                            }
                            if (selectedSubcategories.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(tr("selectSubcategory"))),
                              );
                              return;
                            }

                            Map<String, dynamic> bookData = {
                              "title": _titleController.text,
                              "author": _authorController.text,
                              "price": _priceController.text,
                              "category_id": catId,
                              "subcategory_id[]":
                                  incrementListByOne(selectedSubcategories),
                              "for_rent": isForRent,
                              "available_for_rent": isAvailableForRent,
                              "available_to_sell": isAvailableToSell,
                              "rent_per_day": _rentPerDayController.text,
                            };

                            log(bookData.toString());

                            context
                                .read<BookProvider>()
                                .uploadBookCall(data: bookData)
                                .then((value) {
                              if (value == 200 || value == 201) {
                                showCongratulatoryAlert(context);
                              }
                            });
                          }
                        },
                        child: const Text(
                          "Upload Book",
                          style: TextStyle(color: Colors.white),
                        ).tr(),
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  List<int> incrementListByOne(List<int> numbers) {
    return numbers.map((number) => number + 1).toList();
  }

  void showCongratulatoryAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Congratulations!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Book upload Successful.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            CustomActionButton(
              onTap: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacementNamed(
                    context, Routes.dashboard); // Navigate to dashboard
              },
              child: const Text(
                "Go to Dashboard",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        );
      },
    );
  }
}
