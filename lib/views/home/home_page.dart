import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled7/notes.dart';

import '../../services/db_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controllername = TextEditingController();
  TextEditingController controllerid = TextEditingController();
  DB_Handler? db_handler ;
  late Future<List<NotesModal>> noteslist ;
  var a ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db_handler = DB_Handler();
    loadDate();
  }
  loadDate()async{
    noteslist = db_handler!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Home page"),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(

          children: [
            TextFormField(
              controller: controllername,
              decoration: InputDecoration(
              hintText: "Name"
            ),),
            SizedBox(height: 20,),
            TextFormField(
              controller: controllerid,
              decoration: const InputDecoration(
                  hintText: "Amount"
              ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){
                  if(controllerid.text.isEmpty || controllername.text.isEmpty){
                    print("Please fill all fields");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all Fields'),
                        duration: Duration(milliseconds: 400),
                      ),
                    );

                  }else{
                    db_handler?.insert(NotesModal(

                        title: controllername.text.toString(),

                        email: controllerid.text.toString()
                    )


                    ).then((value){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Add Successfully'),
                            duration: Duration(milliseconds: 400),
                          ));
                      setState(() {
                        controllerid.text = "";
                        controllername.text = "";

                        noteslist = db_handler!.getNotesList();
                      });
                      print(value.toString());
                      print("Add");


                    }).onError((error, stackTrace){
                      print(error.toString());
                    });

                  }




                }, child: Text("Add")),

                ElevatedButton(onPressed: (){

                  if(a!=null){
                    db_handler!.update(
                        NotesModal(
                          id: a,
                          title: controllername.text,
                          email:controllerid.text ,

                        )
                    )..then((value){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Update Successfully'),
                            duration: Duration(milliseconds: 400),
                          ));

                    });
                    setState(() {
                      controllerid.text = "";
                      controllername.text = "";

                      noteslist = db_handler!.getNotesList();
                    });




                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Update Not Possible'),
                          duration: Duration(milliseconds: 400),
                        ));


                  }










                }, child: Text("Udate")),

              ],
            ),





            Expanded(
              child: Container(
                child: FutureBuilder(
                  future:  noteslist,
                    builder: (context, AsyncSnapshot<List<NotesModal>> snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            return InkWell(
                              onLongPress: (){
                                a = snapshot.data![index].id!;






                                controllername.text  = snapshot.data![index].title!;
                                controllerid.text = snapshot.data![index].email!;

                                // db_handler!.update(
                                //     NotesModal(
                                //       id: snapshot.data![index].id!,
                                //       title: snapshot.data![index].title!,
                                //       email:snapshot.data![index].email! ,
                                //
                                //     )
                                // ).then((value) {
                                //   print("Update");
                                // });
                                // setState(() {
                                //   noteslist = db_handler!.getNotesList();
                                // }
                                // );

                              },
                              child: Card(
                                child: ListTile(

                                  title: Text(snapshot.data![index].title.toString()),
                                  subtitle: Text(snapshot.data![index].email.toString()),
                                  trailing: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          db_handler!.delete(snapshot.data![index].id!).then((value){
                                            print("delete");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Delete Successfully'),
                                                  duration: Duration(milliseconds: 400),
                                                ));
                                          });
                                          noteslist= db_handler!.getNotesList();
                                          snapshot.data!.remove(snapshot.data![index]);

                                        });

                                      },

                                      child: Icon(Icons.delete,color: Colors.red,)),
                                ),

                              ),
                            );


                          });


                    }else{
                      return Container();
                    }


                }),
              ),
            )

          ],

        ),
      ),
    );
  }
}
