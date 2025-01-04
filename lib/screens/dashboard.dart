import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/models/book_model/datum.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late BookProvider bookProvider;
  @override
  void initState() {
    super.initState();
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.booksForRentLoaded = false;
    bookProvider.booksForSaleLoaded = false;
    bookProvider.fetchBooksForRent();
    bookProvider.fetchBooksForSale();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: CustomColors.primaryLight4,
                size: 40,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.profile);
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for books...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (query) {
                  // Implement search logic
                },
              ),
            ),
          ),
        ),
        body: Consumer<BookProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return provider.booksForRentLoaded && provider.booksForSaleLoaded
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Books to Buy",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.rentinglist);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                      color: CustomColors.primaryLight2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.booksForRent.data!.length < 4
                                ? provider.booksForRent.data!.length
                                : 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final book = provider.booksForRent.data![index];
                              return _buildBookCard(book);
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Books to Sell",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.sellinglist);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                      color: CustomColors.primaryLight2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.booksForSale.data!.length < 4
                                ? provider.booksForSale.data!.length
                                : 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              final book = provider.booksForSale.data![index];
                              return _buildBookCard(book);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildBookCard(BookDatum book) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.bookDetail,
            arguments: book.id.toString());
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  "assets/images/book1.jpeg", // Make sure to add the cover image URL in the Book model
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                book.author!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle buy/sell logic
                },
                child: Text(book.availableForSell!
                    ? "Buy - \$${book.price}"
                    : "Sell - \$${book.price}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
