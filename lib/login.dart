import 'package:lab_assignment/dailyexpenses.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController serverIpController = TextEditingController();

  String ipAddress = ' ';

  @override
  void initState(){
    //TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),


      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200, width:200,
                  child: Image.asset('assets/dailyexpenses.png')
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: serverIpController,
                  decoration: InputDecoration(
                    labelText: "IP address",
                  ),),
              ),



              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,  //Hide the password
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),


              ElevatedButton(
                onPressed: () async {
                  // Implement login logic here
                  String username = usernameController.text;
                  String password = passwordController.text;
                  if (username == 'test' && password == '123456789'){
                    //Navigate to the daily expense screen
                    final prefs = await SharedPreferences.getInstance();
                    if (serverIpController.text.isEmpty)
                    {
                      String ip = ipAddress;
                      await prefs.setString("ip", ip);
                    }
                    else{
                      String ip = serverIpController.text;
                      await prefs.setString("ip", ip);
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyExpensesApp(username:username),
                      ),
                    );
                  }else{
                    //show an error message or handle invalid login
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Login Failed'),
                          content: const Text('Invalid username or password.'),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text ('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}