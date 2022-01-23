import 'dart:convert';

import 'package:trily/model/cart.dart';
import 'package:trily/pages/car_view.dart';
import 'package:trily/pages/motor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trily/parts/currency.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  late List<dynamic> cartItems = [];
  List<int> cartItemCount = [1, 1, 1, 1];

  Future<void> fetchItems() async {
    final String response = await rootBundle.loadString('assets/json/cart.json');
    final data = await json.decode(response);

    cartItems = data['cart'].map((data) => Cart.fromJson(data)).toList();

  }

  @override
  void initState() {
    super.initState();

    fetchItems().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Keranjang Saya', style: TextStyle(color: Colors.black)),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.53,
            child: cartItems.length > 0
                ? AnimatedList(
                    scrollDirection: Axis.vertical,
                    initialItemCount: cartItems.length,
                    itemBuilder: (context, index, animation) {
                      return Slidable(
                        key: const ValueKey(0),

                        endActionPane: const ActionPane(
                          motion: ScrollMotion(),
                          dismissible: null,
                          children: [
                            SlidableAction(
                              onPressed: null,
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Hapus',
                            ),
                          ],
                        ),

                        child: cartItem(cartItems[index], index, animation),
                      );
                    },
                  )
                : Container(),
          ),
          // SizedBox(height: 30),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text('Biaya Admin', style: TextStyle(fontSize: 20)),
          //       Text('\Rp 5.000',
          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: DottedBorder(
          //       color: Colors.grey.shade400,
          //       dashPattern: [10, 10],
          //       padding: EdgeInsets.all(0),
          //       child: Container()),
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text('Total', style: TextStyle(fontSize: 20)),
          //       Text(RupiahFormat.convertToIdr(totalPrice + 5000, 0),
          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          //     ],
          //   ),
          // ),
          // SizedBox(height: 10),
          // Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: MaterialButton(
          //     onPressed: () {},
          //     height: 50,
          //     elevation: 0,
          //     splashColor: Colors.yellow[700],
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)),
          //     color: Colors.blue.shade900,
          //     child: Center(
          //       child: Text(
          //         "Bayar",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //     ),
          //   ),
          // )
        ]));
  }

  cartItem(dynamic cart, int index, animation) {
    return GestureDetector(
      onTap: () {
        switch (cart.type) {
          case "motor":
            Navigator.push(context, MaterialPageRoute(builder: (context) => MotorViewPage(motor: cart)));
            break;
          default:
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductViewPage(car: cart)));
        }
      },
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: Container(
          // margin: EdgeInsets.only(bottom: 10, top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  cart.imageURL,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cart.brand,
                      style: TextStyle(
                        color: Colors.orange.shade400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      cart.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          RupiahFormat.convertToIdr(cart.price, 0),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      Text(" /hari", style: TextStyle(color: Colors.black38, fontSize: 14),)
                      ],
                    ),
                    SizedBox(height: 10),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }

}
