package leandro.com.leandroteste.model.repository

import leandro.com.leandroteste.datasource.CurrencyLocalDataSource
import leandro.com.leandroteste.datasource.ICurrencyDataSource
import leandro.com.leandroteste.model.data.Currency

class CurrencyRepository(
    private val remoteDataSource: ICurrencyDataSource,
    private val currencyLocalDataSource: CurrencyLocalDataSource
) : ICurrencyDataSource {
    override fun listAll(success: (List<Currency>) -> Unit, failure: (String) -> Unit) {
        remoteDataSource.listAll({
            it.forEach(currencyLocalDataSource::save)
            success(it)
        }, {
            currencyLocalDataSource.listAll(success, failure)
        })
    }

    override fun save(currency: Currency) {

    }

    override fun convert(
        currencies: String, fromValue: Double, success: (String) -> Unit,
        failure: (String) -> Unit
    ) {
        remoteDataSource.convert(currencies, fromValue, {
            success(it)
        }, {
            failure(it)
        })
    }

}