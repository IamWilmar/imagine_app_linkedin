import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _mainModal(context);
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
            Navigator.pop(context);
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
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {},
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 14),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(),
                        SizedBox(width: 5),
                        NameButton(
                          userName: 'Wilmar Bustos',
                        ),
                        SizedBox(width: 5),
                        PrivacyButton(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 5),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'What do you want to talk about?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
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
                  IconButton(
                    icon:
                        Icon(Icons.camera_alt_rounded, color: Colors.grey[500]),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.video_call_rounded, color: Colors.grey[500]),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.image_outlined, color: Colors.grey[500]),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.grey[500]),
                    onPressed: () {},
                  ),
                  Expanded(child: SizedBox(width: 1)),
                  InkWell(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.message_outlined, size: 16, color: Colors.grey),
                          Text('Anyone', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    onTap: () {
                      PrivacyButton _button = new PrivacyButton();
                      _button.choosePrivacySettings(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NameButton extends StatelessWidget {
  final String userName;
  const NameButton({Key key, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.person, size: 16),
          SizedBox(width: 1),
          Text(this.userName),
          SizedBox(width: 1),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

class PrivacyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Text('Anyone'),
            SizedBox(width: 1),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      onTap: () => choosePrivacySettings(context),
    );
  }

  choosePrivacySettings(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Text("Opcion"),
            Text("Opcion"),
            Text("Opcion"),
            Text("Opcion"),
            Text("Opcion"),
            Text("Opcion"),
          ],
        );
      },
    );
  }
}
