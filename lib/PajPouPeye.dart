import 'package:flutter/material.dart';

class PajPouPeye extends StatelessWidget{

  ButtonStyle _styleBtn(color,context){
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width-15, 50),
        elevation: 5,
        shadowColor: color,
        shape : ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
    );
    return buttonStyle;
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const double sizeBoxHeight = 50;
    double imageHeight = 100;
    double imageWidth = MediaQuery.of(context).size.width-100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Pay",style: style,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: _styleBtn(Colors.red, context),
              onPressed: (){},
              child: Image.network(
                "data:image/jpeg;base64,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",
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            SizedBox(height: sizeBoxHeight,),
            ElevatedButton(
              style: _styleBtn(Colors.blue, context),
              onPressed: (){},
              child: Image.network(
                "data:image/png;base64,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",
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            SizedBox(height: sizeBoxHeight,),
            ElevatedButton(
              style: _styleBtn(Colors.yellow, context),
              onPressed: (){},
              child: Image.network(
                "data:image/png;base64,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",
                width: imageWidth,
                height: imageHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

}