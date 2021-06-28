package br.com.gft.main.interactor

import br.com.gft.common.UseCase
import br.com.gft.main.Resource

abstract class CurrencyConverterUseCase: UseCase<CurrencyConverterParams, Resource<Float>>()
class CurrencyConverterParams(val  currencyFrom:String,val  currencyTo:String,val  amount:Float)