import 'package:flutter/material.dart';

class Utils {

  Size getScreenSize(){
      return MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size;
  }


  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width: getScreenSize().width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                style:const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  //color: Colors.black
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }


}