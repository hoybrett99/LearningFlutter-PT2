import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _sloganController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation){
    setState(() {
      selectedVocation = vocation;
    });
  }


  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {

      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          title: const StyledHeading('Missing Character Name'),
          content: const StyledText('Every good RPG character needs a great name...'),
          actions: [
            StyledButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const StyledHeading('close'))
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });

      return;
    }
    if (_sloganController.text.trim().isEmpty) {

      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          title: const StyledHeading('Missing Slogan'),
          content: const StyledText('Remember to add a catchy slogan...'),
          actions: [
            StyledButton(
              onPressed: (){
                Navigator.pop(ctx);
              }, 
              child: const StyledHeading('close'))
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      });

      return;
    }
    characters.add(Character(
      name: _nameController.text.trim(), 
      slogan: _sloganController.text.trim(),
      vocation: selectedVocation, 
      id: uuid.v4(),
      ));

    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) => const Home(),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              // welcome message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Welcome, new player.'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character.'),
              ),
              const SizedBox(height: 30,),
          
              // input for name and slogan
              TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.headlineMedium
                  ),
                  cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character Name')
                ),
              ),
              const  SizedBox(height: 20,),
              TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                  textStyle: Theme.of(context).textTheme.headlineMedium
                  ),
                  cursorColor: AppColors.textColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character Slogan')
                )
              ),
              const SizedBox(height: 30,),
          
              // select vocation title
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor,),
              ),
              const Center(
                child: StyledHeading('Choose a vocation.'),
              ),
              const Center(
                child: StyledText('This determines your available skills.'),
              ),
              const SizedBox(height: 30,),
          
              // vocation cards
              VocationCard(
                selected: selectedVocation == Vocation.junkie,
                onTap: updateVocation,
                vocation: Vocation.junkie
                ),
                VocationCard(
                  selected: selectedVocation == Vocation.ninja,
                  onTap: updateVocation,
                vocation: Vocation.ninja
                ),
                VocationCard(
                  selected: selectedVocation == Vocation.raider,
                  onTap: updateVocation,
                vocation: Vocation.raider
                ),
                VocationCard(
                  selected: selectedVocation == Vocation.wizard,
                  onTap: updateVocation,
                vocation: Vocation.wizard
                ),

                // Good luck message
                Center(
                  child: Icon(Icons.code, color: AppColors.primaryColor,),
                ),
                const Center(
                  child: StyledHeading('Good Luck.'),
                ),
                const Center(
                  child: StyledText('And enjoy the journey...'),
                ),
                const SizedBox(height: 30,),
          
              Center(
                child: StyledButton(
                  onPressed: handleSubmit, 
                  child: StyledHeading('Create Character')),
              )
            ],
          ),
        ),
      ),
    );
  }
}