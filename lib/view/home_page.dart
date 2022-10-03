import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections Dapp Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/governance-image.png',
                width: 200,
                height: 200,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'Welcome to the elections!',
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                    filled: true, hintText: 'Enter election name'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        print('Election Started!');
                      }
                    },
                    child: const Text('Start Election'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
