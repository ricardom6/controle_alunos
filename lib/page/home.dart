import 'package:flutter/material.dart';
import 'package:controle_alunos/helper/aluno_helper.dart';
import 'package:controle_alunos/model/aluno.dart';
import 'dart:io';
import 'package:controle_alunos/page/alunoPage.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AlunoHelper helper = AlunoHelper();
  List<Aluno> lsAlunos = List();

  void _showAlunoPage({Aluno aluno}) async {
    final regAluno = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlunoPage(aluno: aluno)),
    );
    if (regAluno != null) {
      if (aluno != null) {
        await helper.update(regAluno);
      } else {
        await helper.insert(regAluno);
      }
      _loadAllAlunos();
    }
  }

  void _loadAllAlunos() {
    helper.selectAll().then((list) {
      setState(() {
        lsAlunos = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAllAlunos();
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Alunos"),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.black,
      onPressed: () {
        _showAlunoPage();
      },
    );
  }

  Widget buildCardAluno(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: lsAlunos[index].pathImg != null
                        ? FileImage(File(lsAlunos[index].pathImg))
                        : AssetImage("images/student.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      lsAlunos[index].nome ?? "-",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsAlunos[index].email ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsAlunos[index].telefone ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsAlunos[index].instituicao ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "Ligar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            launch("tel:${lsAlunos[index].telefone}");
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "email",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            launch("mailto:${lsAlunos[index].email}");
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "SMS",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            launch("sms:${lsAlunos[index].telefone}");
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Editar",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showAlunoPage(aluno: lsAlunos[index]);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            helper.delete(lsAlunos[index].id);
                            setState(() {
                              lsAlunos.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ],
                    ));
              });
        });
  }

  Widget buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: lsAlunos.length,
        itemBuilder: (context, index) {
          return buildCardAluno(context, index);
        });
  }

  Widget buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      floatingActionButton: buildFloatingActionButton(),
      body: buildListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
