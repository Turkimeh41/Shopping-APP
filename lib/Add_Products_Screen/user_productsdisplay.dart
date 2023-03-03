import 'package:flutter/cupertino.dart';
import 'package:module8/Add_Products_Screen/user_productswidget.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class UserProductDisplay extends StatelessWidget {
  const UserProductDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final insProducts = Provider.of<Products>(context);
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoScrollbar(
                thickness: 4,
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: insProducts.userproducts[index],
                        child: const UserProductWidget(),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.001,
                      );
                    },
                    itemCount: insProducts.userproducts.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
