import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getUserData();
        },
        child: const Icon(Icons.bubble_chart),
      ),
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: Center(
        child: Text(
          'HomeView is working ${controller.name.value}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
