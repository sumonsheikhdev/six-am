import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CameraButtonSheet extends StatelessWidget {
  const CameraButtonSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 4, width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT), color: Theme.of(context).disabledColor),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          InkWell(
            onTap: (){
              if(Get.isBottomSheetOpen){
                Get.back();
              }
              Get.find<StoreController>().pickPrescriptionImage(isRemove: false, isCamera: true);
            },
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withOpacity(0.2)),
                child: Icon(Icons.camera_alt_outlined, size: 45, color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text('from_camera'.tr, style: robotoMedium)
            ]),
          ),

          InkWell(
            onTap: () {
              if(Get.isBottomSheetOpen){
                Get.back();
              }
              Get.find<StoreController>().pickPrescriptionImage(isRemove: false, isCamera: false);
            },
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withOpacity(0.2)),
                child: Icon(Icons.photo_library_outlined, size: 45, color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Text('from_gallery'.tr, style: robotoMedium),
            ]),
          )
        ]),
      ]),
    );
  }
}
