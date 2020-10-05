# Desafio BTG - Currency Converter

Aplicação feita para a plataforma Android na liguagem Kotlin [versão 1.4.0](https://github.com/JetBrains/kotlin/releases/tag/v1.4.0)

### Arquitetura

Foi utilizado para este projeto a arquitetura MVVM + Clean Arch, separado nos respectivos pacotes

* __domain__ - Responsável pelas regras e modelos de negócio e mapeamento de dados vindos das requisições
* __data__ - Responsável pela camada de dados vindas da internet e de armazenamento local, com seus respectivos responses e entidades de dados para serem salvos
* __presenter__ - Responsável pela apresentação de UI, contém as activities, fragments, modelos de UI
* __commons__ - Contém arquivos comuns que foram utilizados em todas as outras camadas da aplicação

### Libs

Abaixo a lista com as libs utilizadas para facilitar e acelerar o desenvolvimento da aplicação em curto prazo.

| Lib | Versão |
| ------ | ------ |
| Recycler | 1.1.0 |
| Constraint | 2.0.1 |
| Room | 2.2.5 |
| Retrofit | 2.6.2 |
| Lifecycle | 2.2.0 |
| Coroutine | 1.3.9 |
| Mockito | 3.2.4 |