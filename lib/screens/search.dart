import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allBooks = ['Book 1', 'Book 2', 'Book 3', 'Book 4'];
  List<String> _filteredBooks = [];
  bool _isRentSelected = true;

  @override
  void initState() {
    super.initState();
    _filteredBooks = _allBooks;
  }

  void _filterBooks() {
    setState(() {
      _filteredBooks = _allBooks
          .where((book) =>
              book.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onChipSelected(bool isRentSelected) {
    setState(() {
      _isRentSelected = isRentSelected;
      _searchController.clear();
      _filteredBooks = _allBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filterBooks();
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: Text('Rent'),
                  selected: _isRentSelected,
                  onSelected: (selected) {
                    _onChipSelected(true);
                  },
                ),
                SizedBox(width: 8.0),
                ChoiceChip(
                  label: Text('Sale'),
                  selected: !_isRentSelected,
                  onSelected: (selected) {
                    _onChipSelected(false);
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredBooks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
