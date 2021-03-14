import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/providers/custom_tabbar_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomBarItem(
            icon: Icons.home,
            buttoName: 'Home',
            onPressed: () {},
            index: 0,
          ),
          CustomBarItem(
            icon: Icons.group,
            buttoName: 'My Network',
            onPressed: () {},
            index: 1,
          ),
          CustomBarItem(
            icon: Icons.post_add,
            buttoName: 'Post',
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pushNamed(context, 'post');
            },
            index: 2,
          ),
          CustomBarItem(
            icon: Icons.notifications,
            buttoName: 'Notifications',
            onPressed: () {},
            index: 3,
          ),
          CustomBarItem(
            icon: Icons.work,
            buttoName: 'Jobs',
            onPressed: () {},
            index: 4,
          ),
        ],
      ),
    );
  }
}

class CustomBarItem extends StatelessWidget {
  final IconData icon;
  final String buttoName;
  final VoidCallback onPressed;
  final int index;
  const CustomBarItem({
    Key key,
    this.icon,
    this.buttoName,
    this.onPressed,
    this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tabIndex = Provider.of<CustomtabBarProvider>(context);
    return InkWell(
      onTap: () {
        tabIndex.index = index;
        onPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: tabIndex.index == index ? Colors.black : Colors.transparent,
            width: 50,
            height: 3,
          ),
          Icon(
            icon,
            color: tabIndex.index == index ? Colors.black : Colors.grey,
            size: tabIndex.index == index ? 30 : 26,
          ),
          Text(buttoName),
          SizedBox(height: 3),
        ],
      ),
    );
  }
}
