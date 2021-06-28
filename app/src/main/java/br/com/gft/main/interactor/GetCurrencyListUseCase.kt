package br.com.gft.main.interactor

import br.com.gft.common.UseCase
import br.com.gft.main.Resource
import br.com.gft.main.iteractor.model.Currency

abstract class GetCurrencyListUseCase: UseCase<Unit, Resource<List<Currency>>>()
