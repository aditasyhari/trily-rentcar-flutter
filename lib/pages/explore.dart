import 'dart:convert';

import 'package:trily/helpers/ColorsSys.dart';
import 'package:trily/model/car.dart';
import 'package:trily/model/motor.dart';
import 'package:trily/pages/car_view.dart';
import 'package:trily/pages/motor_view.dart';
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

  List<dynamic> carList = [];
  List<dynamic> motorList = [];

  @override
  void initState() { 
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    productCars();
    productMotors();

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
              child: Text("Trily\nSafe and Comfortable.",
                style: TextStyle(
                  color: ColorSys.primary,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                )),
            ),
            background: Image.asset("assets/images/banner.png", fit: BoxFit.cover,)
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
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/images/wallet.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        hintText: RupiahFormat.convertToIdr(670000, 0),
                        hintStyle: TextStyle(fontSize: 16, color: Colors.black, height: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10, width: 10,),
                Container(
                  height: 45,
                  width: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle, color: Colors.white, size: 30,),
                  ),
                ),
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
                      itemCount: carList.length,
                      itemBuilder: (context, index) {
                        return productCar(carList[index]);
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
                      Text('Motor', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
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
                      itemCount: motorList.length,
                      itemBuilder: (context, index) {
                        return productMotor(motorList[index]);
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
                      Text('Pick Up', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
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
                      itemCount: carList.length,
                      itemBuilder: (context, index) {
                        return productCar(carList[index]);
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
                      Text('Trip Wisata', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
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
                      itemCount: carList.length,
                      itemBuilder: (context, index) {
                        return productCar(carList[index]);
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

  Future<void> productCars() async {
    final String response = await rootBundle.loadString('assets/json/populer/mobil.json');
    final data = await json.decode(response);

    setState(() {
      carList = data['cars'].map((data) => Car.fromJson(data)).toList();
    });
  }

  Future<void> productMotors() async {
    final String responseMotor = await rootBundle.loadString('assets/json/populer/motor.json');
    final dataMotor = await json.decode(responseMotor);

    setState(() {
      motorList = dataMotor['motor'].map((dataMotor) => Motor.fromJson(dataMotor)).toList();
    });
  }

  productCar(Car car) {
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
                  Flexible(
                    child: Text(
                      car.brand, 
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 14,),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(width: 12),
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

  productMotor(Motor motor) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MotorViewPage(motor: motor,)));
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
                        child: Image.network(motor.imageURL, fit: BoxFit.cover)
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
              Text(motor.name,
                style: TextStyle(color: Colors.black, fontSize: 18,),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      motor.brand, 
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 14,),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      Text(RupiahFormat.convertToIdr(motor.price, 0),
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
