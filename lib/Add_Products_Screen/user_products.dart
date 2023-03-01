import 'package:flutter/material.dart';
import 'package:module8/Add_Products_Screen/add_user_products.dart';
import 'package:module8/Add_Products_Screen/user_productsdisplay.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});
  static const routeName = 'user_products';
  @override
  Widget build(BuildContext context) {
    final insProducts = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  gradient: LinearGradient(colors: [Colors.redAccent, Colors.orange, Colors.amber])),
              child: SafeArea(
                  child: Center(
                child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return ChangeNotifierProvider.value(
                                value: insProducts,
                                child: const AddEditUserProducts(
                                  provider: 1,
                                ));
                          },
                        );
                      },
                    ),
                    leading: IconButton(
                        onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
                        icon: Transform.scale(
                          scaleX: -1,
                          child: const Icon(
                            Icons.arrow_right_alt,
                            size: 40,
                            color: Colors.white,
                          ),
                        )),
                    title: const Text(
                      'User\'s Added Products',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ))),
        ),
        body: Container(color: Theme.of(context).backgroundColor, child: const UserProductDisplay()));
  }
}
