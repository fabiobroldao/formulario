import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var isLoading = false;
  var showPass = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  String? email;
  String? pass;

  void doLogin(ctx) {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState?.save();

    Navigator.of(context).pushNamed('/lista');
  }

  void showFailureLogin() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Ops, algo deu errado!'),
          contentPadding: EdgeInsets.all(20),
          children: [
            Text('Usuário ou senha inválidos, Tente novamente'),
          ],
        );
      },
    );
  }

  void showSnackBar(String text, _) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/login_w.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.black38,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildInput(
                    icon: Icons.person,
                    label: 'E-mail',
                    validator: (value) {
                      if (!EmailValidator.validate(value!)) {
                        return 'E-mail inválido';
                      }

                      return null;
                    },
                    onSaved: (value) => email = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildInput(
                    icon: Icons.lock,
                    label: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha inválida';
                      }

                      return null;
                    },
                    onSaved: (value) => pass = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    child: Container(
                      height: 50,
                      width: 300,
                      child: Builder(builder: (ctx) {
                        return ElevatedButton(
                          onPressed: isLoading ? null : () => doLogin(ctx),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            primary: Colors.red,
                          ),
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInput({
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    TextEditingController? controller,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText && !showPass,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        counterStyle: TextStyle(
          color: Colors.white,
        ),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                  showPass ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
              )
            : null,
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      cursorWidth: 4,
      cursorRadius: Radius.circular(10),
      keyboardType: TextInputType.text,
    );
  }
}
