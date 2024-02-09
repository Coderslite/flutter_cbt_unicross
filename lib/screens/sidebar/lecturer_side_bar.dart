import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicross_cbt_desktop_app/controllers/sidebar_navigation_controller.dart';
import 'package:unicross_cbt_desktop_app/screens/auth/login_screen.dart';

import '../../utilities/color.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
      color: darkBlue,
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [blue!, darkBlue!], begin: Alignment.topCenter)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset("assets/images/logo.png"),
              ),
              Text(
                "UNICROSS CBT",
                style: TextStyle(
                    color: white, fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: blue,
                child: const Icon(Icons.person_3),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: options.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SideBarOption(
                      name: options[index].name,
                      icon: options[index].icon,
                      index: index,
                    );
                  })),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: red,
            ),
            onPressed: () {
              Get.to(const LoginScreen());
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Logout"),
            ),
          )
        ],
      ),
    );
  }

  List<SideBarOption> options = [
    // const SideBarOption(name: "EXAMS", icon: Icons.question_answer),

    const SideBarOption(
      name: "DASHBOARD",
      icon: Icons.home,
    ),
    const SideBarOption(
      name: "UPLOAD QUESTIONS",
      icon: Icons.book,
    ),
    const SideBarOption(
      name: "EXAMS",
      icon: Icons.book,
    ),
    const SideBarOption(name: "RESULTS", icon: Icons.person),
  ];
}

class SideBarOption extends StatefulWidget {
  final String name;
  final IconData icon;
  final int? index;
  const SideBarOption({
    super.key,
    required this.name,
    required this.icon,
    this.index,
  });

  @override
  State<SideBarOption> createState() => _SideBarOptionState();
}

class _SideBarOptionState extends State<SideBarOption> {
  SideNavigationController sideNavigationController =
      Get.put(SideNavigationController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          selected: true,
          selectedTileColor: blue,
          hoverColor: green,
          onTap: () {
            sideNavigationController.handleChangeIndex(widget.index!);
          },
          title: Text(
            widget.name,
            style: TextStyle(
                color: sideNavigationController.index.toInt() == widget.index
                    ? blue
                    : white,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            widget.icon,
            color: white,
          ),
        ),
      ),
    );
  }
}
