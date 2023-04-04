import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

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
        const SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
              )
            ],
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
            itemExtent: 50),
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          pinned: true,
        ),
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
                childCount: 50,
                (context, index) => Container(
                    color: Colors.blue[100 * (index % 9)],
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Item $index')))),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: Sizes.size20,
              crossAxisSpacing: Sizes.size20,
              childAspectRatio: 1,
            ))
      ],
    );
  }
}

// 아래 클래스는 직접 수작업으로 만들어줘야함. Delegate Class extends 해서
class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'Title!!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

//밑으로 스크롤링 하다보면 헤더가 줄어들거나 늘어남.
  @override
  double get minExtent => 100;

//flutter에게 persistent header가 보여져야 되는지 알려주는 메소드
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
