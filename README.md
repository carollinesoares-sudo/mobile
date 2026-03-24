#Conteúdo da Aula Anterior

#Introdução ao Desenvolvimento Mobile

###Tipo de desenvolvimento

-Nativo
    -Android
      SDK : Android SDK
        - IDE : Android Studio
        - Linguagens: Kotlin e Java
        - Ambientes: Mac, Win, Linux
    - Ios:
        - SDK: Cocoa Touch
        - IDE: Xcode
        - Liguagens: Swift / Objectype-C
        - Ambientes: Mac
 - 
- Multiplataforma


- Multiplataforma
    - React Native:
         -SDK: Node.JS
         -IDE: Vscode, 
         -JavaScript / TypeScript
         -Ambientes: Mac, Win, Linux

   -Flutter
        -SDK: Flutter SDK
        -IDE: VScode, Android Studio
        -Linguagens: Dart
        -Ambientes: Mac, Win, Linux

##Preparação do ambiente de desenvolvimento
### Instalação do FlutterSDK
-download do arquivo ZIP na página flutter.dev
-inclusão do flutter na pasta c:\src
-inclusão do flutter\bin nas váriaveis de ambiente
- teste o flutter --version


### Instalação do AndroidSDK
- download do Android SDK - Command Line Tools
- adicionar o Command-line ao c:\src\AndroidSDK
- adicionar o SDKManager as Variáveis de Ambiente
- download dos pacotes
    - emulador
    - platforms
    - platform-tools
    - build-tools
     - adicionar ADB e o Emulator as Variáveis de Ambiente
- Criação da Imagem do Emulador - via sdkmanager
- Build do Emulador - via sdkmanager

### Criação de Projetos e Códigos da Linha de Comando

- criação de projetos
    - flutter create nome_do_app
        - flags(parâmetros):
            - --empty : Cria um aplicativo "vazio"(hello World!)
            - --platforms : permite a seleção de uma plataforma de desenvolvimento
                - ex: --platforms=android (a criação do projeto será somente para a plataforma android)
    - exemplo de criação de uma aplicativo android vazio
        - flutter create nome_do_app --empty --platforms=android
        - obs: nome do aplicativo: todas as letras minusculas, separação de palavras com "_";
    - flutter doctor 
        - permite correção de pequenos problemas no flutter e identificação dos parâmetros funcionais em relação as plataformas de desenvolvimento
    - flutter clean
       -limpa o cache do build(apaga o apk anterior)
    - flutter run -v
       - build do app(apk)9
- instalação de depêndencias do PubSpec()
     - instalação
         - flutter pub add nome_dependencia
    - baixar e instalar depêndencias projetadas
        - flutter pub get
    - outros comando do flutter pub(depêndencias)
       - flutter pub outdated (verifica se as depêndencias estão desatualizadas)
       - flutter pub upgrade (Atualiza as dependências do flutter pub)

       ### Estrutura Básica de um Aplicativo em Flutter

    #### Árvore de Widgets
    ``mermaid

    flowchart TD
        subgraph MaterialApp["MaterialApp"]
        end
        subgraph Janelas["Janelas"]
            StateLess["StateLess"]
            StateFull["StateFull"]
        end
        subgraph Scaffold["Scaffold"]
            AppBar["Appbar"]
            Body["Body"]
            BNBar["BNBar"]
            Drawer["Drawer"]
            FAButton["FAButton"]
            SnackBar["SnackBar"]
        end
        MaterialApp --> Janelas
        Janelas --> Scaffold         

```

    

