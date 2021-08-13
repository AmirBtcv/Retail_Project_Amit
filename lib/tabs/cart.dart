import 'package:amit_final_project/globale/Dialogs.dart';
import 'package:amit_final_project/login/Login.dart';
import 'package:amit_final_project/model/Cartresponse.dart';
import 'package:amit_final_project/model/CategoryResponse.dart';
import 'package:amit_final_project/model/CategoryResponse.dart';
import 'package:amit_final_project/model/CategoryResponse.dart';
import 'package:amit_final_project/model/ProductRespone.dart';
import 'package:amit_final_project/network/ServiceApi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDFjYjI3MDAxMzEyMmEwMDI3ZTRlY2IyMTE4MzZiNWQ0ZWI1MDMxOGJiMWQ2MWFhYjYxYjllY2ZjOWE3MjFjYTgyYjE1ZTc2YzViODI1ODEiLCJpYXQiOjE2MjgzODkzNjQsIm5iZiI6MTYyODM4OTM2NCwiZXhwIjoxNjU5OTI1MzY0LCJzdWIiOiIyNDEiLCJzY29wZXMiOltdfQ.UhMAP_mhPTAnbmFRBeBVqG4srsJVDY2QT4WxAyISMi5Wm91_UNp5sE_KuGQ8KbDWhPNYrzC0SLaPcmNHbk3clc4iDLgWYI98BnVnqrTvlPVQdPNBt4tje5xZ13kAZbgLm3vpwH--l141_WzxfYbXs-6lfh2bT2yst5RS33uTaJX5c6vpXZjJaJKz8pVAwn4Ll5hbLcCusNa4zax08LIb6Cl2H45aVvSh65ep7ylBy7nuJ6uQb2CiRWIwS5hjHo6qGZ00DVtETkvG4t0XzEZsM5B1LEpGKkIyJj6BZIAL_XIa3tbZPs980nHu0wFcJ4U0qSXfjZ5KigT4wCeAv85fPVygPWvv6v4d-4uHob0P8uScAFoH6a29FGh4AWWLebn-oEL9iuXS-SZclTSD6A5DXZFYVYx_cbSQoqk1HZkFPxekTUmC3__ehEwDPaT0eCjwNaWOEEX8VgqJZ9bdLoVjHJ8tA5BzREoAQyQm9omL5pid-9bKJDentcDDBD7EZ7hSdxbdCDnfkEgTCRpQ9UsGG7qsln-E8DkcPQEi2eSB5_3sv8p6R8CxXNb0Fd5cxBoXhSElkkGmA90V-RLpkkPL_PN_vs9j_0_q02wTm13Q8qj2CWxm1aSMyiy-d1TuljeuSrpOTnAJuhZVGgAK_dCqcx_8u1ZhzVk-vf9e5M7gEYg";

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<CartResponse> _cartResponseFuture;
  double totalPrice = 0.0;

  // Future<Token> _tokenFuture;

  @override
  void initState() {
    super.initState();
    _cartResponseFuture = ServiceApi.instance.getCart(token);
  }

  @override
  Widget build(BuildContext context) {
    // super.initState();

    _cartResponseFuture = ServiceApi.instance.getCart(token);

    return FutureBuilder(
      future: _cartResponseFuture,
      builder: (context, AsyncSnapshot<CartResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData)
          return Center(
            child: Text('No Data Found'),
          );
        else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError)
          return Center(
            child: Text('Error ${snapshot.error}'),
          );

        return Scaffold(
          body: SafeArea(
            child: cartList(cartResponse: snapshot.data),
          ),
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            toolbarHeight: 40,
          ),
        );
      },
    );
  }

  Widget cartList({
    CartResponse cartResponse,
  }) {
    totalPrice = 0;
    cartResponse.products.forEach((element) {
      totalPrice += element.total;
    });

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: cartResponse.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: (Text(
                  cartResponse.products[index].product.title,
                  style: TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                )),
                leading: CachedNetworkImage(
                  imageUrl: cartResponse.products[index].product.avatar,
                  width: 60,
                  height: 80,
                  alignment: Alignment.topLeft,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline_sharp),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cartResponse.products[index].product.name,
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'Price : ${cartResponse.products[index].product.priceFinalText}',
                              style: TextStyle(fontSize: 15),
                            )),
                        Expanded(
                            child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  var list =
                                      await ServiceApi.instance.getCart(token);

                                  int amount =
                                      cartResponse.products[index].amount - 1;
                                  ServiceApi.instance.addToCart(
                                      productId: cartResponse
                                          .products[index].product.id
                                          .toString(),
                                      token: token,
                                      amount: amount);

                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      )),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                ),
                              )),
                              Expanded(
                                  child: Container(
                                child: Center(
                                    child: Text(
                                  '${cartResponse.products[index].amount}',
                                  style: TextStyle(fontSize: 15),
                                )),
                                decoration:
                                    BoxDecoration(color: Colors.grey[300]),
                                // decoration: BoxDecoration(
                                //   color: Colors.blueAccent,
                                //   borderRadius: BorderRadius.only(
                                //     topLeft: Radius.circular(5),
                                //     bottomLeft: Radius.circular(5),
                                //
                                //
                                //   )),
                                // child: Icon(Icons.remove,color: Colors.white,),
                                padding: EdgeInsets.all(5.0),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  var list =
                                      await ServiceApi.instance.getCart(token);
                                  // int amount =1;

                                  int amount =
                                      cartResponse.products[index].amount + 1;
                                  ServiceApi.instance.addToCart(
                                      productId: cartResponse
                                          .products[index].product.id
                                          .toString(),
                                      token: token,
                                      amount: amount);

                                  setState(() {});

                                  // int amount = s
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                ),
                              )),
                            ],
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('total'),
              Text(
                ': ${totalPrice}  EGP',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              await Dialogs.showProgressDialog(
                  context: context, msg: "Loading");
              var list = await ServiceApi.instance.getCart(token);
              for (var element in list.products) {
                await ServiceApi.instance.addToCart(
                    productId: element.product.id.toString(),
                    amount: 0,
                    token: token);
                await Dialogs.hideProgressDialog();
              }
              setState(() {});
              await Dialogs.hideProgressDialog();
            },
            child: Text(
              'Proceed to checkout',
              // style: TextStyle(fontSize: 18,color: Colors.white,
              // ),
            ),
            style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
          ),
        ),
      ],
    );
  }
}
