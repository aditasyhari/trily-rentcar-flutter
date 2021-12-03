import 'dart:convert';

import 'package:trily/model/car.dart';
import 'package:trily/pages/car_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trily/parts/currency.dart';
import 'package:trily/parts/button.dart';

class ExplorePage extends StatefulWidget {  
  const ExplorePage({ Key? key }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  List<dynamic> productList = [];

  var selectedRange = RangeValues(500000.00, 2500000.00);

  @override
  void initState() { 
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    products();

    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
          elevation: 0,
          pinned: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.grey.shade50,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            titlePadding: EdgeInsets.only(left: 20, right: 30, bottom: 100),
            stretchModes: [
              StretchMode.zoomBackground,
              // StretchMode.fadeTitle
            ],
            title: AnimatedOpacity(
              opacity: _isScrolled ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: Text("Trily\nSolusi Anda.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )),
            ),
            background: Image.asset("assets/images/bgblue.jpg", fit: BoxFit.cover,)
          ),
          bottom: AppBar(
            toolbarHeight: 70,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextField(
                      readOnly: true,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        hintText: "Sewa mobil murah hanya disini.",
                        hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    onPressed: () {
                      showFilterModal();
                    },
                    icon: Icon(Icons.filter_list, color: Colors.black, size: 30,),
                  ),
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              height: 330,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Populer', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text('Lihat semua ', style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return productCart(productList[index]);
                      }
                    )
                  )
                ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              height: 180,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Untuk Anda', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text('Lihat Semua ', style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return forYou(productList[index]);
                      }
                    )
                  )
                ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              height: 330,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mobil', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text('Lihat semua ', style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return productCart(productList[index]);
                      }
                    )
                  )
                ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              height: 330,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pick up', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text('Lihat semua ', style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return productCart(productList[index]);
                      }
                    )
                  )
                ]
              )
            ),
          ]),
        )
      ]
    );
  }

  Future<void> products() async {
    final String response = await rootBundle.loadString('assets/cars.json');
    final data = await json.decode(response);

    setState(() {
      productList = data['cars']
        .map((data) => Car.fromJson(data)).toList();
    });
  }

  productCart(Car car) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductViewPage(car: car,)));
        },
        child: Container(
          margin: EdgeInsets.only(right: 20, bottom: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [BoxShadow(
              offset: Offset(5, 10),
              blurRadius: 15,
              color: Colors.grey.shade200,
            )],
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(car.imageURL, fit: BoxFit.cover)
                      ),
                    ),
                    // Add to cart button
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: MaterialButton(
                        color: Colors.black,
                        minWidth: 45,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        onPressed: () {
                          addToCartModal();
                        },
                        padding: EdgeInsets.all(5),
                        child: Center(child: Icon(Icons.shopping_cart, color: Colors.white, size: 20,)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(car.name,
                style: TextStyle(color: Colors.black, fontSize: 18,),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(car.brand, style: TextStyle(color: Colors.blue.shade900, fontSize: 14,),),
                  Row(
                    children: [
                      Text(RupiahFormat.convertToIdr(car.price, 0),
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(" /hari", style: TextStyle(color: Colors.black38, fontSize: 14),)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  forYou(Car car) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20, bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [BoxShadow(
            offset: Offset(5, 10),
            blurRadius: 15,
            color: Colors.grey.shade200,
          )],
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(car.imageURL, fit: BoxFit.cover)),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(car.name,
                    style: TextStyle(color: Colors.black, fontSize: 18,),
                  ),
                  SizedBox(height: 5,),
                  Text(car.brand, style: TextStyle(color: Colors.blue.shade900, fontSize: 13,),),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text(RupiahFormat.convertToIdr(car.price, 0),
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      Text(" /hari", style: TextStyle(color: Colors.black38, fontSize: 14),)
                    ],
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filter', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        minWidth: 40,
                        height: 40,
                        color: Colors.grey.shade300,
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.close, color: Colors.black,),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Harga', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                          Text(' /hari', style: TextStyle(color: Colors.grey, fontSize: 14),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(RupiahFormat.convertToIdr(selectedRange.start, 0), style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                          Text(" - ", style: TextStyle(color: Colors.grey.shade500)),
                          Text(RupiahFormat.convertToIdr(selectedRange.end, 0), style: TextStyle(color: Colors.grey.shade500, fontSize: 12),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  RangeSlider(
                    values: selectedRange, 
                    min: 0,
                    max: 10000000,
                    divisions: 100000,
                    inactiveColor: Colors.grey.shade300,
                    activeColor: Colors.yellow[800],
                    labels: RangeLabels(RupiahFormat.convertToIdr(selectedRange.start, 0), RupiahFormat.convertToIdr(selectedRange.end, 0),),
                    onChanged: (RangeValues values) {
                      setState(() => selectedRange = values);
                    }
                  ),
                  SizedBox(height: 20,),
                  button('Filter', () {})
                ],
              ),
            );
          }
        );
      },
    );
  }

  addToCartModal() {
    return showModalBottomSheet(
      context: context, 
      transitionAnimationController: AnimationController(duration: Duration(milliseconds: 400), vsync: this),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                button('Masukkan Keranjang', () {
                  Navigator.pop(context);

                  final snackbar = SnackBar(
                    content: Text("Berhasil dimasukkan keranjang"),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                })
              ],
            ),
          );
        },
      )
    );
  }

  
}
