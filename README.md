# YesNoApp_210659

# DMI-10A-HelloWorld-Flutter-210659

# HelloWorld App, mi primera aplicacion en Flutter
Primera Aplicacion realizada en Flutter para dispositivos moviles, 
parte de la unidad 2 de la asignatura en Desarrollo Movil Integral

## HISTORIAL DE PRACTICAS
| **No.** | **Nombre**                                 | **Potenciador** | **Estatus**  | **Fecha Revisión** |
|---------|--------------------------------------------|-----------------|--------------|---------------------|
| 20      | Instalación y Configuración de Flutter     | 10              | Finalizada   | 25-10-2024          |
| 21      | Hello World App                            | Pendiente       | Activa       |                     |

---

## **Lista de Herramientas**

![DART](https://img.shields.io/badge/Dart-0175C2?style-for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)

---

## **Documentación**
---
<div style="display: flex; justify-content: space-between;">
    <img align="left" src="img/LOGO TIC (4).png?raw=true" alt="Logo 1" width="300"; />
    <img align="right" src="img/LOGO UTXJ PNG.png?raw=true" alt="Logo 2" width="300";/>
</div><br><br><br><br><br>

<div style="text-align: center;">
    <p><strong>UNIVERSIDAD TECNOLÓGICA DE XICOTEPEC DE JUÁREZ</strong></p>
    <p><strong>Materia:</strong> Desarrollo Móvil Integral</p>
    <p><strong>Alumno:</strong> Justin Martin Muñoz Escorcia</p>
    <p><strong>Matricula:</strong> 210659</p>
    <p><strong>10 A - IDGS</strong></p>
</div>

**Tarea 6:** Implementación de colores y tipografías para la aplicación de contador  
**Objetivo:** Desarrollar una aplicación que permite incrementar, decrementar y resetear un contador visualmente en la interfaz del usuario.

### Puntos clave:

- Implementacion del Scaffold Principal **ChatScreen**
- Uso de Temas de Colores
- Implementación y Estilización de las burbujas de los mensajes del emisor, usando el Widget **MyMessageBubble** del tipo: **Container.BoxDecoration**: Si
- Implementación y Estilización de las burbujas de los mensajes del receptor, usando el Widget **HerMessageBubble** del tipo: **Container.BoxDecoration**
- Uso del componente que permitira el envio de Stickers animados por parte del receptor denominado **_ImageBubble**:
- Implementación del componente que permitirá la escritura de mensaje por parte del emisor usando el componente **MessageFieldBox.TextFormField**
- Implementación de la respuesta de Stickers animados usando la API **toMessageEntity.imageUrl**

### **Codigo Fuente:**
**Main.dart**
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yes_no_app/config/theme/app_theme.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/screens/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider() )
      ],
      child: MaterialApp(
        title: 'Yes No App 210659',
        debugShowCheckedModeBanner: false,
        theme: AppTheme( selectedColor: 0 ).theme(),
        home: const ChatScreen()
      ),
    );
  }
}

### **Her_message_bubble:**

import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class HerMessageBubble extends StatelessWidget {
  final Message message;

  const HerMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              message.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 5),
        _ImageBubble( message.imageUrl! ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble( this.imageUrl );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text('Justin está enviando una imagen'),
            );
          },
        ));
  }
}

