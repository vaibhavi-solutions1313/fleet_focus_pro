import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../../../widgets/our_dropdown_strings.dart';

PageController pageController = PageController();

class StartupViews extends StatefulWidget {
  const StartupViews({super.key});

  @override
  State<StartupViews> createState() => _StartupViewsState();
}

class _StartupViewsState extends State<StartupViews> {
  double _progress = 0.1;

  @override
  void initState() {
    super.initState();

    // Add a listener to the PageController to update the progress when pages are scrolled
    pageController.addListener(() {
      setState(() {
        _progress = pageController.page! / 8; // Assuming you have 3 pages
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    StartupViewOne(),
                    StartupViewSecond(),
                    StartupViewThree(),
                    StartupViewFour(),
                    StartupViewFive(),
                    StartupViewSix(),
                    StartupViewSeven(),
                    StartupViewEight()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OurButton(
                    onTap: () {
                      pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                    },
                    title: 'Next',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 1

class StartupViewOne extends StatefulWidget {
  const StartupViewOne({super.key});

  @override
  State<StartupViewOne> createState() => _StartupViewOneState();
}

class _StartupViewOneState extends State<StartupViewOne> {
  List<dynamic> firstForm = ["1-2", "3-4", "5-9", "10-39", "40-99", "100+"];
  int selectedFirstFormIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Let’s get you into a demo. Great, and how many vehicles in your fleet?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: const Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            firstForm.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedFirstFormIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.sp),
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 14.sp),
                decoration: selectedFirstFormIndex != index
                    ? BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(12.sp))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
                        ),
                      ),
                child: Row(
                  children: [
                    // selectedFirstFormIndex == index
                    //     ? Container(
                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.sp), color: Colors.white, border: Border.all(color: Colors.blue)),
                    //         child: Padding(
                    //           padding: EdgeInsets.all(10.sp),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(50.sp),
                    //               color: Colors.blue,
                    //             ),
                    //             width: 15.sp,
                    //             height: 15.sp,
                    //           ),
                    //         ),
                    //       )
                    //     : Container(
                    //         margin: EdgeInsets.only(left: 6.sp, right: 6.sp),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50.sp),
                    //           border: Border.all(color: Colors.grey),
                    //         ),
                    //         width: 20.sp,
                    //         height: 20.sp,
                    //       ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Text(
                      firstForm[index],
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: selectedFirstFormIndex != index ? Colors.black54 : Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 2
class StartupViewSecond extends StatefulWidget {
  const StartupViewSecond({super.key});

  @override
  State<StartupViewSecond> createState() => _StartupViewSecondState();
}

class _StartupViewSecondState extends State<StartupViewSecond> {
  List<dynamic> secondForm = ["GPS fleet tracking", "Equipment and asset tracking", "Dashcam", "Fuel tax reporting", "Electronic Work Dairy"];
  int selectedSecondFormIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Great, and what features are you interested in?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            secondForm.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedSecondFormIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.sp),
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 14.sp),
                decoration: selectedSecondFormIndex != index
                    ? BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(12.sp))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
                        ),
                      ),
                child: Row(
                  children: [
                    // selectedSecondFormIndex == index
                    //     ? Container(
                    //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.sp), color: Colors.white, border: Border.all(color: Colors.blue)),
                    //         child: Padding(
                    //           padding: EdgeInsets.all(10.sp),
                    //           child: Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(50.sp),
                    //               color: Colors.blue,
                    //             ),
                    //             width: 15.sp,
                    //             height: 15.sp,
                    //           ),
                    //         ),
                    //       )
                    //     : Container(
                    //         margin: EdgeInsets.only(left: 6.sp, right: 6.sp),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(50.sp),
                    //           border: Border.all(color: Colors.grey),
                    //         ),
                    //         width: 20.sp,
                    //         height: 20.sp,
                    //       ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Text(
                      secondForm[index],
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: selectedSecondFormIndex == index
                          ? Colors.white : Colors.black54),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 3

class StartupViewThree extends StatefulWidget {
  const StartupViewThree({super.key});

  @override
  State<StartupViewThree> createState() => _StartupViewThreeState();
}

class _StartupViewThreeState extends State<StartupViewThree> {
  List<String> countryList = [
    "Australia",
    "India",
    "Canada",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Ok, and where are you located?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        OurListStringDropDown(
          dropdownItems: countryList,
          onDropdownChanged: (value) {},
        )
      ],
    );
  }
}

// 4

class StartupViewFour extends StatefulWidget {
  const StartupViewFour({super.key});

  @override
  State<StartupViewFour> createState() => _StartupViewFourState();
}

class _StartupViewFourState extends State<StartupViewFour> {
  TextEditingController companyName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "And what company do you work for?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        OurTextField(hint: 'Company Name', controller: companyName)
      ],
    );
  }
}

// 5
class StartupViewFive extends StatefulWidget {
  const StartupViewFive({super.key});

  @override
  State<StartupViewFive> createState() => _StartupViewFiveState();
}

class _StartupViewFiveState extends State<StartupViewFive> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Almost there G, where should we send your information?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        OurTextField(hint: 'Soodan@outlook.com', controller: email)
      ],
    );
  }
}

// 6
class StartupViewSix extends StatefulWidget {
  const StartupViewSix({super.key});

  @override
  State<StartupViewSix> createState() => _StartupViewSixState();
}


class _StartupViewSixState extends State<StartupViewSix> {
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Wrapping up, what’s a good phone number for you?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        OurTextField(hint: 'Phone number', controller: phone),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
          child: Text(
              "Note: Verizon Connect may occasionally have products or services that we think may be of interest to you. By submitting this form, you give us your consent to use automated technology to call and tet you  at the phone number(s) above, including your wireless number if provided. Consent is not required to receive Verizon Connect services."),
        )
      ],
    );
  }
}

// 7
class StartupViewSeven extends StatefulWidget {
  const StartupViewSeven({super.key});

  @override
  State<StartupViewSeven> createState() => _StartupViewSevenState();
}

class _StartupViewSevenState extends State<StartupViewSeven> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "What’s your name?",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(
                onPressed: () {
                  pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        OurTextField(hint: 'First Name', controller: firstName),
        SizedBox(
          height: 15.sp,
        ),
        OurTextField(hint: 'Last Name', controller: lastName),
      ],
    );
  }
}

// 8
class StartupViewEight extends StatefulWidget {
  const StartupViewEight({super.key});

  @override
  State<StartupViewEight> createState() => _StartupViewEightState();
}

class _StartupViewEightState extends State<StartupViewEight> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Thanks for you request",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Color(0xFF524C4C)),
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.cancel_outlined))
          ],
        ),
        SizedBox(
          height: 15.sp,
        ),
        Text("We’ll be in touch soon to schedule your live product demo"),
        SizedBox(
          height: 15.sp,
        ),
        Text(

          "See our platform in action",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 15.sp,
        ),
        Text("Get a preview of the top Verizon Connect features."),
        SizedBox(
          height: 8.sp,
        ),
        Text("Watch the videos."),
        Image.asset("assets/sample_img.png")
      ],
    );
  }
}
