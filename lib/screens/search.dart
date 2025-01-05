import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/utils/routes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allBooks = []; // Stores books with id and title
  List<Map<String, dynamic>> _filteredBooks = [];
  bool _isRentSelected = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBooks(); // Initial fetch for Rent books
  }

  void _filterBooks() {
    setState(() {
      _filteredBooks = _allBooks
          .where((book) => book['title']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _fetchBooks() async {
    setState(() {
      _isLoading = true;
    });
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    try {
      final books = _isRentSelected
          ? await bookProvider.fetchBooksForRent()
          : await bookProvider.fetchBooksForSale();

      setState(() {
        _allBooks = books.data!
            .map((book) => {
                  'id': book.id, // Assuming the API response has an `id` field
                  'title': book.title ?? 'Unknown Title',
                })
            .toList();
        _filteredBooks = _allBooks;
      });
    } catch (e) {
      debugPrint("Error fetching books: $e");
      setState(() {
        _allBooks = [];
        _filteredBooks = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onChipSelected(bool isRentSelected) {
    setState(() {
      _isRentSelected = isRentSelected;
      _searchController.clear();
      _allBooks = [];
      _filteredBooks = [];
    });
    _fetchBooks(); // Fetch new books based on selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _filterBooks();
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Rent'),
                  selected: _isRentSelected,
                  onSelected: (selected) {
                    _onChipSelected(true);
                  },
                ),
                const SizedBox(width: 8.0),
                ChoiceChip(
                  label: const Text('Sale'),
                  selected: !_isRentSelected,
                  onSelected: (selected) {
                    _onChipSelected(false);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _filteredBooks.isEmpty
                        ? const Center(child: Text('No books found'))
                        : ListView.builder(
                            itemCount: _filteredBooks.length,
                            itemBuilder: (context, index) {
                              final book = _filteredBooks[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.bookDetail,
                                    arguments: book['id']
                                        .toString(), // Pass the book ID
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: ListTile(
                                    title: Text(book['title']),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    ),
                                  ),
                                ),
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
