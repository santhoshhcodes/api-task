import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  Future<dynamic> getData() async{
    try{
      var apiResponse = await http.get(
          Uri.parse("https://dummy-json.mock.beeceptor.com/continents"));
      if(apiResponse.statusCode == 200){
        return jsonDecode(apiResponse.body);
      }else{
        throw Exception("Error");
      }
    }catch(error){
      throw Exception(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Task",
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),

      body: FutureBuilder(future: getData()
          , builder: (BuildContext context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }else if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }else if(snapshot.hasData){
              var data = snapshot.data;
              //body = data;
              return
                ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final state = data[index];
                  return Card(
                    color: Colors.grey[400],
                    child: ListTile(
                      title: Text(state['name'],
                        style: TextStyle(fontSize: 20,color: Colors.red[400]),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Table(
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(
                                  children: [
                                    Text("Code"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(": ${state['code'].toString()}"
                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("AreaSqKm"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(": ${state['areaSqKm'].toString()}"
                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Population"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(": ${state['population'].toString()}"
                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Lines"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(": ${state['lines'][0]}"
                                        "\n  ${state['lines'][1]}"

                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children: [
                                    Text("Country"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(": ${state['countries'].toString()}"
                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("Oceans"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(":  ${state['oceans'][0]}"
                                      ,style: TextStyle(fontSize: 15),),
                                  ]
                              ),
                              TableRow(
                                  children:[
                                    Text("DevelopedCountries"
                                      ,style: TextStyle(fontSize: 15),),
                                    Text(
                                      ": ${state['developedCountries'] != null && state['developedCountries'].length > index
                                          ? "${state['developedCountries'][0]}"
                                          "\n  ${state['developedCountries'][1]}"
                                          "\n  ${state['developedCountries'][2]}"
                                          : 'N/A'}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ]
                              ),





                            ], ),

                        ],
                      ),
                    ),
                  );
                },
              );


            }else{
              return Text("error");
            }
          }),
    );
  }
}
