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
          backgroundColor: Colors.teal,
          elevation: 1,
          floating: true,
          pinned: true,
          stretch: true,
          snap: true,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            centerTitle: true,
            title: const Text("hello!"),
            background: Image.asset(
              "assets/images/placeholder.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                childCount: 50,
                (context, index) => Container(
                      color: Colors.amber[100 * (index % 9)],
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('Item $index')),
                    )),
            itemExtent: 50)
      ],
    );
  }
}
