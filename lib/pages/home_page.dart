import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/providers/users_provider.dart';
import 'package:imagine_app_linkedin/widgets/user_photo.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/widgets/post_item.dart';
import 'package:imagine_app_linkedin/services/post_service.dart';
import 'package:imagine_app_linkedin/widgets/custom_sliverappbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> tabBarVisible = ValueNotifier(true);
  ScrollController _controller = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Post> posts = [];
  List<Usuario> users = [];
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
    _getPostsAndUsers();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.getUsers();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _getPostsAndUsers() async {
    posts = await PostService.getPosts();
    setState(() {});
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
              CustomSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Divider(height: 1),
                  UserStatusBar(),
                  ...this.posts.map((post) => PostItem(post: post)).toList(),
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
}

class UserStatusBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Container(
      width: 10,
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        itemCount: usersProvider.users.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _StatusItem(user: usersProvider.users[i]),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final Usuario user;
  const _StatusItem({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CircleAvatar(
              radius: 30,
              child: ClipOval(
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/no-image.png'),
                    image: NetworkImage(user.photo)),
              ),
            ),
          ),
          SizedBox(height: 3),
          Text(user.nombre,overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}