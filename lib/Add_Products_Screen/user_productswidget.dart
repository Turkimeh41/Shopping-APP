import 'package:flutter/material.dart';
import 'package:module8/Add_Products_Screen/add_user_products.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/products.dart';

class UserProductWidget extends StatelessWidget {
  const UserProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final insProduct = Provider.of<Product>(context);
    final insProducts = Provider.of<Products>(context);
    return ClipRRect(
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40), topRight: Radius.circular(40)),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 64,
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Text(
                    (insProducts.products.indexOf(insProduct) + 1).toString(),
                    style: const TextStyle(color: Color.fromARGB(255, 32, 96, 170), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.11),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.18,
                    child: Text(
                      insProduct.title,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                  Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(border: Border.all(width: 0.7, color: Colors.black54), borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        insProduct.imageURL,
                        fit: BoxFit.cover,
                        height: 64,
                        width: 64,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.07,
                  ),
                  Text(
                    '\$${insProduct.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.1,
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                            isScrollControlled: true,
                            context: context,
                            builder: (bCTX) {
                              return ChangeNotifierProvider.value(
                                  value: insProduct,
                                  child: AddEditUserProducts(
                                    provider: 2,
                                    id: insProduct.id,
                                    title: insProduct.title,
                                    price: insProduct.price,
                                    description: insProduct.description,
                                    imageURL: insProduct.imageURL,
                                  ));
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.mode_edit_outlined,
                          color: Color.fromARGB(255, 0, 47, 129),
                        )),
                  ),
                  Expanded(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Colors.red,
                      ),
                      Positioned(
                        child: GestureDetector(
                          child: const Icon(
                            Icons.cancel_sharp,
                            color: Colors.black,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Stack(alignment: Alignment.center, children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: const LinearGradient(colors: [
                                              Color.fromARGB(255, 255, 236, 178),
                                              Color.fromARGB(255, 255, 225, 136),
                                              Color.fromARGB(255, 255, 212, 85),
                                              Color.fromARGB(255, 255, 198, 27)
                                            ])),
                                        width: double.infinity,
                                        height: 150,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                          const Text(
                                            'Are you sure?',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 24, color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 65,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    insProducts.removeProduct(insProduct.id);
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                    style: TextStyle(color: Colors.black, fontSize: 20),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: const Text('No', style: TextStyle(color: Colors.black, fontSize: 20)),
                                              )
                                            ],
                                          )
                                        ]),
                                      )
                                    ]));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )));
  }
}
