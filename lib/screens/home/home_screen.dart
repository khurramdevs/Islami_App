import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/screens/home/home_provider.dart';
import 'package:islami/screens/home/widgets/home_body.dart';
import 'package:islami/screens/home/widgets/home_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    HomeProvider.instance.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>.value(
      value: HomeProvider.instance,
      child: const Scaffold(
        backgroundColor: AppColors.black,
        body: HomeBody(),
        bottomNavigationBar: HomeBottomNav(),
      ),
    );
  }
}
