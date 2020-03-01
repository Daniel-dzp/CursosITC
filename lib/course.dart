import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_slidable/flutter_slidable.dart';

class Cursos extends StatefulWidget{
    @override
    State<StatefulWidget> createState(){
        return CursosForm();
    }
}

class CursosForm extends State<Cursos>{
    var isLoading = false;
    List dataCursos=null;

    final txtName = TextEditingController();
    final txtDesc = TextEditingController();

    final ip = "192.168.1.67:8888";

    Future<String> getData() async{
        this.setState((){
            isLoading = true;
            print("#######################Comenzo service######################");
        });

        var response = await http.get(
            Uri.encodeFull("http://$ip/course"),
            headers: { "Accept" : "application/json"}
        );

        // Metodo para renderizar el listado con los elementos
        this.setState((){
            dataCursos = json.decode(response.body);
            print(dataCursos);
            isLoading = false;
        });
        return "success";
    }

    @protected
    @mustCallSuper
    void initState() {
        getData();
    }

    Future <int> insCurso() async{
        this.setState((){
            isLoading = true;
        });

        var name = txtName.text;
        var desc = txtDesc.text;

        Map<String, String> headers  = {"Content-type":"application/json"};
        String cadJson = '{"name":"$name", "description":"$desc","idteacher":{"id":1}}';

        var response = await http.post(
            Uri.encodeFull("http://$ip/course"),
            headers: headers,
            body: cadJson
        );

        var response2 = await http.get(
            Uri.encodeFull("http://$ip/course"),
            headers: {"Accept":"application/json"}
        );

        this.setState((){
            isLoading = true;
        });

        getData();

        return 1;

    }

    @override
    Widget build(BuildContext context){
        //getData();
        return MaterialApp(
            title: "Lista",
            home: Scaffold(
                appBar: AppBar(
                    title: Text("Cursos"),
                    backgroundColor: Colors.greenAccent,
                ),
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.redAccent,
                    onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                                return AlertDialog(
                                    title: Text("Nuevo curso"),
                                    content: Form(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                                TextField(
                                                    controller: txtName,
                                                    decoration: InputDecoration(hintText: 'Nombre del curso'),
                                                ),
                                                TextField(
                                                    controller: txtDesc,
                                                    decoration: InputDecoration(hintText: 'Descripcion del curso'),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(left: 20, right: 20),
                                                    child: RaisedButton(
                                                        child: Text("Guardar curso"),
                                                        onPressed: (){
                                                            //Mas acciones
                                                            var code = insCurso();

                                                            Navigator.pop(context);
                                                        },
                                                    ),
                                                )
                                            ],
                                        )
                                    ),
                                );
                            }
                        );

                    },
                ),
                body: isLoading ?
                Center(
                    child: CircularProgressIndicator(),
                ):
                ListView.builder(
                    itemCount: dataCursos == null ? 0 : dataCursos.length,
                    itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Card(
                                elevation: 8.0,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            121, 181, 237, .9)),
                                    child: ListTile(
                                        contentPadding: EdgeInsets
                                            .symmetric(horizontal: 20.0,
                                            vertical: 10.0),
                                        leading: Container(
                                            padding: EdgeInsets.only(
                                                right: 12.0),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 1.0,
                                                        color: Colors
                                                            .black))
                                            ),
                                            child: Icon(Icons.language,
                                                color: Colors.black)
                                        ),

                                        title: Text(
                                            dataCursos[index]['name'],
                                            style: TextStyle(color: Colors
                                                .black,
                                                fontWeight: FontWeight
                                                    .bold),
                                        ),

                                        subtitle: Row(
                                            children: <Widget>[
                                                //Icon(Icons.touch_app, color: Colors.yellowAccent),
                                                Text(
                                                    dataCursos[index]['description'],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .black))
                                            ],
                                        ),

                                        trailing: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.black,
                                            size: 30.0,),
                                    ),
                                ),
                            ),
                            secondaryActions: <Widget>[
                                IconSlideAction(
                                    caption: 'Edit',
                                    color: Colors.lightGreenAccent,
                                    icon: Icons.edit,
                                    //onTap: () => _showSnackBar('More'),
                                ),
                                IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    //onTap: () => _showSnackBar('Delete'),
                                ),
                            ],
                        );
                    }
                ),
            ),
        );
    }
}