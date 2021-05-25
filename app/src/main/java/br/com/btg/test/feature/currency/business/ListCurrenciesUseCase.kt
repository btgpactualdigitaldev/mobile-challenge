package br.com.btg.test.feature.currency.business

import br.com.btg.test.base.BaseUseCase
import br.com.btg.test.data.Resource
import br.com.btg.test.feature.currency.persistence.CurrencyDao
import br.com.btg.test.feature.currency.persistence.CurrencyEntity
import br.com.btg.test.feature.currency.repository.CurrencyRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.map

class ListCurrenciesUseCase(
    private val currencyRepository: CurrencyRepository,
    private val currencyDao: CurrencyDao
) : BaseUseCase<Void?, List<CurrencyEntity>>(
    Dispatchers.IO
) {
    override fun execute(parameters: Void?): Flow<Resource<List<CurrencyEntity>>> {
        var flowDao = currencyDao.getAll()
        var flowRemote = currencyRepository.currenciesList()

        return flowDao.combine(flowRemote) { entities, models ->
            var list = mutableListOf<CurrencyEntity>()

            models?.entries?.forEach { item ->

                var currency =
                    CurrencyEntity(
                        item.key,
                        item.value
                    )
                list.add(currency)

                if (currencyDao.isRowIsExist(item.key).not()) {
                    currencyDao.insertAll(currency)
                }
            }

            list
        }.map {
            Resource.success(it)
        }
    }
}