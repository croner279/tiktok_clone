import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activity"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
        ),
        children: [
          Gaps.v14,
          Text(
            'New',
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade500,
            ),
          ),
          Gaps.v14,
          ListTile(
            contentPadding: EdgeInsets.zero,
            //ListTile의 자체적인 padding이 있어서 이걸 없애줘야 New와 같은 라인에 붙음
            leading: Container(
              width: Sizes.size52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: Sizes.size1,
                  )),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ),
              ),
            ),
            title: RichText(
              //text마다 스타일을 다르게 적용 가능
              text: TextSpan(
                  text: "Account updates : ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: Sizes.size16,
                  ),
                  children: [
                    const TextSpan(
                      text: "Upload longer videos ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: "1h",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ]),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size16,
            ),
          ),
        ],
      ),
    );
  }
}
