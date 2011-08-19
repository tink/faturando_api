Faturando Api (usando ActiveResource)
====================================================

faturando_api
-----------------

Permite acessar a API do [Faturando](http://faturan.do) usando ActiveResource.


### Instalação

Esta biblioteca pode ser instalada como uma e está disponível no [Rubygems](http://rubygems.org).

Para instalar basta executar o seguinte comando:

$ gem install faturando_api


### Requisitos

Esta biblioteca depende do ActiveResource com versão 2.3.4 ou maior.

$ gem install activeresource


### Utilização

Para utilizar a biblioteca basta importá-la utilizando:

    gem 'faturando_api'


Se você está usando Rails 3 basta adicionar a seguinte linha no Gemfile:

    gem 'faturando_api'

Se você está usando Rails 2.3.X basta adicionar a seguinte linha na configuração da aplicação,
por exemplo, no `environment.rb`

    config.gem 'faturando_api'

### Configurando

Para poder se comunicar com o Faturando você precisa configurar a chave da API e o código do produto a ser utilizado.

    Faturando.configure do |c|
      c.project_key = '1234'
      c.api_key   = 'XYZ'
    end

Se você estiver utilizando Rails deve preferêncialmente criar um initializer.
