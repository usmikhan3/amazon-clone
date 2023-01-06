

import 'package:amazon_firebase/model/product_model.dart';
import 'package:amazon_firebase/widgets/result_widget.dart';
import 'package:amazon_firebase/widgets/search_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Showing results for ",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black
                        ),
                      ),
                      TextSpan(
                        text: query,
                        style: const TextStyle(
                            fontSize: 17, fontStyle: FontStyle.italic, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 2 / 3.5),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    // ProductModel product =
                    // ProductModel.getModelFromJson(
                    //     json: snapshot.data!.docs[index].data());
                    return ResultsWidget(product: ProductModel(
                      url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                      productName: "t-Shirt",
                      cost: 1500,
                      discount: 20,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      sellerName: "MUK",
                      sellerUid: "234324242",
                      rating: 4,
                      noOfRating: 4,
                    ));
                  }),
            )
           /* Expanded(
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("products")
                        .where("productName", isEqualTo: query)
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      } else {
                        return GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 2 / 3.5),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductModel product =
                              ProductModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                              return ResultsWidget(product: product);
                            });
                      }
                    }))*/
          ],
        ),
      ),
    );
  }
}