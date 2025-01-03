import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<String> bookTypes = [
    'Fiction',
    'Non-Fiction',
    'Mystery',
    'Romance',
    'Science Fiction',
    'Fantasy',
    'Biography',
    'History',
    'Self-Help',
    'Health',
  ];

  final Set<String> selectedBookTypes = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Book Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8.0,
              children: bookTypes.map((type) {
                final isSelected = selectedBookTypes.contains(type);
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedBookTypes.add(type);
                      } else {
                        selectedBookTypes.remove(type);
                      }
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: selectedBookTypes.length >= 3
                  ? () {
                      Navigator.pushNamed(context, '/dashboard');
                    }
                  : null,
              child: Text('Continue to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
