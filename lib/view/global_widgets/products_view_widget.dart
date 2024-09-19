import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:sizer/sizer.dart';
import 'package:mShop_Seller/utils_services/colors_util.dart';
import 'package:mShop_Seller/view/global_widgets/shadow_style.dart';

import '../global_widgets/app_font.dart';

class ProductView extends StatefulWidget {
  final double? ratting;
  final bool? visible;
  final String? textDiscount;
  final String? addBy;
  final String? textName;
  final String? stockPrice;
  final String? priceHighLow;
  final String? textPrice;
  final String? imageUrl;
  final bool? show_decoration;
  final bool? show_price;
  final bool? isActive;
  const ProductView(
      {Key? key,
      this.ratting,
      this.addBy,
      this.priceHighLow,
      this.stockPrice,
      this.visible,
      this.textDiscount,
      this.textName,
      this.textPrice,
      this.imageUrl,
      this.show_decoration = true,
      this.show_price = true,
      required this.isActive})
      : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        decoration: widget.show_decoration!
            ? getdecoration(borderRadius: 1, context: context)
            : null,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    imageUrl: "${widget.imageUrl}",
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                        //color: Colors.white,
                        ),
                    errorWidget: (context, url, error) => Image.network(
                        'https://staging.housy.ae/public/assets/img/placeholder.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.textName}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: AppFonts.segoeui,
                    fontSize: !widget.show_price! ? 16 : 16,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    fontWeight:
                        !widget.show_price! ? FontWeight.bold : FontWeight.w500,
                  ),
                ).translate(),
              ),
              SizedBox(
                height: 1.h,
              ),
              Visibility(
                visible: widget.show_price!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.textPrice}',
                      style: TextStyle(
                        fontFamily: AppFonts.segoeui,
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Visibility(
                      visible: widget.visible!,
                      child: Text(
                        ' ${widget.textDiscount}% OFF',
                        style: TextStyle(
                          fontFamily: AppFonts.segoeui,
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              topLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          color: widget.isActive! ? Colors.green : Colors.red,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 2),
                          child: Text(
                            widget.isActive! ? 'Publish' : 'Unpublished',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )),
                    Container(
                        //width: 10.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: offBlackAvatr,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${widget.ratting!.toDouble()}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                              Icon(Icons.star, size: 12, color: Colors.black),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
