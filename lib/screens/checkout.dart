import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readers_circle/models/book_detail_model/book_detail_model.dart';
import 'package:readers_circle/utils/routes.dart';
import 'package:readers_circle/widgets/text_field.dart';
import 'dart:math';
import 'dart:developer' as dev;

class CheckoutPage extends StatefulWidget {
  final dynamic args;
  const CheckoutPage({super.key, required this.args});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _postController = TextEditingController();

  BookDetailModel? book;
  double _pricePerDay = 100; // Example price per day
  String from = "";

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    book = widget.args["book"];
    dev.log(book!.data!.id.toString());
    from = widget.args["from"];
    _pricePerDay =
        book!.data!.rentPerHour!; // Assuming rentPerHour is actually rentPerDay
    dev.log(_pricePerDay.toString());
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _postController.dispose();
    super.dispose();
  }

  void _submitRentForm() {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null) {
      String address = _addressController.text;
      String street = _streetController.text;
      String district = _districtController.text;
      String postCode = _postController.text;

      int days = _endDate!.difference(_startDate!).inDays + 1;
      double totalPrice = days * _pricePerDay;

      // Generate a random 10-digit invoice number
      String invoiceNumber = (Random().nextInt(900000) + 100000).toString();

      // Create a map with the collected data
      Map<String, dynamic> formData = {
        'address[name]': address,
        'address[street_no]': street,
        'address[district]': district,
        'address[post_code]': postCode,
        'start_datetime': DateFormat('yyyy-MM-dd').format(_startDate!),
        'end_datetime': DateFormat('yyyy-MM-dd').format(_endDate!),
        'totalDays': days,
        'totalPrice': totalPrice,
        'invoice': invoiceNumber,
        'bookid': book!.data!.id,
        'from': from
      };

      dev.log(formData.toString());

      Navigator.pushNamed(context, Routes.bkash, arguments: formData);

      // You can now use the formData map as needed
    }
  }

  void _submitOrderForm() {
    if (_formKey.currentState!.validate()) {
      String address = _addressController.text;
      String street = _streetController.text;
      String district = _districtController.text;
      String postCode = _postController.text;

      // Generate a random 10-digit invoice number
      String invoiceNumber = (Random().nextInt(900000) + 100000).toString();

      // Create a map with the collected data
      Map<String, dynamic> formData = {
        'address[name]': address,
        'address[street_no]': street,
        'address[district]': district,
        'address[post_code]': postCode,
        'totalPrice': book!.data!.price.toString(),
        'invoice': invoiceNumber,
        'bookid': book!.data!.id,
        'from': from
      };

      dev.log(formData.toString());

      Navigator.pushNamed(context, Routes.bkash, arguments: formData);

      // You can now use the formData map as needed
    }
  }

  Future<void> _selectDateRange() async {
    DateTimeRange? pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(), // Custom theme if needed
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        _startDate = pickedRange.start;
        _endDate = pickedRange.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String startDateText = _startDate != null
        ? DateFormat('yyyy-MM-dd').format(_startDate!)
        : 'Select Start Date';
    String endDateText = _endDate != null
        ? DateFormat('yyyy-MM-dd').format(_endDate!)
        : 'Select End Date';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextInput(
                  controller: _addressController,
                  hint: "Address Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: _streetController,
                  hint: "Street",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: _districtController,
                  hint: "District",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your district';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextInput(
                  keyboardType: TextInputType.number,
                  controller: _postController,
                  hint: "Post Code",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your post code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                from == "rent"
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: _selectDateRange,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date: $startDateText',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'End Date: $endDateText',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Rent Per day: ৳$_pricePerDay",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _startDate != null && _endDate != null
                                ? 'Total Price: ৳${(_endDate!.difference(_startDate!).inDays + 1) * _pricePerDay}'
                                : 'Select a date range to calculate total price',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      from == "rent" ? _submitRentForm : _submitOrderForm,
                  child: const Text('Proceed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
