import 'package:barber_app/core/helper/Extension/navigation_extension.dart';
import 'package:barber_app/core/storage/database/database.dart';
import 'package:barber_app/core/storage/preference/shared_preference.dart';
import 'package:barber_app/core/widget/common_btn_widget.dart';
import 'package:barber_app/feature/home/data/view_model/service_model.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.serviceData});

  final ServiceModel serviceData;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String? name, image, email;

  getDataFromSharedPref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getOnTheLoad() async {
    await getDataFromSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s the\njourney begin!',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Image.asset(
                'assets/images/discount.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              widget.serviceData.name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFB4817E),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Set a Date',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFFB4817E),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Set a Time',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        icon: const Icon(
                          Icons.alarm_outlined,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        _selectedTime.format(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: buildMaterialButton(
                context: context,
                color: const Color(0xFFDF711A),
                textColor: Colors.white,
                label: 'BOOK NOW',
                onPressed: () async {
                  Map<String, dynamic> serviceData = {
                    'User Name': name,
                    'User Email': email,
                    'User Image': image,
                    'Service Name': widget.serviceData.name,
                    'Service Price': widget.serviceData.price,
                    'Service Description': widget.serviceData.description,
                    'Service Image': widget.serviceData.image,
                    'Service Date':
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'
                            .toString(),
                    'Service Time': _selectedTime.format(context).toString(),
                  };
                  await DatabaseMethods().addService(serviceData).then(
                    (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Service Booked Successfully'),
                        ),
                      );
                      Navigator.pop(context);
                    },
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
