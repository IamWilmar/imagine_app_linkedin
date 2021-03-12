import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> tabBarVisible = ValueNotifier(true);
  ScrollController _controller = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  double scrollAnterior = 0;
  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.offset > scrollAnterior && _controller.offset > 150) {
        tabBarVisible.value = false;
      } else {
        tabBarVisible.value = true;
      }
      scrollAnterior = _controller.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEBE9),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                actions: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 60, top: 10, bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFC8CDD0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.search, color: Color(0xFF42494D)),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.grid_view, color: Color(0xFF42494D))
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.message_outlined, color: Colors.black),
                    onPressed: () {
                      print('hola');
                    },
                  ),
                ],
                floating: true,
                leading: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Divider(height: 1),
                  UserStatusBar(),
                  PostItem(),
                  PostItem(),
                  PostItem(),
                  PostItem(),
                  PostItem(),
                  PostItem(),
                ]),
              ),
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: tabBarVisible,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.home),
                  Icon(Icons.people_alt_sharp),
                  InkWell(
                    child: Icon(Icons.post_add_rounded),
                    onTap: () {
                      print('Post button');
                      Navigator.pushNamed(context, 'post');
                    },
                  ),
                  Icon(Icons.notifications_sharp),
                  Icon(Icons.cases),
                ],
              ),
            ),
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 3000),
                left: 0,
                right: 0,
                bottom: value ? 0 : -kToolbarHeight,
                height: kToolbarHeight,
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _postList() {
    return ListView(
      children: [
        PostItem(),
        PostItem(),
        PostItem(),
        PostItem(),
        PostItem(),
        PostItem(),
      ],
    );
  }
}

class _Boxes extends StatelessWidget {
  final color;
  const _Boxes(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 100,
      color: color,
    );
  }
}

class UserStatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 100,
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        children: [
          _StatusItem(),
          _StatusItem(),
          _StatusItem(),
          _StatusItem(),
          _StatusItem(),
          _StatusItem(),
          _StatusItem(),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  const _StatusItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey,
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _userInfo(),
          SizedBox(height: 10),
          _postContent(),
          _reactionBar(),
          Divider(),
          _interactionBar(),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Row(
      children: <Widget>[
        CircleAvatar(),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text('Nombre Completo'),
                SeparationDot(),
                Text('1st'),
              ],
            ),
            Text('Current job of the user'),
            Row(
              children: <Widget>[
                Text('41m'),
                SeparationDot(),
                Text('Edited'),
                SeparationDot(),
                Icon(Icons.public, size: 15),
              ],
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
      ],
    );
  }

  Widget _postContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              maxLines: 4,
              overflow: TextOverflow.fade),
        ],
      ),
    );
  }

  Widget _reactionBar() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Icon(Icons.thumb_up_alt_rounded, size: 15, color: Colors.blue),
          SizedBox(width: 3),
          Text('1'),
        ],
      ),
    );
  }

  Widget _interactionBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InteractionButton(
              icon: Icons.thumb_up_alt_outlined, buttonName: 'Like'),
          InteractionButton(
              icon: Icons.comment_outlined, buttonName: 'Comment'),
          InteractionButton(icon: Icons.share, buttonName: 'Share'),
          InteractionButton(icon: Icons.send, buttonName: 'Send'),
        ],
      ),
    );
  }
}

class SeparationDot extends StatelessWidget {
  const SeparationDot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}

class InteractionButton extends StatelessWidget {
  final IconData icon;
  final String buttonName;
  const InteractionButton({
    Key key,
    this.icon,
    this.buttonName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(buttonName),
      ],
    );
  }
}
