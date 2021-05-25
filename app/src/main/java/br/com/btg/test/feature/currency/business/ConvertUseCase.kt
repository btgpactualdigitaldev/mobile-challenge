package br.com.btg.test.feature.currency.business

import br.com.btg.test.base.BaseUseCase
import br.com.btg.test.data.Resource
import br.com.btg.test.feature.currency.repository.CurrencyRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map

class ConvertUseCase(
    private val currencyRepository: CurrencyRepository
) : BaseUseCase<ConvertUseCase.ConvertRequest, Double>(
    Dispatchers.IO
) {
    override fun execute(parameters: ConvertRequest): Flow<Resource<Double>> {
        return currencyRepository.convert(parameters.currencies).map { response ->
            var convertedValue = 0.0
            response.quotes?.values?.forEachIndexed { position, rate ->
                when (position) {
                    0 -> convertedValue = parameters.value / rate
                    else -> convertedValue *= rate
                }
            }
            Resource.success(convertedValue)
        }
    }

    class ConvertRequest(val value: Double, val currencies: String)
}