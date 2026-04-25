import 'package:crafty_bay/features/home/presentation/screens/home_screen.dart';
import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/category_card.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/center_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // স্ক্রিন শুরু হওয়ার সাথে সাথেই পাহারাদার বসিয়ে দিন
    // স্ক্রল অ্যাক্টিভিটি পর্যবেক্ষণ করার জন্য একটি লিসেনার যুক্ত করা হচ্ছে।
    // ইউজার যখনই লিস্টটি স্ক্রল করবে, তখনই এটি '_loadMore' ফাংশনটিকে কল করবে
    // যাতে আমরা চেক করতে পারি নতুন ডাটা লোড করার সময় হয়েছে কি না।
    _scrollController.addListener(_loadMore);
  }

  // এই ফাংশনটি মূলত Infinite Scrolling বা Pagination-এর জন্য ব্যবহার করা হয়।
  // আপনি যখন কোনো লিস্টের একদম নিচের দিকে চলে আসেন, তখন এই ফাংশনটি অটোমেটিক নতুন ডাটা লোড করে।
  void _loadMore() {
    // এটি একটি 'বডিগার্ড' বা 'গেটকিপার'।
    // যদি আগে থেকেই ডাটা লোড হওয়ার কাজ চলতে থাকে (isLoading == true),
    // তবে নতুন করে আবার এপিআই কল না করে এখান থেকেই ফিরে (return) যাও।
    // যাতে একই সাথে বারবার রিকোয়েস্ট গিয়ে অ্যাপ হ্যাং না করে।
    if (context.read<CategoryListProvider>().isLoading) {
      return;
    }
    // যদি নিচের দিকে আর ৩০০ পিক্সেলের কম ডাটা বাকি থাকে
    if (_scrollController.position.extentAfter < 300) {
      // নতুন ডাটা নিয়ে এসো
      context.read<CategoryListProvider>().getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    // System er BackButton k control kora hoy
    return PopScope(
      // 'true' -> hole backButton click korle App theke ber kore dibe
      // 'false' -> hole backButton click korle Home() page niye jabe
      canPop:
          context.watch<MainNavProvider>().selectedIndex == 0, // False or True
      onPopInvokedWithResult: (bool canPop, dynamic result) async {
        if (canPop) {
          return;
        } else {
          context.read<MainNavProvider>().backToHome();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          leading: IconButton(
            onPressed: () async {
              context.read<MainNavProvider>().backToHome();
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: Consumer<CategoryListProvider>(
          builder: (context, categoryListProvider, _) {
            if (categoryListProvider.getInitialDataInProgress) {
              return CenterProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: categoryListProvider.categoryList.length,
                      itemBuilder: (context, index) {
                        return FittedBox(child: CategoryCard(categoryModel: categoryListProvider.categoryList[index],));
                      },
                    ),
                  ),
                  if (categoryListProvider.getMoreDataInProgress)
                    // CenterProgressIndicator(),
                    LinearProgressIndicator()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // পাহারাদারকে ছুটি দিন
    _scrollController.removeListener(_loadMore);

    super.dispose();
  }
}
