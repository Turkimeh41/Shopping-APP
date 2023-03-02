import 'dart:async';

import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class AddEditUserProducts extends StatefulWidget {
  const AddEditUserProducts({this.id = '', this.title = '', this.price = 0, this.description = '', this.imageURL = '', required this.provider, super.key});
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageURL;
  final int provider;

  @override
  State<AddEditUserProducts> createState() => _AddUserProductsState();
}

@override
class _AddUserProductsState extends State<AddEditUserProducts> {
  final imageURLController = TextEditingController();
  final form = GlobalKey<FormState>();
  String formid = '';
  String formtitle = '';
  double formprice = 0;
  String formdescription = '';
  String formurl = '';

  var loadingAnim = 0;

  @override
  void initState() {
    imageURLController.text = widget.imageURL;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isvalidURL(String url) {
    var urlPattern = r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var result = RegExp(urlPattern, caseSensitive: false).hasMatch(url);
    return result;
  }

  Future<void> postForm() async {
    bool valid = form.currentState!.validate();
    if (!valid) {
      return;
    }
    setState(() {
      loadingAnim = 1;
    });

    form.currentState!.save();
    try {
      if (widget.provider == 1) {
        final insProducts = Provider.of<Products>(context, listen: false);

        await insProducts.addProduct(title: formtitle, description: formdescription, imageURL: formurl, price: formprice);
        Timer(const Duration(seconds: 2), () {
          setState(() {
            loadingAnim = 2;
          });
        });
      } else {
        final insProduct = Provider.of<Product>(context, listen: false);
        await insProduct.editProduct(formid, formtitle, formdescription, formurl, formprice);
        Timer(const Duration(seconds: 2), () {
          setState(() {
            loadingAnim = 2;
          });
        });
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('an ERROR occured'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('Okay.'))
            ],
          );
        },
      );
    } finally {
      Timer(const Duration(seconds: 3), (() {
        Navigator.of(context).pop();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: (loadingAnim == 1)
          ? Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.12,
                  child: Lottie.asset('animations/112180-paper-notebook.json',
                      width: MediaQuery.of(context).size.width * 0.5, height: MediaQuery.of(context).size.height * 0.5),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.2,
                  child: Text(
                    'Loading...',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                )
              ],
            )
          : (loadingAnim == 2)
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset('animations/50465-done.json', width: MediaQuery.of(context).size.width * 0.5, height: MediaQuery.of(context).size.height * 0.5)
                  ],
                )
              : Form(
                  key: form,
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                enabled: false,
                                onSaved: ((value) {
                                  formid = value!;
                                }),
                                textInputAction: TextInputAction.next,
                                initialValue: widget.provider == 1 ? (Provider.of<Products>(context).products.length + 1).toString() : widget.id,
                                cursorColor: const Color.fromARGB(255, 255, 188, 3),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
                                decoration: const InputDecoration(
                                    iconColor: Color.fromARGB(255, 255, 188, 3),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
                                    labelText: 'ID:',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 64, 64),
                                    )),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Fill the in the appropiate Field";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  formtitle = value!;
                                },
                                textInputAction: TextInputAction.next,
                                initialValue: widget.title,
                                cursorColor: const Color.fromARGB(255, 255, 188, 3),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
                                decoration: const InputDecoration(
                                    iconColor: Color.fromARGB(255, 255, 188, 3),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
                                    labelText: 'Title:',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 64, 64),
                                    )),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                validator: (value) {
                                  if (double.tryParse(value!) == null) {
                                    return 'Please enter a numeric value';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  formprice = double.parse(value!);
                                },
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                initialValue: widget.price > 0 ? widget.price.toString() : '',
                                cursorColor: const Color.fromARGB(255, 255, 188, 3),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
                                decoration: const InputDecoration(
                                    iconColor: Color.fromARGB(255, 255, 188, 3),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
                                    labelText: 'Price:',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 64, 64),
                                    )),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please fill in the Description";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  formdescription = value!;
                                },
                                maxLines: 3,
                                textInputAction: TextInputAction.next,
                                initialValue: widget.description,
                                cursorColor: const Color.fromARGB(255, 255, 188, 3),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
                                decoration: const InputDecoration(
                                    iconColor: Color.fromARGB(255, 255, 188, 3),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
                                    labelText: 'Description:',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 64, 64),
                                    )),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please fill in the URL";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  formurl = value!;
                                },
                                onFieldSubmitted: (_) {
                                  setState(() {});
                                },
                                controller: imageURLController,
                                maxLines: 3,
                                textInputAction: TextInputAction.done,
                                cursorColor: const Color.fromARGB(255, 255, 188, 3),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 46, 41, 41)),
                                decoration: const InputDecoration(
                                    iconColor: Color.fromARGB(255, 255, 188, 3),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 5.5, color: Color.fromARGB(255, 255, 188, 3))),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 104, 101, 101), width: 2.5)),
                                    labelText: 'ImageURL:',
                                    labelStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 66, 64, 64),
                                    )),
                              )),
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(15)),
                            width: 128,
                            height: 128,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: (imageURLController.text.isEmpty)
                                    ? Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                                        child: const Text(
                                          'No IMAGE',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : (isvalidURL(imageURLController.text) == true)
                                        ? Image.network(imageURLController.text)
                                        : Container(
                                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                                            child: const Text(
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                              'Invalid URL',
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.001,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          Container(
                            width: 200,
                            margin: const EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  elevation: MaterialStateProperty.all(3),
                                ),
                                onPressed: (() {
                                  setState(() {
                                    postForm();
                                  });
                                }),
                                child: const Icon(
                                  Icons.arrow_circle_right_sharp,
                                  color: Color.fromARGB(255, 14, 13, 10),
                                )),
                          )
                        ],
                      )),
                ),
    );
  }
}
