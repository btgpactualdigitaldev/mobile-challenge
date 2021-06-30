# Currency Buddy

Como resultado do desafio, criei o Currency Buddy, um app que faz a conversão de moedas utilizando a [API CurrencyLayer](https://currencylayer.com/documentation). Para a resolução utilizei a arquitetura MVC com uma camada separada de Networking, já que o app posui somente 2 telas com 2 chamadas distintas do mesmo serviço. Utilizei a lib externa Moya, para organizar melhor as chamadas da API extrna.

## Abrindo o App
Para rodar o app no simulador do XCode ou no seu dispositivo iOS, basta clonar o progeto usando `git clone` e executar o comando `pod install` para instalar as dependências.

<img src="./Screenshots/Screenshot 1.png" width="300" />
<img src="./Screenshots/Screenshot 2.png" width="300" />

## Funções Pricipais
- Conversão entre duas moedas
- Listagem de moedas (em tela modal)

## Funções Secundarias
- Busca na lista de moedas
- Tratamento de erros de networking e formatação
- Persistência nas moedas selecionadas (com user defaults)
## Observações
Fiz também um ícone e trabalhei em cima do design. Para exemplos de projetos meus utilizando MVVM, SwiftUI e Objective-C, você pode acessar [meu perfil do github](https://github.com/rodrigowoulddo).

_____
# Desafio BTG

Seja bem-vindo! Este é o seu primeiro passo para fazer parte do time de desenvolvimento do maior banco de investimentos da América Latina.

#### LEIA AS INSTRUÇÕES POR COMPLETO ANTES DE COMEÇAR

O Desafio consiste no desenvolvimento de um app de conversão de moedas. O app deve permitir que o usuário selecione a moeda de origem e a moeda a ser convertida, para então inserir o valor e visualizar o resultado da conversão. 

## Requisitos

O app deve counsumir a [Mobile Challenge API](https://btg-mobile-challenge.herokuapp.com), criada somente com o propósito desse desafio e portanto não apresenta dados reais. A API apresenta apenas as taxas de câmbio em relação a uma moeda de referência (dólar americano - `USD`), caso o usuário deseje fazer uma conversão entre quaisquer outras duas moedas, será necessário primeiro converter a moeda de origem para dólar e então de dólar para a moeda desejada.  

* Android: _Kotlin_ | iOS: _Swift_
* O aplicativo deve ter duas telas principais:
   * A tela de conversão deve conter:
      * Dois botões que permitam o usuário a escolher as moedas de origem e de destino.
      * Um campo de entrada de texto onde o usuário possa inserir o valor a ser convertido.
      * Uma campo de texto para apresentar o valor convertido.
   * A tela de listagem de moedas deve conter:
      * Uma lista das moedas disponíves para conversão, mostrando código e nome da moeda.
    
* A listagem de moedas deve ser mostrada obrigatóriamente em uma tela diferente da tela de conversão.

## Observações
* Dê preferência para a não utilização de bibliotecas externas;
* Caso opte por usar bibliotecas externas, prefira Gradle (Android) ou CocoaPods (iOS) como gerenciadores de dependência;
* O objetivo deste desafio é avaliar o seu conhecimento técnico, estilo de código, conhecimento de arquiteturas, padrões de programação e boas práticas. Faça disso uma oportunidade pra mostrar todo o seu conhecimento.

## Features
### Obrigatórias:
- [ ] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://btg-mobile-challenge.herokuapp.com/list)
- [ ] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://btg-mobile-challenge.herokuapp.com/live)
- [ ] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.

### Opcionais (não necessário, porém contam pontos):
- [ ] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [ ] Ordenação da lista de moedas por nome ou código.
- [ ] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [ ] Desenvolver testes unitários e/ou funcionais.
- [ ] Desenvolver o app seguindo a arquitetura MVVM.
- [ ] Pipeline automatizado.

## Processo de submissão
Para submeter o seu desafio, faça um fork deste projeto para sua conta no github, realize o clone e desenvolva localmente, no final, abra um pull request com o formato "[Plataforma] - Nome" para a master até a data limite estabelecida. Um exemplo seria "[iOS] - João da Silva".

### Boa sorte.
