import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_demo/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('UserName'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  context.read<AuthenticationCubit>().createUser(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar:
                            'https://t4.ftcdn.net/jpg/02/29/75/83/360_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg',
                      );
                  nameController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Create User'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
