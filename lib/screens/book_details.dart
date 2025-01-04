import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:readers_circle/utils/colors.dart';

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
        iconTheme: const IconThemeData(color: CustomColors.onPrimary),
        title: const Text("Book Details"),
        backgroundColor: CustomColors.primary,
      ),
      body: context.watch<BookProvider>().bookDetaillLoaded
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Book Image Section
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        "assets/images/books.jpg",
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Book Title and Author
                  Text(
                    book.data!.title!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'by ${book.data!.author!}',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: CustomColors.greyDark,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Book Description
                  Text(
                    book.data!.description!,
                    style: const TextStyle(
                        fontSize: 18, color: CustomColors.neutralDark),
                  ),
                  const SizedBox(height: 16),

                  // Category and Subcategories
                  Text(
                    'Category: ${book.data!.categoryName!}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var subs in book.data!.subcategories!)
                        Text('- ${subs.name}',
                            style: TextStyle(
                                fontSize: 16, color: CustomColors.greyDark)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Rent Details
                  if (book.data!.availableForRent!)
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available for Rent',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: \$${book.data!.price}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.primaryDark),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Renter Information:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primary,
                              ),
                            ),
                            Text(
                              'Name: ${book.data!.renterInformation!.name}',
                              style: TextStyle(
                                  fontSize: 16, color: CustomColors.greyDark),
                            ),
                            Text(
                              'Email: ${book.data!.renterInformation!.email}',
                              style: TextStyle(
                                  fontSize: 16, color: CustomColors.greyDark),
                            ),
                            Text(
                              'Phone: ${book.data!.renterInformation!.phone}',
                              style: TextStyle(
                                  fontSize: 16, color: CustomColors.greyDark),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Sale Details
                  if (book.data!.availableForSell!)
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Available for Sale',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: \$${book.data!.price}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: CustomColors.primaryDark),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Book Now Button with Styling
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add booking logic here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: CustomColors.primaryLight,
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
