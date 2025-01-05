import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/utils/toast.dart';

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
                  // SECTION 1: Book Image
                  _buildBookImageSection(),

                  const SizedBox(height: 16),

                  // SECTION 2: Book Title & Author
                  _buildTitleAndAuthorSection(book),

                  const SizedBox(height: 16),

                  // SECTION 3: Book Description
                  _buildBookDescriptionSection(book),

                  const SizedBox(height: 16),

                  // SECTION 4: Category and Subcategories
                  _buildCategorySection(book),

                  const SizedBox(height: 16),

                  // SECTION 5: Rent Details (If Available)
                  if (book.data!.availableForRent!)
                    _buildRentDetailsSection(book),

                  const SizedBox(height: 16),

                  // SECTION 6: Sale Details (If Available)
                  if (book.data!.availableForSell!)
                    _buildSaleDetailsSection(book),

                  const SizedBox(height: 16),

                  // SECTION 7: Book Now Button
                  _buildBookNowButton(book),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  // Section 1: Book Image
  Widget _buildBookImageSection() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.asset(
          "assets/images/books.jpg",
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Section 2: Book Title & Author
  Widget _buildTitleAndAuthorSection(book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  // Section 3: Book Description
  Widget _buildBookDescriptionSection(book) {
    return Text(
      book.data!.description!,
      style: const TextStyle(fontSize: 18, color: CustomColors.neutralDark),
    );
  }

  // Section 4: Category and Subcategories
  Widget _buildCategorySection(book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Text(
                '- ${subs.name}',
                style: TextStyle(fontSize: 16, color: CustomColors.greyDark),
              ),
          ],
        ),
      ],
    );
  }

  // Section 5: Rent Details
  Widget _buildRentDetailsSection(book) {
    return Card(
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
                  fontSize: 16, color: CustomColors.primaryDark),
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
              style: TextStyle(fontSize: 16, color: CustomColors.greyDark),
            ),
            Text(
              'Email: ${book.data!.renterInformation!.email}',
              style: TextStyle(fontSize: 16, color: CustomColors.greyDark),
            ),
            Text(
              'Phone: ${book.data!.renterInformation!.phone}',
              style: TextStyle(fontSize: 16, color: CustomColors.greyDark),
            ),
          ],
        ),
      ),
    );
  }

  // Section 6: Sale Details
  Widget _buildSaleDetailsSection(book) {
    return Card(
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
                  fontSize: 16, color: CustomColors.primaryDark),
            ),
          ],
        ),
      ),
    );
  }

  // Section 7: Book Now Button
  Widget _buildBookNowButton(book) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Add booking logic here
              log("Available");
              Navigator.pushNamed(context,Routes.checkout);
              if (book.data!.availableForRent!) {
              } else {
                showMessageToast(message: "Not Available for rent now!!");
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: CustomColors.primaryLight,
            ),
            child: const Text(
              'Rent Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Add booking logic here
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
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
    );
  }
}
