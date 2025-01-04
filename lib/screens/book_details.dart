import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';

class BookDetailsScreen extends StatefulWidget {
  final String id;
  const BookDetailsScreen({super.key, required this.id});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late BookProvider bookProvider;
  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.bookDetaillLoaded = false;
    bookProvider.bookDetails(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var book = context.watch<BookProvider>().bookDetail;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text("Book Details"),
        ),
        body: context.watch<BookProvider>().bookDetaillLoaded
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.data!.title!,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'by${book.data!.author!}',
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 16),
                    Text(
                      book.data!.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Category: ${book.data!.categoryName!}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var subs in book.data!.subcategories!)
                          Text('- $subs'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (book.data!.availableForRent!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available for Rent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Price: \$${book.data!.price}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Renter Information:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Name: ${book.data!.renterInformation!.name}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Email: ${book.data!.renterInformation!.email}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Phone: ${book.data!.renterInformation!.phone}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    if (book.data!.availableForSell!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Available for Sale',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Price: \$${book.data!.price}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
