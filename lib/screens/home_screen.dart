import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/widgets/ad_banner_widget.dart';
import 'package:amazon_firebase/widgets/catrgories_horizontal_list_view.dart';
import 'package:amazon_firebase/widgets/products_showcase_list_widget.dart';
import 'package:amazon_firebase/widgets/search_bar_widget.dart';
import 'package:amazon_firebase/widgets/simple_product_widget.dart';
import 'package:amazon_firebase/widgets/user_details_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      //print(controller.position.pixels);
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              //scrollDirection: Axis.horizontal,
              child: Column(
                children:  [
                  const SizedBox(
                    height: kAppBarHeight / 2,
                  ),
                 const  CategoriesHorizontalListViewBar(),
                 const  BannerAdWidget(),
                  ProductsShowcaseListView(
                    title: "Upto 70% Off",
                    children: testChildren,
                  ),
                  ProductsShowcaseListView(
                    title: "Upto 60% Off",
                    children: testChildren,
                  ),
                  ProductsShowcaseListView(
                    title: "Upto 50% Off",
                    children:testChildren,
                  ),
                  ProductsShowcaseListView(
                    title: "Explore",
                    children: testChildren,
                  ),
                ],
              ),
            ),
            UserDetailsBar(
              offset: offset,
              userModel: UserModel(
                address: "Karachi",
                name:"Usman",
                email:FirebaseAuth.instance.currentUser!.email!,
                uid: FirebaseAuth.instance.currentUser!.uid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
