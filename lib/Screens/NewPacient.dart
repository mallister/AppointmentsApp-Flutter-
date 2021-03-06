import 'package:appointment/Screens/AllPacients.dart';
import 'package:appointment/db/Controller.dart';
import 'package:appointment/models/entities/Pacient.dart';
import 'package:appointment/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:appointment/main.dart';

class NewPacient extends StatefulWidget {
  NewPacient({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => NewPacientState();

}

class NewPacientState extends State<NewPacient> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController extraController = new TextEditingController();

  var phoneNumberMask = new MaskTextInputFormatter(mask: '## #####-####', filter: {"#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new patients"),),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Patient Name",
                      hintText: "Patient Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Patient email",
                      hintText: "Patient email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: extraController,
                  decoration: InputDecoration(
                      labelText: "Patient description",
                      hintText: "Patient description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Form(
                child: TextFormField(
                  controller: phoneNumberController,
                  inputFormatters: [phoneNumberMask],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Patient phone number",
                      hintText: "Patient phone number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: FloatingActionButton(child: Icon(Icons.add), heroTag: null,
                  onPressed: () async {
                    if (nameController.text == "" || nameController.text == "Patient Name") {
                      Utils().showMyDialog("Empty Fields", "Name field can't be empty", context);
                    } else if(phoneNumberController.text == "" || phoneNumberController.text == "Phone Number") {
                      Utils().showMyDialog("Empty Fields", "Phone field can't be empty", context);
                    } else {
                      Pacient newP = Pacient(name: nameController.text, email: emailController.text, phoneNumber: phoneNumberController.text, extra: extraController.text);
                      await DBController().insertPatient(newP);
                      newP = new Pacient();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllPacients()));

                    }
                  })
            ),
          ],
        )
      ),
    );
  }
}