import 'package:api/views/homepage.dart';
import 'package:api/views/onboarding_contents.dart';
import 'package:api/views/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  // List colors = [
  //   Color(0xffFFFFFF),
  //   Color(0xffFFFFFF),
  //   Color(0xffFFFFFF),
  //   Color(0xffFFFFFF),
  //   Color(0xffFFFFFF),
  //   Color(0xffFFFFFF)
  // ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color:
            _currentPage == index ? Colors.greenAccent : Colors.grey.shade300,
      ),
      margin: const EdgeInsets.only(right: 5, top: 50),
      height: 7,
      curve: Curves.easeIn,
      width: _currentPage == index ? 7 : 7,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    double blockH = SizeConfig.blockH!;
    double blockV = SizeConfig.blockV!;

    return Scaffold(
      //backgroundColor: colors[_currentPage],

      backgroundColor: Color(0xffFFFFFF),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: contents.length,
              itemBuilder: (context, i) {
                return Container(
                  // color: colors[i],
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 90,
                        ),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w600,
                            fontSize: (width <= 550) ? 30 : 35,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Image.asset(
                          contents[i].image,
                          height: SizeConfig.blockV! * 25,
                        ),
                        SizedBox(
                          height: (height >= 840) ? 40 : 30,
                        ),
                        Text(
                          contents[i].desc,
                          style: TextStyle(
                            fontFamily: "Mulish",
                            fontWeight: FontWeight.w300,
                            fontSize: (width <= 550) ? 17 : 25,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (int index) => _buildDots(index: index),
                  ),
                ),
                _currentPage + 1 == contents.length
                    ? Padding(
                        padding: const EdgeInsets.all(30),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAll(() => const HomePage());
                          },
                          child: Text("START"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: (width <= 550)
                                ? EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)
                                : EdgeInsets.symmetric(
                                    horizontal: width * 0.2, vertical: 25),
                            textStyle:
                                TextStyle(fontSize: (width <= 550) ? 13 : 17),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _controller.jumpToPage(6);
                              },
                              child: Text("SKIP"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFA4A0C),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                                padding: (width <= 550)
                                    ? EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10)
                                    : EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: Text("NEXT"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF6F1CB7),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                                padding: (width <= 550)
                                    ? EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10)
                                    : EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 15),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
