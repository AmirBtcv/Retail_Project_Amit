import 'package:amit_final_project/globale/Dialogs.dart';
import 'package:amit_final_project/model/Product.dart';
import 'package:amit_final_project/model/ProductRespone.dart';
import 'package:amit_final_project/network/ServiceApi.dart';
import 'package:amit_final_project/network/Urls.dart';
import 'package:amit_final_project/tabs/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key  key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future <ProductResponse> _productResponse;
  // Future< User> _userFuture;
  @override
  void initState(){
    super.initState();
    _productResponse = ServiceApi.instance.getProducts();
    // _userFuture=ServiceApi.instance.
  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar (
        actions: [
          Padding(
              padding: const EdgeInsets.all(2),
              child: Icon(Icons.filter_alt_outlined,color: Colors.pink[200],size: 30,)
          ),

        ],
        title: Text('Home',style: TextStyle(color: Colors.pink[200]),),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),


      body: FutureBuilder(
        future: _productResponse,
        builder: (context,AsyncSnapshot <ProductResponse> snapshot) {
          if  (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: Center(child: CircularProgressIndicator(),),);
        else if  (snapshot.connectionState == ConnectionState.done && !snapshot.hasData)
          return Center(child: Text('No Data Found'),);

          else if  (snapshot.connectionState == ConnectionState.done && snapshot.hasError)
          return Center(child: Text('Error ${snapshot.error}'),);


          return productsGridView (snapshot.data);



        },

      ),
    );
  }

  Widget productsGridView(ProductResponse data) => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2 / 3),
      itemBuilder: (context,index) {
        return Card(
         margin: EdgeInsets.fromLTRB(5, 15, 5, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 4,
                  child: InkWell
                    ( onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            AlertDialog(
                              title: Container( child: Align(
                                alignment: Alignment.center,
                                  child: Text(data.products[index].name,))),
                              actions: [

                                Column(
                                  children: [

                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton(onPressed: () async {
                                    var list = await  ServiceApi.instance.getCart(token);
                                    int amount =1;
                                    for( var x in list.products){
                                          if(x.product.id == data.products[index].id) {
                                            amount=x.amount+1;
                                            break;
                                          } else{
                                            amount = 1;
                                          }


                                    }
                                    // await Dialogs.showProgressDialog(context: context,msg: "Loading");
                                    addToCart(product:data.products[index],token: token,amount:amount );
                                    // await Dialogs.hideProgressDialog();
                                  } ,

                                          child:Text('Add to card',),
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[200]),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: BorderSide(color: Colors.pink[200])

                                                    )
                                                )
                                            ),


                                          // ElevatedButton.styleFrom(
                                          //   primary: Colors.pink[300], // background
                                          //   onPrimary: Colors.white, // foreground
                                          // ),
                                          ) ,
                                          ),

                                      ],
                                ),
                                SizedBox(width: 25,),


                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    child: Text('${data.products[index].price} ${data.products[index].currency}',
                                    textAlign: TextAlign.center ,
                                      style: TextStyle(color: Colors.pink[300],
                                        fontSize: 25

                                      ),),
                                  ),
                                ),


                                // Text('${data.products[index].price}  ${data.products[index].currency}')
                              ],
                              content: CachedNetworkImage(
                                

                                  imageUrl: data.products[index].avatar
                              ),
                            ),
                        barrierDismissible: true,

                      );
                    },
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: data.products[index].avatar,
                      placeholder: (context,url) => Container(),
                      errorWidget: (context,url,error) => Icon(Icons.error_outline_sharp),
                    ),
                  )),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  data.products[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(
                  data.products[index].name,
                  overflow: TextOverflow.ellipsis,
                  // style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                       var list = await  ServiceApi.instance.getCart(token);
                       int amount =1;
                       for( var x in list.products){
                         if(x.product.id == data.products[index].id) {
                           amount=x.amount+1;
                           break;
                         } else{
                           amount = 1;
                         }


                       }
                       // await Dialogs.showProgressDialog(context: context,msg: "Loading");
                        addToCart(product:data.products[index],token: token,amount:amount );
                        // await Dialogs.hideProgressDialog();
                        } ,
                      child: Container(
                        padding: EdgeInsets.all(3),





                        decoration:
                        BoxDecoration(
                            color: Colors.pink[200],

                          borderRadius: BorderRadius.all(Radius.circular(8)),

                        ),
                        child: Icon(Icons.add,color: Colors.white,),
                      ),

                      // Text()
                    ),
                    Text('${data.products[index].price} ${data.products[index].currency}',
                    style: TextStyle(color: Colors.pink[200],fontSize: 18),),


                  ],
                ),
              ))
              
            ],
          ),
        );

  },
  itemCount: data.products.length,
  );

  addToCart({Product product ,int amount,String token}) async{

    await Dialogs.showProgressDialog(context: context,msg: "Loading");

    String res = await ServiceApi.instance.addToCart(

        token:token,productId:product.id.toString(),amount: amount
    );

    if (ServiceApi.statuscode==200)



    {
      await Dialogs.hideProgressDialog();
      // Add successfully
      Fluttertoast.showToast(
          msg: "Add successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      // user.token = res;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabsPage()));
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TabsPage()));
      // print('token :${ServiceApi.statuscode},$res');

    } else {
      await Dialogs.hideProgressDialog();
      // print('Error :${ServiceApi.statuscode},$res');


      Fluttertoast.showToast(
          msg: ('Error :${ServiceApi.statuscode},$res'),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return;

    }

  }
}
