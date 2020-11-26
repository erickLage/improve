import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:improve/main.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_check_box/circular_check_box.dart';

class Personaliza extends StatefulWidget {
  final int audio;
  Personaliza(this.audio);
  _PersonalizaState createState() => _PersonalizaState();
}
// primaryColor: Theme.of(context).primaryColor == Colors.purple ? Colors.red : Colors.purple,
class _PersonalizaState extends State<Personaliza> {
  Color selectedColor;
  Color accentColor;
  bool isTextBlack;
  int audioSelecionado;

  @override
  void didChangeDependencies() {
    selectedColor = Theme.of(context).primaryColor;
    accentColor = Theme.of(context).accentColor;
    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
    audioSelecionado = widget.audio;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: FlatButton(
          padding: EdgeInsets.all(0),
          child: Container(
            width: 74,
            child: Icon(Icons.chevron_left, size: 30, color: isTextBlack ? Colors.black : Colors.white,),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                child: Center(child: Text('A', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle
                ),
              ),
              SlidePicker(
                paletteType: PaletteType.rgb,
                showIndicator: false,
                showLabel: false,
                showSliderText: false,
                enableAlpha: false,
                pickerColor: selectedColor,
                onColorChanged: (newColor){
                  setState(() {
                    selectedColor = newColor;
                    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
                    accentColor = isTextBlack 
                      ? Color.fromRGBO(
                        selectedColor.red - ((selectedColor.red)/3).round(), 
                        selectedColor.green - ((selectedColor.green)/3).round(), 
                        selectedColor.blue - ((selectedColor.blue)/3).round(),  
                        1
                      )
                      : Color.fromRGBO(
                        selectedColor.red + ((255 - selectedColor.red)/3).round(), 
                        selectedColor.green + ((255 - selectedColor.green)/3).round(), 
                        selectedColor.blue + ((255 - selectedColor.blue)/3).round(),  
                        1
                      );
                  });
                },
              ),
              Container(
                height: 25,
                width: 40,
                color: selectedColor,
              ),
              Container(
                height: 15,
                width: 40,
                color: accentColor,
              ),
              SizedBox(height: 20),
              Text('Personalize os sons de acerto:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    child: Row(
                      children: [
                        CircularCheckBox(
                          value: audioSelecionado == 0,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          onChanged: (bool x) {
                            setState((){
                              audioSelecionado = 0;
                            });
                          }
                        ),
                        Text('Sem\nsom', style: TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Row(
                      children: [
                        CircularCheckBox(
                          value: audioSelecionado == 1,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          onChanged: (bool x) {
                            setState((){
                              audioSelecionado = 1;
                            });
                          }
                        ),
                        GestureDetector(
                          onTap: () async{
                            AssetsAudioPlayer.playAndForget(Audio('src/assets/audios/a1.mp3'));
                          },
                          child: Icon(Icons.play_arrow, size: 38)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Row(
                      children: [
                        CircularCheckBox(
                          value: audioSelecionado == 2,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          onChanged: (bool x) {
                            setState((){
                              audioSelecionado = 2;
                            });
                          }
                        ),
                        GestureDetector(
                          onTap: () async{
                            AssetsAudioPlayer.playAndForget(Audio('src/assets/audios/a2.mp3'));
                          },
                          child: Icon(Icons.play_arrow, size: 38)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              FlatButton(
                color: selectedColor,
                child: Text('CONFIRMAR', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isTextBlack ? Colors.black : Colors.white),),
                onPressed: (){
                  DynamicTheme.of(context).setThemeData(
                    ThemeData(
                      primaryColor: selectedColor,
                      indicatorColor: accentColor,
                      accentColor: accentColor,
                      textTheme: isTextBlack ? Typography.blackRedmond : Typography.whiteRedmond
                    )
                  );
                  prefs.setInt('improveColorRed', selectedColor.red);
                  prefs.setInt('improveColorGreen', selectedColor.green);
                  prefs.setInt('improveColorBlue', selectedColor.blue);
                  prefs.setBool('textBlack', isTextBlack);
                  prefs.setInt('improveSound', audioSelecionado);
                },
              ),   
            ],
          ),
        ),
      )
    );
  }
}

