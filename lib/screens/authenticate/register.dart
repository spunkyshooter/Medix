import 'package:flutter/material.dart';
import 'package:medix/models/DateTimeUtils.dart';
import 'package:medix/services/Database.dart';
import 'package:medix/services/auth.dart';
import 'package:medix/utils/validator.dart';
import 'package:medix/widgets/BtnWithSnackBar.dart';
import 'package:medix/widgets/DropDown.dart';
import 'package:medix/widgets/MedixTextFormField.dart';
import 'package:medix/widgets/TopBar.dart';

const List<String> bloodGroupList = [
  "A+",
  "A-",
  "B+",
  "B-",
  "AB-",
  "AB+",
  "O+",
  "O-"
];

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _dobcontroller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> state = {
    "email": null,
    "password": null,
    "phone": null,
    "dob": null,
    "gender": 'Male',
    "bloodGroup": "A+"
  };
  final Map<String, dynamic> utilsState = {
    "loading": false,
    "hitvalidate": false,
  };

  onChange(id, text) {
    setState(() {
      state[id] = text;
    });
  }

  void _selectDateHandler(BuildContext context) async {
    // Below line stops keyboard from appearing
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    setState(() {
      state["dob"] = date; //DateTime
    });

    //formatting for viewing
    _dobcontroller.value = _dobcontroller.value.copyWith(
      text: date != null
          ? DateTimeUtils.getFormattedDate(date, fullYr: true)
          : null,
    );
  }

  createUser(context) async {
    setState(() {
      utilsState["loading"] = true;
    });
    try {
      //create the user.
      Map<String, dynamic> response = await new AuthService()
          .createUserWithEmailAndPassword(state["email"], state["password"]);

      if (response["success"]) {
        print({"success user": response["user"].uid});
        DatabaseService db = new DatabaseService(uid: response["user"].uid);
        //Create the patient record
        await db.createPatient(
          name: state["name"],
          address: state["city"],
          bloodGroup: state["bloodGroup"],
          dob: state["dob"],
          email: state["email"],
          gender: state["gender"],
          phone: state["phone"],
        );
        //just to mimick
        await db.addLiveData();

        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
              duration: Duration(milliseconds: 750),
              content: Text(
                response["error"],
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.redAccent),
        );
      }
    } catch (err) {
      print(err);
    }
    setState(() {
      utilsState["loading"] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
//    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            pinned: false,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: null,
              //you can give the customize wigets in background property.
              //https://stackoverflow.com/questions/53962444/how-can-i-customise-the-flexiblespace-property-in-sliverappbar-in-flutter
              background: TopBar(
                titleStyle: TextStyle(
                  letterSpacing: 4.0,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 5,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      MedixTextFormField(
                          id: 'name',
                          onChange: onChange,
                          labelText: "Full Name",
                          textCapitalization: TextCapitalization.sentences,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blueAccent,
                          ),
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter full name';
                            }
                            return null;
                          }),
                      MedixTextFormField(
                          id: 'email',
                          onChange: onChange,
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blueAccent,
                          ),
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email can't be empty";
                            } else if (!Validator.isEmail(value)) {
                              return "Invalid Email";
                            }
                            return null;
                          }),
                      MedixTextFormField(
                          id: 'phone',
                          onChange: onChange,
                          labelText: "Phone",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blueAccent,
                          ),
                          keyboardType: TextInputType.number,
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          }),
                      MedixTextFormField(
                          controller: _dobcontroller,
                          //used here to set the date, we need to set value because of validation
                          enableInteractiveSelection: false,
                          //avoids selection and interaction
                          labelText: "D.O.B",
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            _selectDateHandler(context);
                          },
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please select D.O.B';
                            }
                            return null;
                          }),
                      MedixTextFormField(
                          id: 'city',
                          onChange: onChange,
                          labelText: "City",
                          textCapitalization: TextCapitalization.sentences,
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.blueAccent,
                          ),
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter yout city';
                            }
                            return null;
                          }),
                      DropDown(
                        title: "Gender",
                        id: "gender",
                        onChanged: onChange,
                        items: const ["Male", "Female", "Trans"],
                        value: state["gender"],
                      ),
                      DropDown(
                        title: "Blood Group",
                        id: "bloodGroup",
                        onChanged: onChange,
                        items: bloodGroupList,
                        value: state["bloodGroup"],
                      ),
                      new MedixTextFormField(
                          id: 'password',
                          onChange: onChange,
                          obscureText: true,
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.blueAccent,
                          ),
                          autovalidate: utilsState["hitvalidate"],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password can\'t be empty';
                            } else if (value.toString().length < 6) {
                              return 'Password must be atleast 6 characters';
                            }
                            return null;
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          BtnWithSnackBar(
                            onPressed: (BuildContext context) {
                              setState(() {
                                utilsState["hitvalidate"] = true;
                              });
                              if (_formKey.currentState.validate()) {
                                // Process data.
                                createUser(context);
                              }
                            },
                            loading: utilsState["loading"],
                            child: Text(
                              "Register",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
