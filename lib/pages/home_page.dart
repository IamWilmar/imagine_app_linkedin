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

/* 
PAGINA DE INICIO:
-ESTADO DE USUARIOS,
-POSTS,
-BARRA INFERIOR DE NAVEGACIÓN
*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<bool> tabBarVisible = ValueNotifier(true); //Se encarga de notificar si la barra debe ser visible
  ScrollController _controller = new ScrollController(); //contrlador del scroll para saber la posicion
  List<Post> posts = [];
  List<Usuario> users = [];
  double scrollAnterior = 0;

  @override
  void initState() {
    _createControllerListener();
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    final postListProvider =
        Provider.of<PostListProvider>(context, listen: false);
    //Obtienen los Usuarios y los post y los alamcenan en
    // los atributos de los provider correspondientes.
    userProvider.getUsers();
    postListProvider.getPosts();
    super.initState();
  }

  @override
  void dispose() {
    //Elimina el controlador cuando no es necesario
    _controller.dispose();
    super.dispose();
  }

  /*
    Función responsable de cambiar el valor de tabbarVisible
    (responsable de mostrar la barra inferior)
   */
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
                  UserStatusBar(), //Genera la barra de status de los usuario
                  ...postListProvider.posts
                      .map((post) => PostItem(post: post))
                      .toList(),//Genera los post obteniendolos a través de provider
                ]),
              ),
            ],
          ),
          //Escucha a tabbarVisible para saber si
          //la barra Inferior deberia mostrarse
          ValueListenableBuilder<bool>(
            valueListenable: tabBarVisible,
            child: CustomBottomBar(), //Constuye la barra Inferior(Widgets/home_bottombar.dart)
            builder: (context, value, child) {
              //Anima el cambio de posición de la barra inferior
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
