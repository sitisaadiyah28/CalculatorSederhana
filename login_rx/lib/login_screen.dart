import 'package:flutter/material.dart';
import 'package:login_rx/blocs/bloc.dart';
import 'package:login_rx/blocs/provider.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/3,
            child: Image(
                image: AssetImage("images/bunga3a.jpg")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 50.0),
            child: Text('LOGIN ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.pink),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 60),
            child: Text(
              'Email', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child:   emailField(bloc),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Text(
              'Password', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child:   passwordField(bloc),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
            child: submitButton(bloc),
          ),
        ],
      );
  }
}

Widget emailField(Bloc bloc){
  return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot){
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              errorText: snapshot.error,
          ),
        );
      });
}

Widget passwordField(Bloc bloc){
  return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot){
        return TextField(
          obscureText: true,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
              errorText: snapshot.error,
          ),
        );
      });
}

Widget submitButton(Bloc bloc){
  return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot){
        return RaisedButton(
          child: Text('Login', style: TextStyle(fontSize: 18),),
          color: Colors.pink,
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      });
}
