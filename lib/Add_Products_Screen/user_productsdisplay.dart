import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module8/Add_Products_Screen/user_productswidget.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class UserProductDisplay extends StatelessWidget {
  const UserProductDisplay({super.key});
  Future<void> refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProductsAndSET(true);
  }

  @override
  Widget build(BuildContext context) {
    final insProducts = Provider.of<Products>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            const Text("ID",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.14,
            ),
            const Text('Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const Text('Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.115,
            ),
            const Text(
              'Price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
          ]),
          Expanded(
            child: FutureBuilder(
              future: refresh(context),
              builder: (ctx, snapshot) => RefreshIndicator(
                onRefresh: () {
                  return refresh(context);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoScrollbar(
                    thickness: 4,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: insProducts.products[index],
                            child: const UserProductWidget(),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.001,
                          );
                        },
                        itemCount: insProducts.products.length),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
