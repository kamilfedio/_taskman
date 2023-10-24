import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dev_model.dart';

class FirestoreService {
  final CollectionReference devs =
      FirebaseFirestore.instance.collection('developers');

  // add new dev : id, username, email
  Future<void> addDev(String id, String username, String email) {
    return devs.add({
      'id': id,
      'username': username,
      'email': email,
    });
  }

  //read data
  Future<List<DevModel>> getDevsList() async {
    try {
      List<DevModel> devsList = [
        DevModel(name: 'Brak przypisania', id: '', email: '')
      ];
      QuerySnapshot devsDocs = await devs.get();

      for (QueryDocumentSnapshot devDoc in devsDocs.docs) {
        Map<String, dynamic> devData = devDoc.data() as Map<String, dynamic>;

        String email = devData['email'];
        String username = devData['username'];
        String id = devData['id'];

        DevModel devModel = DevModel(
          name: username,
          id: id,
          email: email,
        );
        devsList.add(devModel);
      }

      return devsList;
    } catch (e) {
      return [];
    }
  }
}
