import 'package:amazon_firebase/model/review_model.dart';
import 'package:amazon_firebase/providers/user_details_provider.dart';
import 'package:amazon_firebase/resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key, required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?

      submitButtonText: 'Send',
      commentHint: 'Type here',

      onSubmitted: (RatingDialogResponse res) async {
        print(res.comment);
        print(res.rating);
        CloudFirestoreMethods().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                Provider.of<UserDetailProvider>(context, listen: false)
                    .userDetails
                    .name,
                description: res.comment,
                rating: res.rating.toInt()));
      },
    );
  }
}