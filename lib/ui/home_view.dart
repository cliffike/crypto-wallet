import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'addview.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;
  double filecoin = 0.0;
  double chainlink = 0.0;
  double litecoin = 0.0;
  double polkadot = 0.0;
  double cardano = 0.0;

  @override
  void initState() {
    getValue();
  }

  getValue() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    filecoin = await getPrice("filecoin");
    chainlink = await getPrice("chainlink");
    litecoin = await getPrice("litecoin");
    polkadot = await getPrice("polkadot");
    cardano = await getPrice("cardano");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return bitcoin * amount;
      } else if (id == "ethereum") {
        return ethereum * amount;
      }
      else if (id == "filecoin") {
        return filecoin * amount;
      }
      else if (id == "chainlink") {
        return chainlink * amount;
      }
      else if (id == "litecoin") {
        return litecoin * amount;
      }
      else if (id == "polkadot") {
        return polkadot * amount;
      }
      else if (id == "cardano") {
        return cardano * amount;
      } else {
        return tether * amount;
      }
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('Coins')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 15.0, right: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: MediaQuery.of(context).size.height /12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 5.0,),
                        Text(
                          "Coin: ${document.id}",

                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        Text(
                          "\$${getValue(document.id, document.data()['Amount']).toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        IconButton(icon: Icon(Icons.close, color: Colors.red,),
                            onPressed: ()async{
                          await removeCoin(document.id);
                            })

                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddView()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
