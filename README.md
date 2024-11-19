# YesNoApp_210659

# DMI-10A-HelloWorld-Flutter-210659

# HelloWorld App, mi primera aplicacion en Flutter
Primera Aplicacion realizada en Flutter para dispositivos moviles, 
parte de la unidad 2 de la asignatura en Desarrollo Movil Integral

## HISTORIAL DE PRACTICAS
| **No.** | **Nombre**                                                  | **Potenciador** | **Estatus**  | **Fecha Revisión** |
|---------|-------------------------------------------------------------|-----------------|--------------|---------------------|
| 22      | Implementacion de la UI para la Aplicacion de Yes/No        | 10              | Finalizada   | 19-11-2024          |
| 23      | Implementación de la Funcionalidad de la Aplicación Yes/Nop | 10              | Finalizada   | 19-11-2024          |

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



### **ChatScreen:**

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';

import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/55de75ec-40b5-4beb-8cab-d5d8bb9a8538/dfzjmvc-5d05b25f-1bae-4e61-abd1-9e5a7b7c04b2.jpg/v1/fit/w_828,h_1036,q_70,strp/makoto_yuki_from_persona_3_reload_by_monchazo_dfzjmvc-414w-2x.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTYwMCIsInBhdGgiOiJcL2ZcLzU1ZGU3NWVjLTQwYjUtNGJlYi04Y2FiLWQ1ZDhiYjlhODUzOFwvZGZ6am12Yy01ZDA1YjI1Zi0xYmFlLTRlNjEtYWJkMS05ZTVhN2I3YzA0YjIuanBnIiwid2lkdGgiOiI8PTEyODAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.cx9aMVZKAIrHToBQodPuvivE5ef4p4KxeuWeyoYN_Ng'),
          ),
        ),
        title: const Text('Justin'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];
                       
                      return (message.fromWho == FromWho.hers)
                          ? HerMessageBubble( message: message )
                          : MyMessageBubble( message: message );
                    })),

            /// Caja de texto de mensajes
            MessageFieldBox(
              // onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
