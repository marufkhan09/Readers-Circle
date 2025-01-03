import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/models/prerenences_model/datum.dart';
import 'package:readers_circle/providers/preferences_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/shared_pref.dart';
import 'package:readers_circle/utils/toast.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final Set<String> selectedPreferences = <String>{};
  bool isLoading = true;
  List<CatDatum> categories = [];
  late PrefProvider provider;
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PrefProvider>(context, listen: false);
    _loadPreferences();
    provider.getSavedLoginResponse();
  }

  Future<void> _loadPreferences() async {
    setState(() {
      isLoading = true;
    });

    try {
      final preferences = await provider.getPreferences();

      setState(() {
        categories = preferences.data!;
      });
    } catch (e) {
      debugPrint("Error loading preferences: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Preferences'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = category.categoryName;
                  final subcategories = category.subcategories;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          spacing: 8.0,
                          children: subcategories!.map<Widget>((subcat) {
                            final isSelected =
                                selectedPreferences.contains(subcat);
                            return ChoiceChip(
                              label: Text(subcat),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedPreferences.add(subcat);
                                  } else {
                                    selectedPreferences.remove(subcat);
                                  }
                                });
                              },
                              selectedColor: CustomColors.primaryLight4,
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedPreferences.length >= 3
            ? () {
                //  Navigator.pushNamed(context, '/dashboard');
                log(selectedPreferences.toString());
                log(provider.loginResponse.toString());
                provider
                    .setPreferences(
                        prefs: selectedPreferences.toList(),
                        id: context
                            .read<PrefProvider>()
                            .loginResponse
                            .data!
                            .id!
                            .toString())
                    .then((val) {
                  if (val == 200 || val == 201) {
                    Navigator.pushNamed(context, Routes.dashboard);
                  }
                });
              }
            : () {
                showMessageToast(
                    message: 'Please select at least 3 preferences');
              },
        label: const Text('Continue'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
