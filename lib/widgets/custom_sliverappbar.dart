import 'package:flutter/material.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/widgets/user_photo.dart';
import 'package:provider/provider.dart';

class CustomSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SliverAppBar(
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
        padding: const EdgeInsets.all(8.0),
        child: CircularUserPhoto(photo: authService.usuario.photo),
      ),
    );
  }
}