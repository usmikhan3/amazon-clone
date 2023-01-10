import 'package:amazon_firebase/model/user_model.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
import 'package:amazon_firebase/utils/constants.dart';
import 'package:amazon_firebase/widgets/ad_banner_widget.dart';
import 'package:amazon_firebase/widgets/catrgories_horizontal_list_view.dart';
import 'package:amazon_firebase/widgets/loading_widget.dart';
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
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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

  void getData() async {
    List<Widget> temp70 =
    await CloudFirestoreMethods().getProductsFromDiscount(70);
    List<Widget> temp60 =
    await CloudFirestoreMethods().getProductsFromDiscount(60);
    List<Widget> temp50 =
    await CloudFirestoreMethods().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreMethods().getProductsFromDiscount(0);
    print("everything is done");
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body:discount70 != null &&
            discount60 != null &&
            discount50 != null &&
            discount0 != null
            ? Stack(
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
                    children: discount70!,
                  ),
                  ProductsShowcaseListView(
                    title: "Upto 60% Off",
                    children: discount60!,
                  ),
                  ProductsShowcaseListView(
                    title: "Upto 50% Off",
                    children:discount50!,
                  ),
                  ProductsShowcaseListView(
                    title: "Explore",
                    children: discount0!,
                  ),
                ],
              ),
            ),
            UserDetailsBar(
              offset: offset,
              /*userModel: UserModel(
                address: "Karachi",
                name:"Usman",
                email:FirebaseAuth.instance.currentUser!.email!,
                uid: FirebaseAuth.instance.currentUser!.uid,
              ),*/
            ),
          ],
        ) : const LoadingWidget(),
      ),
    );
  }
}
