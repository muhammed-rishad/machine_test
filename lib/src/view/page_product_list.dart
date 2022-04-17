import 'package:flutter/material.dart';
import 'package:machine_test/src/utility/status.dart';
import 'package:machine_test/src/viewModel/product_provider.dart';
import 'package:provider/provider.dart';


class PageProductList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      context.read<ProductProvider>().getProducts();


    });
    return SafeArea(
      child: Scaffold(
        body: Consumer<ProductProvider>(
          builder: (context,provider,child){
          if(provider.status==ProviderStatus.LOADED){
           return Padding(
             padding: EdgeInsets.all(16),
             child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: provider.productList.length,
              itemBuilder: (BuildContext ctx, index) {
              return
                itemCard(context,
              image: provider.productList[index].image!,
              title: provider.productList[index].title!,
              rating: provider.productList[index].rating!.rate!,
              price: provider.productList[index].price!,
              category: provider.productList[index].category!);
              }),
           );
            }else if(provider.status==ProviderStatus.ERROR){
            return Center(
              child: Text('Something error !!!!'),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
          },
        ),
      ),
    );
  }

  Widget itemCard(BuildContext context,{
    required String image,required String title,
    required dynamic  rating,required dynamic price,required String category}){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1 ,color: Colors.blue)
      ),
      height:MediaQuery.of(context).size.height/2,
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 10,
              child:Image.network(image,)),
          Spacer(flex: 1,),
          RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text: title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text:"₹ "+ price.toString()),
                ),
              ),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text:"★ "+ rating.toString()),
                ),
              ),
            ],
          ),
          Spacer(flex: 1,),
          Expanded(
            flex: 8,
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  text:"Cat :"+ category),
            ),
          ),
        ],
      ),
    );
  }
}
