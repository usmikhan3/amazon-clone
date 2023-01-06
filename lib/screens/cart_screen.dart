import 'package:amazon_firebase/model/product_model.dart';
import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/utils/color_themes.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/widgets/cart_item_widget.dart';
import 'package:amazon_firebase/widgets/custom_main_button.dart';
import 'package:amazon_firebase/widgets/search_bar_widget.dart';
import 'package:amazon_firebase/widgets/user_details_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                    child: CustomMainButton(
                        child: const Text(
                          "Proceed to buy (n) items",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        color: yellowColor,
                        isLoading: false,
                        onPressed: () {}),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                            product: ProductModel(
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
                      },
                    ),
                  ),


                ],
              ),
              UserDetailsBar(
                offset: 0,
                userModel: UserModel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  email: "",
                  name: "Usman",
                  address: "Karachi",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
