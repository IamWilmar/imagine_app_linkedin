import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/providers/post_provider.dart';
import 'package:imagine_app_linkedin/providers/radio_button_provider.dart';


/*
  Widget mostrado en el modal bottomsheet de privacidad
  para elegir un modo de privacidad
 */
class PrivacyTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  const PrivacyTile({
    this.icon,
    this.title,
    this.subtitle,
    this.index,
  });
  @override
  Widget build(BuildContext context) {
    //Acceso al provider de radiobutton y post
    final postProvider = Provider.of<PostProvider>(context);
    final radioProvider = Provider.of<RadioProvider>(context);
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Radio(
        value: index,
        groupValue: radioProvider.radioValue,
        onChanged: (int value) {
          //Asigna el titulo del tile a el parametro privacy en el
          //Provider de post y asgina el indice al valor del radio
          radioProvider.radioValue = index;
          postProvider.privacy = title;
          Navigator.pop(context);
        },
      ),
    );
  }
}