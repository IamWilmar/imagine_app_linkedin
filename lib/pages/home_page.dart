import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> tabBarVisible = ValueNotifier(true);
  ScrollController _controller = new ScrollController();
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                          )),
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
                  //_Boxes(Colors.white),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
                  _Boxes(Colors.amber),
                  _Boxes(Colors.red),
                  _Boxes(Colors.green),
                  _Boxes(Colors.blue),
                  _Boxes(Colors.blueGrey),
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
                  Icon(Icons.post_add_rounded),
                  Icon(Icons.notifications_sharp),
                  Icon(Icons.cases),
                ],
              ),
            ),
            builder: (context, value, child){
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
