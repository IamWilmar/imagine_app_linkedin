import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/widgets/create_post_button.dart';
import 'package:imagine_app_linkedin/widgets/post_creation_user_info.dart';
import 'package:imagine_app_linkedin/widgets/post_creation_bottombar.dart';
import 'package:imagine_app_linkedin/widgets/privacy_modal_tile.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:imagine_app_linkedin/widgets/post_page_widgets.dart';
import 'package:imagine_app_linkedin/providers/custom_tabbar_provider.dart';

/*
  PAGINA PARA LA CREACIÓN DE POST
*/

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  TextEditingController _postContent = TextEditingController();
  Post post = new Post();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //Activa el bottomModal que aparece por defecto al acceder a la pagina
      await _mainModal(context, 0);
      //Asgina los valores de los provider.
      final authService = Provider.of<AuthService>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      final tabIndex = Provider.of<CustomtabBarProvider>(context, listen: false);
      postProvider.de = authService.usuario.uid;
      postProvider.username = authService.usuario.nombre;
      postProvider.userPhoto = authService.usuario.photo;
      postProvider.privacy = 'Anyone';
      postProvider.content = '';
      tabIndex.index = 0;
    });
  }

  @override
  void dispose() {
    _postContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Start post', style: TextStyle(color: Colors.black)),
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),
        actions: [Center(child: PostButton())], //Boton para publicar Post
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //Construye la parte superior de la pagina.
                  //Contiene la informacion de usuario y el boton de cambio de privacidad.
                  UserTopInfo(onPressed: () => _choosePrivacySettings(context)), 
                  _createTextSpace(context), // Construye el widget para agregar el contenido de post
                ],
              ),
            ),
          ),
          //Crea la barra inferior
          PostCreationBottomBar(
            onPressedEllipsis: () => _mainModal(context, 300),
            onPressedPrivacy: () => _choosePrivacySettings(context),
          ), 
        ],
      ),
    );
  }

  //Creación del campo de texto para el contenido del post
  Widget _createTextSpace(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Container(
      height: 300,
      margin: EdgeInsets.only(left: 10, right: 5),
      child: TextField(
        controller: _postContent,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'What do you want to talk about?',
          border: InputBorder.none,
        ),
        onChanged: (String content) {
          //Guardar el texto en el provider al detectar un cambio
          postProvider.content = _postContent.text;
          setState(() {});
        },
      ),
    );
  }

  //Genera el modal para Elegir la privacidad de post
  _choosePrivacySettings(BuildContext context) async {
    final modalTitle = "Who can see this post?";
    final modalTitleStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    final modalSubtitle =
        "Your post will be visible on feed, on your profile and in search results";
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(Duration(milliseconds: 300));
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreyUpperSeparator(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(modalTitle, style: modalTitleStyle),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(modalSubtitle),
            ),
            PrivacyTile(
              icon: Icons.public,
              title: 'Anyone',
              subtitle: 'Anyone on or off LinkedIn',
              index: 0,
            ),
            PrivacyTile(
              icon: Icons.people,
              title: 'Connections only',
              subtitle: 'Connection on LinkedIn',
              index: 1,
            ),
            PrivacyTile(
              icon: Icons.group_work_rounded,
              title: 'Group members',
              subtitle: 'Select a group you are in',
              index: 2,
            ),
          ],
        );
      },
    );
  }

  //Crea el Modal que aparece al inicial la pagina
  //Para mostrarlo de nuevo Presionar icono de los tres puntos
  //En la barra inferior
  _mainModal(BuildContext context, int milliseconds) async {
    final optionStyle = TextStyle(fontWeight: FontWeight.w600);
    final Map<IconData, String> modalElements = {
      Icons.photo: 'Add Photo',
      Icons.video_call: 'Take a video',
      Icons.star: 'Celebrate an occasion',
      Icons.article: 'Add a document',
      Icons.work: 'Share that you\'re hiring',
      Icons.assignment_ind: 'Find an expert',
      Icons.collections: 'Share a story',
      Icons.leaderboard: 'Create a poll',
    };
    FocusScope.of(context).requestFocus(FocusNode());
    await Future.delayed(Duration(milliseconds: milliseconds));
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GreyUpperSeparator(),
            ...modalElements.entries
                .map((e) => ListTile(
                    leading: Icon(e.key),
                    title: Text(e.value, style: optionStyle)))
                .toList(),
          ],
        );
      },
    );
  }

}

