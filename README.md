# Desafio BTG

Avaliadores,

Muito obrigado pela oportunidade. 

A arquitetura escolhida foi MVC. 
Não houve uso de story board, toda a UI foi escrita com view code e auto layout.
Não usei nenhum framework externo, é swift e iOS puro. 
Aplicativo disponível em light/dark mode.
Para a comunicação entre camadas foi usado PoP, nenhum controller ou model faz import do UIKit.
A tela de listagem é reaproveitada na tela de conversão para selecionar a usando o polimorfismo.
Foi criado views customizadas para cada item da interface.
Funciona em todos os iPhones e mantém o mesmo layout por conta do auto layout. 

![](btgappdemo.gif)


## Features
### Obrigatórias:
- [x ] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://currencylayer.com/documentation)
- [ x] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://currencylayer.com/documentation)
- [ x] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.

### Opcionais (não necessário, porém contam pontos):
- [ x] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [x ] Ordenação da lista de moedas por nome ou código.
- [ x] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [ ] Desenvolver testes unitários e/ou funcionais. 
    - fiz somente alguns unitários 
- [ ] Desenvolver o app seguindo a arquitetura MVVM.
- [ ] Pipeline automatizado.

### Fiz as seguintes features extras: 

- mostrar os dados da última atualização das cotações para o usuário
- botão para compartilhar a cotação buscada para outros apps
- botão para fazer a troca da cotação base pela cotação alvo e vice-versa.

### Se eu tivesse mais tempo faria: 
- comunição assincrona entre views com combine.
- testes unitários em todas os controllers
- testes de UI com snapshots
- CI/CD
- refatoraria o controller da tela de listagem de moedas disponíveis para usar um controller que buscasse as views, desacoplando assim a camada de network dela.
- criptografaria e obsfuscaria o accessID do API
- criaria um botão na celula da list para favoritar a moeda
- Estudaria o uso do swiftUI 
- refatoriaria a tela principal para usar stack view
