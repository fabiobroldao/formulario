import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final pessoas = [
    {
      'nome': 'Edson',
      'email': 'edson@gmail.com',
      'cpf': '000.000.000-00',
      'cep': '00000-000',
      'rua': 'Rua A',
      'numero': '1000',
      'Bairro': 'Tijuca',
      'Cidade': 'Rio de Janeiro',
      'uf': 'RJ',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/1.png',
    },
    {
      'nome': 'Gabriel',
      'email': 'gabriel@gmail.com',
      'cpf': '999.000.000-00',
      'cep': '9999-000',
      'rua': 'Rua HH',
      'numero': '10',
      'Bairro': 'Chui',
      'Cidade': 'Jaguarao',
      'uf': 'RS',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/2.png',
    },
    {
      'nome': 'Fabio',
      'email': 'fabio@gmail.com',
      'cpf': '001.001.001-00',
      'cep': '00100-010',
      'rua': 'Rua WW',
      'numero': '99',
      'Bairro': 'ABCD',
      'Cidade': 'EFGHIJKL',
      'uf': 'BZ',
      'pais': 'Brasil',
      'bgimg': 'https://robohash.org/3.png',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/formulario');
                  },
                  child: Text('Inserir'),
                ),
              ],
            ),*/
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: buildList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.separated(
      itemCount: pessoas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(pessoas[index]['nome'].toString()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pessoas[index]['email'].toString()),
              Text(pessoas[index]['cpf'].toString()),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(pessoas[index]['bgimg'].toString()),
          ),
          onTap: () {
            Navigator.of(context).pushNamed('/formulario');
          },
          selected: false,
          enabled: true,
          isThreeLine: false,
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}