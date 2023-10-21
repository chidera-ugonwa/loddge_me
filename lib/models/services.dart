import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Services {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get currentUser => auth.currentUser;

  Future saveListingsToFireStore(
      String name,
      String price,
      List urls,
      String aboutOwner,
      String description,
      String directions,
      String locatedAt,
      List amenities,
      String availability,
      String cancellationPolicy,
      String safetyAndProperty) async {
    await firestore
        .collection('bookmarks')
        .doc(currentUser!.uid)
        .collection('favorites')
        .doc(name)
        .set({
      'name': name,
      'price': price,
      'urls': urls,
      'about_owner': aboutOwner,
      'description': description,
      'directions': directions,
      'located_at': locatedAt,
      'amenities': amenities,
      'availabilty': availability,
      'cancellation_policy': cancellationPolicy,
      'safety&property': safetyAndProperty,
      'created_on': DateTime.now()
    });
  }

  Future<List> getListingsFromFireStore() async {
    QuerySnapshot doc = await firestore
        .collection('bookmarks')
        .doc(currentUser!.uid)
        .collection('favorites')
        .get();
    if (doc.docs.isNotEmpty) {
      List savedListings = doc.docs;
      return savedListings;
    }
    return [];
  }

  Future getListingFields(String name) async {
    DocumentSnapshot doc = await firestore
        .collection('bookmarks')
        .doc(currentUser!.uid)
        .collection('favorites')
        .doc(name)
        .get();

    return doc;
  }

  Future deleteListing(String name) async {
    await firestore
        .collection('bookmarks')
        .doc(currentUser!.uid)
        .collection('favorites')
        .doc(name)
        .delete();
  }
}
