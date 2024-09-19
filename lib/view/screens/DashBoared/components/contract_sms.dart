import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mShop_Seller/utils_services/global_variable.dart';

import '../../../../utils_services/app_font.dart';
import '../../Contract/contract_screen.dart';
import '../../Contract/view_contract.dart';

class ContractSms extends StatefulWidget {
  final Function()? update;
  const ContractSms({Key? key, this.update}) : super(key: key);

  @override
  State<ContractSms> createState() => _ContractSmsState();
}

class _ContractSmsState extends State<ContractSms> {
  @override
  Widget build(BuildContext context) {
    return user_model.user!.contractVerified == null
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.withOpacity(0.2),
            ),
            child: Row(
              children: [
                //Icon(Icons.warning_amber_outlined, color: Colors.red),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Sign seller contract.'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: AppFonts.segoeui,
                          color: Colors.red)),
                ),
                InkWell(
                  onTap: () {
                    Get.to(ContractScreen())!.then((value) {
                      if (value != null) {
                        widget.update!.call();
                      }
                    });
                  },
                  child: Text('View contract'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.segoeui,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ),
                SizedBox(width: 10),
              ],
            ),
          )
        : user_model.user!.contractVerified == 'no'
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.cyan.shade200,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          'Contract is submitted, wait for approval.'.tr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.segoeui,
                              color: Colors.black)),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ViewContract());
                      },
                      child: Text('View Contract'.tr,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: AppFonts.segoeui,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              )
            : SizedBox();
  }
}
