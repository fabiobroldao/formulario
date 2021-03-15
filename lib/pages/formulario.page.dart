import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Formulário de Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildInput(
                      label: 'Nome Completo',
                      textinput: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildInput(
                      label: 'Email',
                      textinput: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildInput(
                      label: 'CPF',
                      textinput: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 210,
                          child: buildInput(
                            label: 'CEP',
                            textinput: TextInputType.text,
                          ),
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.search),
                          label: Text('Buscar CEP'),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 210,
                          child: buildInput(
                            label: 'Rua',
                            textinput: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 124,
                            child: buildInput(
                              label: 'Número',
                              textinput: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 167,
                          child: buildInput(
                            label: 'Bairro',
                            textinput: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 167,
                            child: buildInput(
                              label: 'Cidade',
                              textinput: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 167,
                          child: buildInput(
                            label: 'UF',
                            textinput: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 167,
                            child: buildInput(
                              label: 'Pais',
                              textinput: TextInputType.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cadastrar',
                      ),
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(width: 1, color: Colors.red)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 16)))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput({
    required String label,
    TextEditingController? controller,
    bool obscureText = false,
    required TextInputType textinput,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        counterStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      cursorWidth: 4,
      cursorRadius: Radius.circular(10),
      keyboardType: textinput,
    );
  }
}
