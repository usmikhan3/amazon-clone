import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/providers/user_details_provider.dart';
import 'package:amazon_firebase/screens/sell_screen.dart';
import 'package:amazon_firebase/utils/color_themes.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/utils/utils.dart';
import 'package:amazon_firebase/widgets/account_screen_appbar.dart';
import 'package:amazon_firebase/widgets/custom_main_button.dart';
import 'package:amazon_firebase/widgets/products_showcase_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {

    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AccountScreenAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                IntroductionWidgetAccountScreen(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.black),
                      ),
                      color: Colors.orange,
                      isLoading: false,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                      child: const Text("Sell",
                          style: TextStyle(color: Colors.black)),
                      color: yellowColor,
                      isLoading: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SellScreen()));
                      }),
                ),
                ProductsShowcaseListView(
                  title: "Your Orders",
                  children: testChildren,
                ),
                const Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(

                    alignment: Alignment.centerLeft,
                    child:  Text(
                      "Order Requests",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        title: Text(
                          "Order: Black Shoe",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text("Address: Karachi"),
                        trailing: Icon(Icons.check),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userDetail = Provider.of<UserDetailProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.000000000001)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                      ),
                    ),
                    TextSpan(
                      //text: "${userDetailsModel.name}",
                      text: "${userDetail.name}",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
