package br.com.gft.main.interactor

import br.com.gft.main.Resource
import br.com.gft.main.iteractor.model.Currency
import br.com.gft.main.service.CurrencyLayerService

class GetCurrencyListUseCaseImpl(private val currencyLayerService: CurrencyLayerService) :
    GetCurrencyListUseCase() {
    override suspend fun execute(params: Unit): Resource<List<Currency>> {
        try {
            val response = currencyLayerService.listCurrencies()

            if (response.isSuccessful) {
                val valueResponse = response.body()
                valueResponse?.let { currencyListResponse ->
                    if (!currencyListResponse.currencies.isNullOrEmpty()) {
                        return Resource.success(Currency.listFromResponse(currencyListResponse.currencies))
                    }
                }
            }
            return Resource.error(Exception("Não foi possível carregar a lista"))
        }catch (e:Exception){
            return Resource.error(e)
        }
    }

}