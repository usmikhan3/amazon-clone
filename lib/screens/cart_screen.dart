import 'package:amazon_firebase/model/product_model.dart';
import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/providers/user_details_provider.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
import 'package:amazon_firebase/utils/color_themes.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/utils/utils.dart';
import 'package:amazon_firebase/widgets/cart_item_widget.dart';
import 'package:amazon_firebase/widgets/custom_main_button.dart';
import 'package:amazon_firebase/widgets/search_bar_widget.dart';
import 'package:amazon_firebase/widgets/user_details_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isReadOnly: true,
        ),
        body: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: kAppBarHeight / 2,
                  ),

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomMainButton(
                                child: const Text(
                                  "Loading",
                                ),
                                color: yellowColor,
                                isLoading: true,
                                onPressed: () {});
                          } else {
                            return CustomMainButton(
                                child: Text(
                                  "Proceed to buy (${snapshot.data!.docs.length}) items",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                color: yellowColor,
                                isLoading: false,
                                onPressed: () async {
                                  await CloudFirestoreMethods().buyAllItemsInCart(
                                      userDetails:
                                      Provider.of<UserDetailProvider>(
                                          context,
                                          listen: false)
                                          .userDetails);
                                  Utils().showSnackBar(
                                      context: context, content: "Done");
                                });
                          }
                        },
                      )),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (context, index) {
                  //       return CartItemWidget(
                  //           product: ProductModel(
                  //         url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                  //         productName: "t-Shirt",
                  //         cost: 1500,
                  //         discount: 20,
                  //         uid: FirebaseAuth.instance.currentUser!.uid,
                  //         sellerName: "MUK",
                  //         sellerUid: "234324242",
                  //         rating: 4,
                  //         noOfRating: 4,
                  //       ));
                  //     },
                  //   ),
                  // ),

                  Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("cart")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ProductModel model = ProductModel.getModelFromJson(
                                      json: snapshot.data!.docs[index].data());
                                  return CartItemWidget(product: model);
                                });
                          }
                        },
                      ))


                ],
              ),
              UserDetailsBar(
                offset: 0,
                /*userModel: UserModel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  email: "",
                  name: "Usman",
                  address: "Karachi",
                ),*/
              ),

            ],
          ),
        ),
      ),
    );
  }
}
