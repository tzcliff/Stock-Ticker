import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference watchlistCollection = Firestore.instance.collection('watchlists'); // get our watchlist collection

Future updateWatchlistData(String symbol) async {
  return await watchlistCollection.document(uid).setData({
    'symbols':  []
  }); // get the document based on the uid, if it doesn't exist yet (new user)
  // firebase will create it
}

// get watchlist stream
//Stream<QuerySnapshot> get watchlist {
//  return watchlistCollection.snapshots();
//}

}