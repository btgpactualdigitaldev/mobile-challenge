# Desafio BTG

## Requisitos

- [X] As taxas de câmbio disponíveis devem ser obtidas da chamada de [API Supported Currencies (/list)](https://currencylayer.com/documentation)
- [X] A cotação atual deve ser obtida da chamada de [API Real-time Rates (/live)](https://currencylayer.com/documentation)
- [X] É necessário fazer tratamento de erros e dos fluxos de exceção, como busca vazia, carregamento e outros erros que possam ocorrer.
- [X] Funcinalidade de busca na lista de moedas por nome ou sigla da moeda ("dólar" ou "USD").
- [X] Ordenação da lista de moedas por nome ou código.
- [X] Realizar a persistência local da lista de moedas e taxas para permitir o uso do app no caso de falta de internet.
- [X] Desenvolver testes unitários e/ou funcionais.
- [ ] Desenvolver o app seguindo a arquitetura MVVM.
(A arquitetura utilizada foi o VIPER (Clean architecture), para facilitar os testes unitários em cima da lógica de programação e segmentar cada parte do projeto, seguindo os princípios de SOLID)
- [ ] Pipeline automatizado (Apenas com a implementação do sonar).

### Obrigado.
