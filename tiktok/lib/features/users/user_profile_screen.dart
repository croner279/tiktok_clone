import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        //slivers는 Widget들의 list이지만 아무 widget이나 넣을 수 있는 건 아님.
        SliverAppBar(
          floating: true,
          stretch: true,
          collapsedHeight: 100,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
              StretchMode.zoomBackground,
            ],
            centerTitle: true,
            title: const Text("hello!"),
            background: Image.asset(
              "assets/images/placeholder.jpg",
              fit: BoxFit.cover,
            ),
          ),
          backgroundColor: Colors.teal,
          elevation: 1,
        )
      ],
    );
  }
}
