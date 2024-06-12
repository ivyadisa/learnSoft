import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/firstpage.dart';
import 'package:secondapp/views/customs/onbardingbutton.dart';
import 'package:secondapp/views/customs/customtextbutton.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

PageController controller = PageController();
final List<FirstPage> _pages = [
  const FirstPage(
    image: "assets/images/page1.png",
    heading: "Welcome to LearnSoft School ERP!",
    text:
        "effortlessly manage students, staff, grades, attendance, and communication all in one place and Save time and resources with a user-friendly system.",
  ),
  const FirstPage(
      heading: "Streamline Your School Management",
      text:
          "Save time and resources with our user-friendly school management system.Gain valuable insights with real-time data and reporting.",
      image: "assets/images/page2.png"),
  const FirstPage(
      heading: "Get Started Now!Get The Experience",
      text:
          "Add a school-themed background image or icon to create a welcoming and familiar atmosphere and a school-themed background image or icon to create a welcoming and familiar atmosphere",
      image: "assets/images/page3.png")
];

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final currentheight = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      final currentHeight = constraints.maxHeight;
      final currentWidth = constraints.maxWidth;
      return Scaffold(
          backgroundColor: backgroundcolor,
          body: Stack(children: [
            SizedBox(
              height: currentHeight,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                children: _pages
                    .map((index) => FirstPage(
                        image: index.image,
                        heading: index.heading,
                        text: index.text))
                    .toList(),
              ),
            ),
            Positioned(
              top: currentHeight * 0.05,
              right: currentWidth * 0.05,
              child: CustomTextbutton(
                label: "SKIP",
                action: homepage,
                size: currentWidth * 0.06,
                color: primarycolor,
              ),
            ),
            Positioned(
              bottom: currentHeight * 0.05,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: secondarycolor,
                      dotColor: Colors.grey,
                      dotHeight: 6, // Height of the rectangles
                      dotWidth: 20, // Width of the rectangles
                      spacing: 6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (_currentPageIndex != 0)
                        CustomButton(
                          size: 190,
                          label: "BACK",
                          icon: Icons.arrow_back_ios_new_rounded,
                          action: () {
                            controller.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          colorbutton: whitecolor.withOpacity(0.7),
                          textcolor: primarycolor,
                        ),
                      CustomButton(
                        size: 190,
                        label: (_currentPageIndex != 2) ? "NEXT" : "LOGIN",
                        icon: Icons.arrow_forward_ios_rounded,
                        action: () {
                          (_currentPageIndex != 2)
                              ? controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn)
                              : homepage();
                        },
                        colorbutton: primarycolor,
                        textcolor: whitecolor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]));
    });
  }

  void homepage() {
    Get.offAndToNamed("/login");
  }
}
