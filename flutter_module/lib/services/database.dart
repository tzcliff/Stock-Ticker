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

Future<void> addOrRemoveWatchListData(String symbol) async { // this method will add a symbol to the watchlist or if it is already on there it will be removed
  var documents = await watchlistCollection.document(uid).get(); // get the document
  var data = documents.data; // get data
  List list = data.values.elementAt(0); // values for our symbols array are at index 0 of the data
  if (list.contains(symbol)) { // if this symbol is already on the watchlist
    list.remove(symbol); // remove it
  }
  else { // otherwise add it
    list.add(symbol);
  }
  watchlistCollection.document(uid).setData({'symbols': list}); // send the updated watchlist to the database
}

}