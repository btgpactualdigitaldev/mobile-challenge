# Desafio BTG

Avaliadores,

Muito obrigado pela oportunidade de fazer esse desafio.

A arquitetura utilizado foi MVVM porém sem utilizar Reactive Programming. Não usei nenhum framework externo. 
O UI do aplicativo foi escrito 100% em view code sem utilizar Storyboards ou Xibs. Foram criados vários views customizadas para os interfaces para facilitar a montagem das telas. 
O aplicativo funciona em iOS 11 - 13 (com DarkMode no iOS13) e foi testado em iOS 11.4, 12.4 e 13.6, utilizando o iPhone SE, iPhone 8, iPhone 8 Plus, iPhone X, iPhone Xs Max (somente 12.4 e 13.6). 
Em iOS 13 foi utilizado UITableViewDiffableDataSource para fazer o search, no iOS 11 e 12 foi feito uma implementação somente para demonstrar o funcionalidade, para produção seria necessário uma melhoria. 
O Aplicativo esta feito para aceitar dynamic fonts type. Outros features de Accessibility não foram implementadas.

## Features
### Obrigatórias:
- [x] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://currencylayer.com/documentation)
- [x] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://currencylayer.com/documentation)
- [x] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.

### Opcionais (não necessário, porém contam pontos):
- [x] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [x] Ordenação da lista de moedas por nome ou código.
- [x] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [ ] Desenvolver testes unitários e/ou funcionais. 
- [x] Desenvolver o app seguindo a arquitetura MVVM.
- [ ] Pipeline automatizado.

### Proximos passos:
- Melhorar o Accessibility
- Preparar para localização 
- Testes unitários
- Testes de UI
- Refatorar os ViewControllers de BaseConverter e TargetConverter para ser um view so com polymorphism
- Utilizar Combine para comunicação
- Criptografar o API Access Key
