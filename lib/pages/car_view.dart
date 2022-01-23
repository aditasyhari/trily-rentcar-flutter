import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trily/model/car.dart';
import 'package:trily/model/car_specifications.dart';
import 'package:flutter/material.dart';
import 'package:trily/parts/button.dart';
import 'package:trily/parts/currency.dart';

class ProductViewPage extends StatefulWidget {
  final Car car;
  const ProductViewPage({Key? key, required this.car}) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<dynamic> specList = [];

  @override
  void initState() {
    specCars();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          elevation: 0,
          snap: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.grey.shade50,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                widget.car.imageURL,
                fit: BoxFit.cover,
              )),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: Transform.translate(
                offset: Offset(0, 1),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.car.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.car.brand,
                            style: TextStyle(
                              color: Colors.orange.shade400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        RupiahFormat.convertToIdr(widget.car.price, 0),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.car.ket,
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.grey.shade800,
                      fontSize: 15,
                    ),
                  ),
                  // spesifications(sheetItemHeight),
                  SizedBox(
                    height: 30,
                  ),
                  button('Rent Car', () {
                    Navigator.pop(context);
                  }),
                ],
              ))
        ])),
      ]),
    );
  }

  Future<void> specCars() async {
    final String response =
        await rootBundle.loadString('assets/json/car_specifications.json');
    final data = await json.decode(response);

    setState(() {
      specList = data['specifications']
          .map((data) => Specifications.fromJson(data))
          .toList();
    });
  }

  spesifications(double sheetItemHeight) {
    double height = 70;
    double width = 70;
    return Container(
      padding: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Spesifikasi",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: sheetItemHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.only(right: 30, top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 15,
                        color: Colors.grey.shade200,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.airline_seat_individual_suite, size: 20),
                      Text(specList[0].seat + " seats")
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.only(right: 30, top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 15,
                        color: Colors.grey.shade200,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.settings, size: 20),
                      Text(specList[0].type)
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.only(right: 30, top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 15,
                        color: Colors.grey.shade200,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.bluetooth, size: 20),
                      Text(specList[0].bt)
                    ],
                  ),
                ),
              ],
              // itemCount: widget.car.specifications.length,
              // itemBuilder: (context, index) {
              //   return ListItem(
              //     sheetItemHeight: sheetItemHeight,
              //     mapVal: currentCar.specifications[index],
              //   );
              // },
            ),
          )
        ],
      ),
    );
  }
}
