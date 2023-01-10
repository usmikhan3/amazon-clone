import 'package:amazon_firebase/model/product_model.dart';
import 'package:amazon_firebase/model/review_model.dart';
import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/providers/user_details_provider.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
import 'package:amazon_firebase/utils/color_themes.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/utils/utils.dart';
import 'package:amazon_firebase/widgets/cost_widget.dart';
import 'package:amazon_firebase/widgets/custom_main_button.dart';
import 'package:amazon_firebase/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_firebase/widgets/rating_star_widget.dart';
import 'package:amazon_firebase/widgets/review_dialog.dart';
import 'package:amazon_firebase/widgets/review_widget.dart';
import 'package:amazon_firebase/widgets/search_bar_widget.dart';
import 'package:amazon_firebase/widgets/user_details_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy = Expanded(child: Container());
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: true, hasBackButton: true),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height -
                          (kAppBarHeight + (kAppBarHeight / 2)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.productModel.sellerName,
                                        style: const TextStyle(
                                            color: activeCyanColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Text(widget.productModel.productName),
                                  ],
                                ),
                                RatingStarWidget(
                                    rating: widget.productModel.rating),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: screenSize.height / 3,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 3),
                              child: Image.network(widget.productModel.url),
                            ),
                          ),
                          spaceThingy,
                          CostWidget(
                              color: Colors.black,
                              cost: widget.productModel.cost),
                          spaceThingy,
                          CustomMainButton(
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(color: Colors.black),
                              ),
                              color: Colors.orange,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestoreMethods().addProductToOrders(
                                    model: widget.productModel,
                                    userDetails:
                                    Provider.of<UserDetailProvider>(
                                        context,
                                        listen: false)
                                        .userDetails);
                                Utils().showSnackBar(
                                    context: context, content: "Done");
                              }),
                          spaceThingy,
                          CustomMainButton(
                              child: const Text(
                                "Add to cart",
                                style: TextStyle(color: Colors.black),
                              ),
                              color: yellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestoreMethods().addProductToCart(
                                    productModel: widget.productModel);
                                Utils().showSnackBar(
                                    context: context,
                                    content: "Added to cart.");
                              }),
                          spaceThingy,
                          CustomSimpleRoundedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => ReviewDialog(
                                      productUid: widget.productModel.uid,
                                    ));
                              },
                              text: "Add a review for this product"),
                        ],
                      ),
                    ),

                    SizedBox(
                        height: screenSize.height,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .doc(widget.productModel.uid)
                              .collection("reviews")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    ReviewModel model =
                                    ReviewModel.getModelFromJson(
                                        json: snapshot.data!.docs[index]
                                            .data());
                                    return ReviewWidget(review: model);
                                  });
                            }
                          },
                        ))
                  ],
                ),
              ),
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
    );
  }
}

