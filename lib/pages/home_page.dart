import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/widgets/home_bottombar.dart';
import 'package:imagine_app_linkedin/widgets/user_status.dart';
import 'package:imagine_app_linkedin/providers/post_list_provider.dart';
import 'package:imagine_app_linkedin/models/usuario_model.dart';
import 'package:imagine_app_linkedin/providers/users_provider.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/widgets/post_item.dart';
import 'package:imagine_app_linkedin/widgets/custom_sliverappbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> tabBarVisible = ValueNotifier(true);
  ScrollController _controller = new ScrollController();
  List<Post> posts = [];
  List<Usuario> users = [];
  double scrollAnterior = 0;

  @override
  void initState() {
    _createControllerListener();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final postListProvider =
        Provider.of<PostListProvider>(context, listen: false);
    userProvider.getUsers();
    postListProvider.getPosts();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createControllerListener() {
    _controller.addListener(() {
      if (_controller.offset > scrollAnterior && _controller.offset > 150) {
        tabBarVisible.value = false;
      } else {
        tabBarVisible.value = true;
      }
      scrollAnterior = _controller.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postListProvider = Provider.of<PostListProvider>(context);
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
                  ...postListProvider.posts
                      .map((post) => PostItem(post: post))
                      .toList(),
                ]),
              ),
            ],
          ),
          ValueListenableBuilder<bool>(
            valueListenable: tabBarVisible,
            child: CustomBottomBar(),
            builder: (context, value, child) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 300),
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
