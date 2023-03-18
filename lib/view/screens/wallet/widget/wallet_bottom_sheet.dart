
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/controller/wallet_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';

class WalletBottomSheet extends StatefulWidget {
  final bool fromWallet;
  const WalletBottomSheet({Key key, @required this.fromWallet}) : super(key: key);

  @override
  State<WalletBottomSheet> createState() => _WalletBottomSheetState();
}

class _WalletBottomSheetState extends State<WalletBottomSheet> {

  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.fromWallet);

    int _exchangePointRate = Get.find<SplashController>().configModel.loyaltyPointExchangeRate;
    int _minimumExchangePoint = Get.find<SplashController>().configModel.minimumPointToTransfer;

    return Container(
      width: 550,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_LARGE)),
      ),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Text('your_loyalty_point_will_convert_to_currency_and_transfer_to_your_wallet'.tr,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
              maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          Text('$_exchangePointRate ' + 'points'.tr + '= ${PriceConverter.convertPrice(1)}',
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), border: Border.all(color: Theme.of(context).primaryColor,width: 0.3)),
            child: CustomTextField(
              hintText: '0',
              controller: _amountController,
              inputType: TextInputType.phone,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          GetBuilder<WalletController>(
              builder: (walletController) {
                return !walletController.isLoading ? CustomButton(
                  buttonText: 'convert'.tr,
                  onPressed: () {
                    if(_amountController.text.isEmpty) {
                      if(Get.isBottomSheetOpen){
                        Get.back();
                      }
                      showCustomSnackBar('input_field_is_empty'.tr);
                    }else{
                      int _amount = int.parse(_amountController.text.trim());
                      int point = Get.find<UserController>().userInfoModel.loyaltyPoint;

                      if(_amount <_minimumExchangePoint){
                        if(Get.isBottomSheetOpen){
                          Get.back();
                        }
                        showCustomSnackBar('please_exchange_more_then'.tr + ' $_minimumExchangePoint ' + 'points'.tr);
                      }else if(point < _amount){
                        if(Get.isBottomSheetOpen){
                          Get.back();
                        }
                        showCustomSnackBar('you_do_not_have_enough_point_to_exchange'.tr);
                      } else {
                        walletController.pointToWallet(_amount, widget.fromWallet);
                      }
                    }
                  },
                ) : Center(child: CircularProgressIndicator());
              }
          ),
        ]),
      ),
    );
  }
}
