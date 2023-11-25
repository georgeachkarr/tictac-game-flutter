import 'package:flutter/material.dart';
import 'package:tictac/game.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController player1Controle =TextEditingController();
  final TextEditingController player2Controle =TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            const Text("ENTER YOUR NAME" ,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
             const SizedBox(height: 20),
            Padding(padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: player1Controle,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:BorderSide(
                    color: Colors.white),

                ),
focusedErrorBorder: OutlineInputBorder (
    borderSide: BorderSide( color: Colors.cyanAccent),
              ),
    enabledBorder: OutlineInputBorder (
    borderSide: BorderSide( color: Colors.white),
            ),
   errorBorder: OutlineInputBorder (
    borderSide: BorderSide( color: Colors.red),
            ),
hintText: "palyer 1 name",
    hintStyle: TextStyle(color: Colors.white),

            ),
validator: (value){
                if(value ==null ||value.isEmpty){
                  return "Please enter palyer name";
                }
                return null;
},

            ),
            ),
            Padding(padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: player2Controle,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(
                        color: Colors.white),

                  ),
                  focusedErrorBorder: OutlineInputBorder (
                    borderSide: BorderSide( color: Colors.cyanAccent),
                  ),
                  enabledBorder: OutlineInputBorder (
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder (
                    borderSide: BorderSide( color: Colors.red),
                  ),
                  hintText: "palyer 2 name",
                  hintStyle: TextStyle(color: Colors.white),

                ),
                validator: (value){
                  if(value ==null ||value.isEmpty){
                    return "Please enter palyer name";
                  }
                  return null;
                },

              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: (){
                if (_formkey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Game(
                      player1: player1Controle.text,
                      player2: player2Controle.text,
                  ),
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 20),
                child: const Text("Let's Play",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),
                ),

              ),

            )
        ],
        ),
      ),
    );

  }
}
