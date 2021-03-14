import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imagine_app_linkedin/providers/login_provider.dart';
import 'package:imagine_app_linkedin/services/auth_service.dart';
import 'package:imagine_app_linkedin/widgets/blue_button.dart';
import 'package:imagine_app_linkedin/widgets/custom_input.dart';


class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UpperBar(),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text('Log In', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600)),
                ),
                _Form(),
                SizedBox(height: 5),
                Center(
                  child: Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpperBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/linkedLogo.png',height: 30,),
          TextButton(
            child: Text('Sign in'),
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.email_outlined,
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
            hint: 'Email',
          ),
          CustomInput(
            icon: Icons.text_format,
            textController: passController,
            keyboardType: TextInputType.text,
            isPassword: true,
            hint: 'Password',
          ),
          BlueButton(
            text: authService.autenticando ? 'Waiting...' :'Log In',
            onPressed: (loginProvider.username.trim().length < 1 || loginProvider.password.trim().length < 1) ? null : () async {
              FocusScope.of(context).unfocus();
              final isloginOk = await authService.login(emailController.text.trim(), passController.text.trim());
              if(isloginOk){
                Navigator.pushReplacementNamed(context, 'home');
                loginProvider.resetValues();
              }else{
                //Mostrar alerta
                //mostrarAlerta(context, 'Login Incorrecto', 'Credenciales no validas');
              }
            },
          ),
        ],
      ),
    );
  }
}