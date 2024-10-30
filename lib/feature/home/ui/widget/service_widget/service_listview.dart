import 'package:barber_app/feature/home/data/collections/service_collection.dart';
import 'package:barber_app/feature/home/ui/widget/service_widget/service_item.dart';
import 'package:barber_app/feature/service/ui/service_screen.dart';
import 'package:flutter/material.dart';

class ServiceListview extends StatefulWidget {
  const ServiceListview({super.key});

  @override
  State<ServiceListview> createState() => _ServiceListviewState();
}

class _ServiceListviewState extends State<ServiceListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.0,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceScreen(serviceData: serviceCollection[index],),
              ),
            );
          },
          child: ServiceItem(
            serviceCollection: serviceCollection[index],
          ),
        ),
        itemCount: serviceCollection.length,
      ),
    );
  }
}
