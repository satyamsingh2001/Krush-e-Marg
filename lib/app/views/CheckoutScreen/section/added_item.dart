import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/container_widget.dart';
import '../../../constwidgets/counter_widgets.dart';
import '../../../database/database_helper2.dart';
import '../../../textstyles/textstyle_const.dart';


class AddedItem extends StatefulWidget {
  const AddedItem({Key? key}) : super(key: key);

  @override
  State<AddedItem> createState() => _AddedItemState();
}

class _AddedItemState extends State<AddedItem> {
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  List<Product> productList = [];
  void fetchProducts() async {
    final products = await ProductDatabase.instance.fetchProducts();
    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ContainerWidget(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${productList.length} Items added',
              style: AppTextStyles.kBody15SemiboldTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: productList.length,
                itemBuilder: (BuildContext context, index) {
                  var price = productList[index].price!*productList[index].quantity!.toInt();
                  var mrp = productList[index].mrp!*productList[index].quantity!.toInt();
                  var Size = productList[index].size.toString()+productList[index].unit.toString();
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 60,
                              width: 65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Image.network(
                                  productList[index].imageUrl.toString(),
                                  fit: BoxFit.fill,
                                ),
                              )),
                          const SizedBox(width: 8.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productList[index].name.toString(),
                                style: AppTextStyles.kBody15SemiboldTextStyle,
                              ),
                              Text(productList[index].storeName.toString(),
                                  style: AppTextStyles
                                      .kCaption12SemiboldTextStyle.copyWith(color: AppColors.white60)),
                              Text(Size,
                                  style: AppTextStyles
                                      .kSmall10RegularTextStyle
                                      .copyWith(color: AppColors.white60)),

                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹$price',
                                    style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.primary),
                                  ),
                                  const SizedBox(width: 3,),
                                  Text(
                                    '₹$mrp',
                                    style: AppTextStyles.kSmall10RegularTextStyle
                                        .copyWith(
                                        color: AppColors.white60,
                                        decoration:
                                        TextDecoration.lineThrough),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CounterWidget(
                                height: size.height*0.032,
                                width: size.width*0.18,
                                plusOntap: () {
                                  for(var i = 0; i<productList.length;i++){
                                    var productId = productList[i].productId;
                                    var productSize = productList[i].size;
                                    if(productId==productList[index].productId.toString()&&productSize==productList[index].size!.toInt())
                                    {
                                      updateProduct(
                                          productList[index].productId.toString(),
                                          productList[index].size!.toInt(),
                                          productList[i].quantity!.toInt()+1);
                                      fetchProducts();
                                      setState(() {

                                      });
                                    }
                                  }
                                },
                                minusOntap: () {
                                  for(var j = 0; j<productList.length;j++){
                                    var productId = productList[j].productId;
                                    var productSize = productList[j].size;
                                    if(productId==productList[index].productId.toString()&&productSize==productList[index].size!.toInt())
                                    {
                                      if (productList[j].quantity!.toInt() > 1) {
                                        updateProduct(
                                            productList[index].productId.toString(),
                                            productList[index].size!.toInt(),
                                            productList[j].quantity!.toInt()-1);
                                        fetchProducts();
                                      }else{
                                        removeProduct(productList[j].id!.toInt());
                                        fetchProducts();
                                      }
                                    }
                                  }
                                },
                                // counterValue:productList[index2].quantity,
                                counterValue:productList[index].quantity,
                              ),
                            ],
                          ),
                        ],
                      ),
                      index != productList.length - 1
                          ? const Divider(
                              color: AppColors.white40,
                              thickness: 1,
                            )
                          : const Text(''),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
