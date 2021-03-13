import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/models/post_model.dart';
import 'package:imagine_app_linkedin/widgets/user_photo.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:imagine_app_linkedin/widgets/post_page_widgets.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _postContent = TextEditingController();
  Post post = new Post();
  int _radioValue = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _mainModal(context);
      final authService = Provider.of<AuthService>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      postProvider.de = authService.usuario.uid;
      postProvider.username = authService.usuario.nombre;
      postProvider.userPhoto = authService.usuario.photo;
      postProvider.privacy = 'Anyone';
    });
  }

  _mainModal(BuildContext context) {
    return showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 30,
                color: Colors.grey,
              ),
              Text("main Modal"),
              Text("main Modal"),
              Text("main Modal"),
              Text("main Modal"),
              Text("main Modal"),
              Text("main Modal"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
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
        actions: [
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Post',
                  style: TextStyle(
                      color: postProvider.content.trim().length > 0
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: postProvider.content.trim().length > 0
                  ? () async {
                      await postProvider.sendPost();
                      Navigator.pushReplacementNamed(context, 'home');
                    }
                  : null,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _userTopInfo(context),
                  _createTextSpace(context),
                ],
              ),
            ),
          ),
          _createBottomBar(context),
        ],
      ),
    );
  }

  _userTopInfo(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 14),
      child: Row(
        children: <Widget>[
          CircularUserPhoto(photo: authService.usuario.photo),
          SizedBox(width: 5),
          NameButton(userName: authService.usuario.nombre),
          SizedBox(width: 5),
          _createPrivacyButton(context),
        ],
      ),
    );
  }

  _createTextSpace(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    return Container(
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
          postProvider.content = _postContent.text;
          setState(() {});
        },
      ),
    );
  }

  _createBottomBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: kToolbarHeight,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 7),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PostCreationItem(icon: Icons.camera_alt_rounded, function: () {}),
            PostCreationItem(icon: Icons.video_call_rounded, function: () {}),
            PostCreationItem(icon: Icons.image_outlined, function: () {}),
            PostCreationItem(icon: Icons.more_horiz, function: () {}),
            Expanded(child: SizedBox(width: 1)),
            BottomPrivacyButton(function: () => choosePrivacySettings(context)),
          ],
        ),
      ),
    );
  }

  _createPrivacyButton(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.public, size: 16),
            SizedBox(width: 1),
            Text((postProvider.privacy != null)
                ? postProvider.privacy
                : "Anyone"),
            SizedBox(width: 1),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      onTap: () => choosePrivacySettings(context),
    );
  }

  choosePrivacySettings(BuildContext context) {
    final modalTitle = "Who can see this post?";
    final modalTitleStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    final modalSubtitle =
        "Your post will be visible on feed, on your profile and in search results";
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
            privacyTile(
              context,
              Icons.public,
              'Anyone',
              'Anyone on or off LinkedIn',
              0,
            ),
            privacyTile(
              context,
              Icons.people,
              'Connections only',
              'Connection on LinkedIn',
              1,
            ),
            privacyTile(
              context,
              Icons.group_work_rounded,
              'Group members',
              'Select a group you are in',
              2,
            ),
          ],
        );
      },
    );
  }

  privacyTile(BuildContext context, IconData icon, String title,
      String subtitle, int index) {
    final postProvider = Provider.of<PostProvider>(context);
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Radio(
        value: index,
        groupValue: _radioValue,
        onChanged: (int value) {
          _radioValue = index;
          this.post.privacy = title;
          postProvider.privacy = title;
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }
}
