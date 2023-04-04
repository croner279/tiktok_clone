import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
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
      slivers: [
        SliverAppBar(
          title: const Text('울쨩몬'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.gear, size: Sizes.size20))
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                  radius: 50,
                  //foregroundImage: NetworkImage(url),
                  child: Text('울쨩이')),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@pearlisgood",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Colors.blue.shade300,
                    size: Sizes.size16,
                  ),
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "96",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h5,
                        Text(
                          "Following",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    //VerticalDivider는 부모 위젯의 height를 가져다 쓰기 때문에, 상위 위젯인 Row를 SizedBox로 감싸서 height를 지정해줘야 함.
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade400,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                    ),
                    Column(
                      children: [
                        const Text(
                          "10M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h5,
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade400,
                      indent: Sizes.size12,
                      endIndent: Sizes.size12,
                    ),
                    Column(
                      children: [
                        const Text(
                          "197M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h5,
                        Text(
                          "Likes",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
