import 'package:flutter/material.dart';
import 'package:perfil_profissional/widgets/badge_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        actions: const [
          Icon(Icons.share),
          SizedBox(width: 10),
          Icon(Icons.settings),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(height: 150, color: Colors.blue),

                Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.woman, size: 60, color: Colors.black54),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            const Text(
              "Carolline Maia Soares",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Desenvolvedora com experiência em Java e Python.",
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.link),
                SizedBox(width: 15),
                Icon(Icons.code),
                SizedBox(width: 15),
                Icon(Icons.work),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                BadgeWidget("Projetos", "12"),
                BadgeWidget("Seguidores", "540"),
                BadgeWidget("Repos", "30"),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[300],
              child: const Column(
                children: [
                  Text(
                    "CONTATO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 10),
                      Text("telefone: 1999326-9988"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("email: carollinemaias@gmail.com"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[300],
              child: const Column(
                children: [
                  Text(
                    "EXPERIÊNCIA PROFISSIONAL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Desenvolvedor com experiência em Java e Python, focado na criação de aplicações web.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: 300,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[300],
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "HABILIDADES TÉCNICAS E PESSOAIS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("• Java"),
                  Text("• Python"),
                  Text("• HTML"),
                  Text("• CSS"),
                  Text("• JavaScript"),
                  SizedBox(height: 10),
                  Text("• Comunicação"),
                  Text("• Resolução de problemas"),
                  Text("• Trabalho em equipe"),
                  Text("• Pensamento crítico"),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Projetos"),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: "Contato",
          ),
        ],
      ),
    );
  }
}
