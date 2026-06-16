
#  Todo List Sênior (projeto 09-06)

Aplicativo nativo desenvolvido em **Flutter** para gerenciamento inteligente de tarefas por blocos operacionais, contando com persistência local de dados e gerenciamento reativo de interface sob as diretrizes da norma **ISO/IEC/IEEE 29148:2018**.

---

##  1. Arquitetura do Projeto

O sistema adota o padrão de responsabilidade segregada em camadas, isolando a interface de usuário (`screens`) das regras de negócio (`models`) e do acesso a dados (`database`).

```text
lib/
├── database/
│   └── database_helper.dart       # Inicialização e Queries do SQLite
├── models/
│   ├── lista_model.dart           # Estrutura dos Blocos (Categorias)
│   └── tarefa_model.dart          # Estrutura das Tarefas
├── screens/
│   ├── home_screen.dart           # Painel Principal e Alternador de Tema
│   ├── detalhes_lista_screen.dart # Gerenciamento de Tarefas por Bloco
│   └── nova_tarefa_screen.dart    # Formulário de Criação de Diretrizes
├── main.dart                      # Inicializador do Ciclo de Vida do App
└── theme_controller.dart          # Controle Light/Dark via SharedPreferences
 2. Tecnologias & Dependências
Flutter SDK (^3.12.0)  Framework base para compilação nativa.

sqflite (^2.3.0) Banco de dados relacional embarcado (SQLite) para armazenamento local de tarefas.

shared_preferences (^2.3.0) Persistência de chave-valor para retenção do tema escolhido pelo usuário.

 3. Engenharia de Requisitos & Lógicas Internas
 Conversão de Tipos (SQLite vs Dart)
O SQLite não possui suporte nativo ao tipo booleano. O sistema mapeia o status feita de formato Boolean para Inteiro (1 para verdadeiro, 0 para falso) ao gravar e ler do banco de dados de forma automatizada.

 Sincronização Assíncrona Precoce
Para evitar o efeito visual de cintilação (glitch de renderização), a leitura do tema no disco é resolvida via await na função main() antes do método runApp() inicializar a interface gráfica.

 Reatividade
A comunicação entre telas e a atualização da Home ocorrem em tempo real através da escuta de rotas assíncronas com callbacks do tipo Future.

 4. Como Executar o Projeto no Terminal
Execute os comandos abaixo a partir do diretório raiz do projeto no VS Code:

Passo 1: Limpar Cache e Instalar Dependências
Bash
flutter clean && flutter pub get
Passo 2: Listar Dispositivos Conectados
Bash
flutter devices
Passo 3: Inicializar o Aplicativo
Bash
flutter run
 Caso tenha mais de um emulador ativo, utilize: flutter run -d ID_DO_DISPOSITIVO

⌨ Atalhos úteis em tempo de execução (Run Time)
r  Hot Reload (Aplica modificações visuais na tela instantaneamente).

R  Hot Restart (Reinicia o ciclo do app zerando o estado de navegação).

q  Interrompe o processo e fecha o aplicativo.