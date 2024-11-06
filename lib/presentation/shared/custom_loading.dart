import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thechnical_assignment_tots/config/config.dart';
import 'package:thechnical_assignment_tots/presentation/shared/custom_card.dart';

class CustomLoading {
  final String title;
  final String? iconImage;
  final bool? barrierDismissible;
  final IconData? icon;

  CustomLoading({
    required this.title,
    this.iconImage,
    this.icon,
    this.barrierDismissible,
    required BuildContext context,
  }) {
    showLoadingDialog(context);
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(
                  Size(MediaQuery.of(context).size.width * 0.7, 190)),
              child: CustomCard(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 20),
                      child: const SpinKitCircle(
                        color: AppColors.primaryColor,
                        size: 50.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyles.bodyStyle(
                          isBold: true,
                          color: AppColors.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
