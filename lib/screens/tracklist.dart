import 'package:flutter/material.dart';

class TrackListScreen extends StatefulWidget {

   const TrackListScreen({super.key});

  @override
  State<TrackListScreen> createState() => _TrackListScreenState();
}

class _TrackListScreenState extends State<TrackListScreen> {
  final List<Map<String, dynamic>> borrowList = [
    {
      "id": 1,
      "borrow_uuid": "BRRW-XYZ-00012",
      "book": {
        "title": "Breaking Dawn",
        "author": "Staphan Mayer",
        "description": "This is a fictional book",
        "category_name": "Fictional",
        "for_rent": true,
        "available_for_rent": false,
        "rent_per_day": 2.00,
        "available_for_sell": false,
        "price": 250.00,
        "category_id": 1,
        "total_rent_cost": 48.00,
        "platform_fee": 5.00,
        "subcategories": [
          {"id": 2, "name": "Adventure"},
          {"id": 3, "name": "Thriller"}
        ]
      },
      "renter_information": {
        "name": "ABC Khan",
        "email": "abc@gmail.com",
        "phone": "019111111"
      },
      "address": {
        "name": "John Doe",
        "street_no": "House 321-A",
        "post_code": "1216",
        "district": "Dhaka"
      },
      "status": "processing"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Borrowed Books List'),
      ),
      body: ListView.builder(
        itemCount: borrowList.length,
        itemBuilder: (context, index) {
          final borrowItem = borrowList[index];
          final book = borrowItem['book'];
          final renter = borrowItem['renter_information'];
          final address = borrowItem['address'];

          return Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text('Author: ${book['author']}'),
                  Text('Category: ${book['category_name']}'),
                  Text('Description: ${book['description']}'),
                  SizedBox(height: 10),
                  Text('Renter: ${renter['name']}'),
                  Text('Email: ${renter['email']}'),
                  Text('Phone: ${renter['phone']}'),
                  SizedBox(height: 10),
                  Text(
                      'Address: ${address['name']}, ${address['street_no']}, ${address['post_code']}, ${address['district']}'),
                  SizedBox(height: 10),
                  Text('Status: ${borrowItem['status']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TrackListScreen(),
  ));
}
