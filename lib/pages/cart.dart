import 'dart:convert';

import 'package:trily/model/car.dart';
import 'package:trily/pages/payment.dart';
import 'package:trily/pages/car_view.dart';
import 'package:dotted_border/dotted_border.dart';
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
  int totalPrice = 0;

  Future<void> fetchItems() async {
    final String response = await rootBundle.loadString('assets/cart.json');
    final data = await json.decode(response);

    cartItems = data['cars'].map((data) => Car.fromJson(data)).toList();

    sumTotal();
  }

  sumTotal() {
    cartItems.forEach((item) {
      totalPrice = item.price + totalPrice;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),

                          dismissible: null,
                          children: <Widget>[
                            SlidableAction(
                              onPressed: null,
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Hapus',
                            ),
                          ],
                        ),

                        endActionPane: const ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: null,
                              backgroundColor: Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.archive,
                              label: 'Booking',
                            ),
                          ],
                        ),

                        child: cartItem(cartItems[index], index, animation),
                      );
                    },
                  )
                : Container(),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Biaya Admin', style: TextStyle(fontSize: 20)),
                Text('\Rp 5.000',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: DottedBorder(
                color: Colors.grey.shade400,
                dashPattern: [10, 10],
                padding: EdgeInsets.all(0),
                child: Container()),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total', style: TextStyle(fontSize: 20)),
                Text(RupiahFormat.convertToIdr(totalPrice + 5000, 0),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: MaterialButton(
              onPressed: () {},
              height: 50,
              elevation: 0,
              splashColor: Colors.yellow[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.blue.shade900,
              child: Center(
                child: Text(
                  "Bayar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ]));
  }

  cartItem(Car cart, int index, animation) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductViewPage(car: cart)));
      },
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
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
                    Text(
                      RupiahFormat.convertToIdr(cart.price, 0),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                  ]),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     MaterialButton(
            //       minWidth: 10,
            //       padding: EdgeInsets.all(0),
            //       onPressed: () {
            //         setState(() {
            //           if (cartItemCount[index] > 1) {
            //             cartItemCount[index]--;
            //             totalPrice = totalPrice - cart.price;
            //           }
            //         });
            //       },
            //       shape: CircleBorder(),
            //       child: Icon(
            //         Icons.remove_circle_outline,
            //         color: Colors.grey.shade400,
            //         size: 30,
            //       ),
            //     ),
            //     Container(
            //       child: Center(
            //         child: Text(
            //           cartItemCount[index].toString(),
            //           style:
            //               TextStyle(fontSize: 20, color: Colors.grey.shade800),
            //         ),
            //       ),
            //     ),
            //     MaterialButton(
            //       padding: EdgeInsets.all(0),
            //       minWidth: 10,
            //       splashColor: Colors.yellow[700],
            //       onPressed: () {
            //         setState(() {
            //           cartItemCount[index]++;
            //           totalPrice = totalPrice + cart.price;
            //         });
            //       },
            //       shape: CircleBorder(),
            //       child: Icon(
            //         Icons.add_circle,
            //         size: 30,
            //       ),
            //     ),
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }

}
