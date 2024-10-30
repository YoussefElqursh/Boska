import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addService(Map<String, dynamic> serviceData) async {
    return await FirebaseFirestore.instance
        .collection('Services')
        .add(serviceData);
  }

  Future<Stream<QuerySnapshot>> getServices() async {
    return FirebaseFirestore.instance
        .collection('Services')
        .orderBy("Service Time", descending: true)
        .where('Service Date', isEqualTo: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}')
        .snapshots();
  }

  finishBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection('Services')
        .doc(id)
        .delete();
  }
}