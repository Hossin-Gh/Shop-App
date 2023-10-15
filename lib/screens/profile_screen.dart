
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constans/colors.dart';

class ProfileScr extends StatelessWidget {
  const ProfileScr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 44, right: 44, top: 10, bottom: 34),
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/icon_apple_blue.png'),
                      const Text(
                        'حساب کاربری',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: CustomColor.blue,
                          fontFamily: 'SB',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'حسین غلامی',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            const Text(
              '09109108736',
              style: TextStyle(fontFamily: 'SM', fontSize: 10),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: [
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                    // CategoryItemChip(),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text('Appel',
                style: TextStyle(fontFamily: 'sm', fontSize: 10)),
            const Text('v-1.0.0',
                style: TextStyle(fontFamily: 'sm', fontSize: 10)),
            const Text('sdfsdfsdfsdf',
                style: TextStyle(fontFamily: 'sm', fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
