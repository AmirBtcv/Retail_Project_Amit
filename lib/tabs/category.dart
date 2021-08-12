import 'package:amit_final_project/model/CategoryResponse.dart';
import 'package:amit_final_project/network/ServiceApi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key key}) : super(key: key);


  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Future<CategoryResponse> _categoryResponseFuture;


  @override
  void initState() {
    super.initState();
    _categoryResponseFuture = ServiceApi.instance.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',style: TextStyle(
          fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueAccent
        ),),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _categoryResponseFuture,
          builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: Center(child: CircularProgressIndicator(),),);
            else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData)
              return Center(child: Text('No Data Found'),);

            else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError)
              return Center(child: Text('Error ${snapshot.error}'),);


            return CategoryGridView(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget CategoryGridView(CategoryResponse data) {
    // return (),

    return Column(
      children: [
        Expanded(child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: data.categories.length,
          itemBuilder: (context, index) {
            return Container(decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400])
            ),
              child: Stack(fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.fill,
                    color: Colors.grey[500],
                    colorBlendMode: BlendMode.darken,
                    imageUrl: data.categories[index].avatar,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline_sharp),

                  ),
                  Align(
                    alignment:Alignment.center ,
                    child: Text(data.categories[index].name,
                    style: TextStyle(color: Colors.white,
                        // fontWeight: FontWeight.bold,
                    fontSize: 20),),
                  ),
                  Align(alignment: Alignment.topLeft,
                    child: Padding(padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(data.categories[index].id.toString(),style:
                        TextStyle(color: Colors.white),),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        
                        color: Colors.blueAccent

                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),),
                  )

                ],),
            );
          },

        ))
      ],
    );

    //   Column(
    //   children: [
    //     Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 20),
    //       child: Text(
    //         'Categories',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 20),
    //       ),
    //     ),
    //     Expanded(child: child)
    //
    //   ],
    //
    // );

  }
}