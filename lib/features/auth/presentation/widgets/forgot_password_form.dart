import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        const Image(
          image: AssetImage(
            'assets/uneg_logo_color.png',
          ),
          width: 80,
          height: 80,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        Text(
          'Recuperación de contraseña',
          style: textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Para reajustar su contraseña, envíe su nombre de usuario o su dirección de correo electrónico.',
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          decoration: InputDecoration(
            hintText: 'ej: johndoe',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            label: const Text('Nombre de usuario'),
          ),
        ),
        const SizedBox(
          height: 20,
          child: Text('O'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'ej: johndoe@gmail.com',
                label: const Text('Direccion de correo electrónico'),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Text(
                'Enviar',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Le enviaremos un email con instrucciones para poder acceder de nuevo.',
          style: textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
