import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/book_provider.dart';
import 'package:readers_circle/utils/colors.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/widgets/custom_appbar.dart';

class RentListScreen extends StatefulWidget {
  const RentListScreen({super.key});

  @override
  State<RentListScreen> createState() => _RentListScreenState();
}

class _RentListScreenState extends State<RentListScreen> {
  late BookProvider bookProvider;

  @override
  void initState() {
    bookProvider = Provider.of<BookProvider>(context, listen: false);
    bookProvider.fetchBooksForRent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: tr('Books For Sale'),
      ),
      body: context.watch<BookProvider>().booksForRentLoaded
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount:
                  context.watch<BookProvider>().booksForRent.data!.length,
              itemBuilder: (context, index) {
                final book =
                    context.watch<BookProvider>().booksForRent.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.bookDetail,
                        arguments: book.id.toString());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 16),
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/books.jpg",
                                fit: BoxFit.cover,
                              ),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book.title!,
                                style: const TextStyle(fontSize: 18)),
                            Text(
                              book.author!,
                              style: const TextStyle(
                                  fontSize: 16, color: CustomColors.accent),
                            ),
                            Text(book.price.toString()),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
