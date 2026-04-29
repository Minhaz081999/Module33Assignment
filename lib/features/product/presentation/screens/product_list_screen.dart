import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:crafty_bay/features/product/presentation/providers/productListProvider.dart';
import 'package:crafty_bay/features/shared/data/models/category_model.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, //required this.category,
  //required this.productModel
  });

  static const String name = 'product-list';
  //final CategoryModel category;
  //final ProductModel productModel;


  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListProvider _productListProvider = ProductListProvider();
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // _productListProvider.getProducts(widget.category.id);
      //_productListProvider.getProducts(widget.productModel.id);
_productListProvider.getProducts('categoryId');

      _scrollController.addListener(loadMore);
    });
  }

  void loadMore() {
    if (_productListProvider.isLoading) {
      return;
    }
    if (_scrollController.position.extentAfter < 300) {
     // _productListProvider.getProducts(widget.category.id);
      _productListProvider.getProducts('1');
    }
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Scaffold(
        appBar: // AppBar(title: Text(widget.category.title)),
                //AppBar(title: Text(widget.productModel.title))
                AppBar(title: Text(_productListProvider.categoryName) ),
        body: Consumer<ProductListProvider>(
          builder: (context, productListProvider, _) {
            if(productListProvider.getInitialDataInProgress){
              return CenterProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemCount: productListProvider.productList.length,
                    itemBuilder: (context, index) {
                      // minutes : 41:36
                      return FittedBox(child: ProductCard(
                        productModel: productListProvider.productList[index],

                      ));
                    },
                  ),
                ),
                if (productListProvider.getMoreDataInProgress)
                  LinearProgressIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }
}
