import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/basket/basket_bloc.dart';
import 'package:flutter_application_1/bloc/basket/basket_event.dart';
import 'package:flutter_application_1/bloc/category/category_bloc.dart';
import 'package:flutter_application_1/bloc/home/home_bloc.dart';
import 'package:flutter_application_1/constans/colors.dart';
import 'package:flutter_application_1/data/model/card/card_items.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/screens/card_screen.dart';
import 'package:flutter_application_1/screens/categorys_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // creat local database
  await Hive.initFlutter();
  Hive.registerAdapter(
    BasketItemAdapter(),
  );
  await Hive.openBox<BasketItem>('CardBox');

  
  //
  await getItInin();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavagation = 0;
  @override
  Widget build(BuildContext context) {
    // var control = PageController(viewportFraction: 0.8);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: BlocProvider(
        //   create: (context) => AuthBloc(),
        //   child: LoginScr(),
        // ),
        body: IndexedStack(
          index: selectedBottomNavagation,
          children: getScreen(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  selectedBottomNavagation = index;
                });
              },
              currentIndex: selectedBottomNavagation,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                  fontFamily: 'SB', fontSize: 10, color: CustomColor.blue),
              unselectedLabelStyle: const TextStyle(
                  fontFamily: 'SB', fontSize: 10, color: CustomColor.gray),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset('assets/images/icon_home.png'),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.blue,
                            spreadRadius: -7,
                            blurRadius: 20,
                            offset: Offset(0.0, 13),
                          ),
                        ],
                      ),
                      child: Image.asset('assets/images/icon_home_active.png'),
                    ),
                  ),
                  label: 'صفحه اصلی',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset('assets/images/icon_category.png'),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColor.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child:
                          Image.asset('assets/images/icon_category_active.png'),
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset('assets/images/icon_basket.png'),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColor.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child:
                          Image.asset('assets/images/icon_basket_active.png'),
                    ),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.asset('assets/images/icon_profile.png'),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: CustomColor.blue,
                              spreadRadius: -7,
                              blurRadius: 20,
                              offset: Offset(0.0, 13)),
                        ],
                      ),
                      child:
                          Image.asset('assets/images/icon_profile_active.png'),
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
              ],
            ),
          ),
        ),
        //
      ),
    );
  }

  List<Widget> getScreen() {
    return <Widget>[
      BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScr(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScr(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetachFromHineEvent());
          return bloc;
        },
        child: const CardScr(),
      ),
      const ProfileScr(),
    ];
  }
}
