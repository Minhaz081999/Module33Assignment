import 'package:crafty_bay/features/home/presentation/screens/home_screen.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {


  @override
  Widget build(BuildContext context) {
    // System er BackButton k control kora hoy
    return PopScope(
      // 'true' -> hole backButton click korle App theke ber kore dibe
      // 'false' -> hole backButton click korle Home() page niye jabe
      canPop: context.watch<MainNavProvider>().selectedIndex == 0,  // False or True
      onPopInvokedWithResult:(bool canPop, dynamic result)async{
        if (canPop) {
          return;
        } else {
           context.read<MainNavProvider>().backToHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          leading: IconButton(onPressed: () async {
            context.read<MainNavProvider>().backToHome();
          }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                return FittedBox(child: CategoryCard());
              }
          ),
        )

      ),
    );
  }
}
