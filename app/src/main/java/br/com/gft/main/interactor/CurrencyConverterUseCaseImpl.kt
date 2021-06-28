package br.com.gft.main.interactor

import br.com.gft.main.Resource
import br.com.gft.main.service.CurrencyLayerService

val USD: String = "USD"

class CurrencyConverterUseCaseImpl(private val currencyLayerService: CurrencyLayerService) :
    CurrencyConverterUseCase() {
    override suspend fun execute(params: CurrencyConverterParams): Resource<Float> {

        try {
            if(params.currencyFrom==params.currencyTo){
                return Resource.success(params.amount)
            }

            var quotations = ""
            if (params.currencyFrom == USD) {
                quotations = params.currencyTo
            } else {
                quotations = "${params.currencyFrom},${params.currencyTo}"
            }

            val responseCurrentQuotationFromDollar =
                currencyLayerService.getCurrentQuotationFromDollar(quotations)

            if (responseCurrentQuotationFromDollar.isSuccessful) {
                val currentQuotationResponse = responseCurrentQuotationFromDollar.body()

                currentQuotationResponse?.let { currentQuotationResponse ->
                    if (params.currencyFrom == USD) {
                        val quotationValue = currentQuotationResponse.quotes.map {
                            it.value
                        }.first()
                        val convertedAmount = quotationValue * params.amount
                        return Resource.success(convertedAmount)
                    }else{
                        val (quotationFrom,quotationTo) = currentQuotationResponse.quotes.map {
                            it.value
                        }
                        val convertedAmount = (quotationFrom/quotationTo) * (params.amount)
                        return Resource.success(convertedAmount)
                    }
                }
            }
            return Resource.error(Exception("Não foi possível converter o valor,\ntente novamente mais tarde"))

        }catch (e:java.lang.Exception){
            return Resource.error(e)
        }

    }

}