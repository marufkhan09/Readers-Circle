import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readers_circle/providers/track_provider.dart';

class BorrowListScreen extends StatefulWidget {
  const BorrowListScreen({super.key});

  @override
  State<BorrowListScreen> createState() => _BorrowListScreenState();
}

class _BorrowListScreenState extends State<BorrowListScreen> {
  late TrackProvider provider;

  @override
  void initState() {
    provider = Provider.of<TrackProvider>(context, listen: false);
    provider.fetchBorrowlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borrowList = context.watch<TrackProvider>().isBorrowlistavailable
        ? context.watch<TrackProvider>().trackListModel?.data
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Books'),
      ),
      body: borrowList != null
          ? ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: borrowList.length,
              itemBuilder: (context, index) {
                final borrowItem = borrowList[index];
                final book = borrowItem.book;
                final renter = borrowItem.renterInformation;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book?.title ?? 'Unknown Title',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Author: ${book?.author ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Renter: ${renter?.name ?? 'N/A'}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Status: ${borrowItem.status ?? 'Unknown'}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
