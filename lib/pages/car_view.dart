import 'package:trily/model/car.dart';
import 'package:flutter/material.dart';
import 'package:trily/parts/button.dart';
import 'package:trily/parts/currency.dart';

class ProductViewPage extends StatefulWidget {
  final Car car;
  const ProductViewPage({ Key? key, required this.car }) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<dynamic> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
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
              background: Image.network(widget.car.imageURL, fit: BoxFit.cover,)
            ),
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
                    )
                  ),
                ),
              )
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.car.name,
                              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,),
                            ),
                            SizedBox(height: 5,),
                            Text(widget.car.brand, style: TextStyle(color: Colors.orange.shade400, fontSize: 14,),),
                          ],
                        ),
                        Text(RupiahFormat.convertToIdr(widget.car.price, 0),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(widget.car.ket,
                      style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15,),
                    ),                   
                    SizedBox(height: 20,),
                    button('Rent Car', () {Navigator.pop(context);}),
                    
                  ],
                )
              )
            ])
          ),
        ]
      ),
    );
  }
}