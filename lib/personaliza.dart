import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:improve/main.dart';

class Personaliza extends StatefulWidget {
  @override
  _PersonalizaState createState() => _PersonalizaState();
}
// primaryColor: Theme.of(context).primaryColor == Colors.purple ? Colors.red : Colors.purple,
class _PersonalizaState extends State<Personaliza> {
  Color selectedColor;
  Color accentColor;
  bool isTextBlack;

  @override
  void didChangeDependencies() {
    selectedColor = Theme.of(context).primaryColor;
    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              FlatButton(
                child: Text('Confirmar'),
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
                },
              )
            ],
          ),
        ),
      )
    );
  }
}

