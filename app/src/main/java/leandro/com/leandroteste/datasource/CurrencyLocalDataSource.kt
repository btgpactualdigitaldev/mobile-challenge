package leandro.com.leandroteste.datasource

import leandro.com.leandroteste.Util.AppExecutors
import leandro.com.leandroteste.model.dao.CurrencyDao
import leandro.com.leandroteste.model.data.Currency

class CurrencyLocalDataSource constructor(private val dao: CurrencyDao,
                                          private val appExecutors: AppExecutors
):
    ICurrencyDataSource {
    override fun listAll(success: (List<Currency>) -> Unit, failure: (String) -> Unit) {
        appExecutors.roomThreadExecutor.execute{
            val currencies = dao.getAll()
            appExecutors.mainThreadExecutor.execute{success(currencies)}
        }
    }

    override fun save(currency: Currency) {
        appExecutors.roomThreadExecutor.execute{
            dao.insertAll(currency)
        }
    }

    override fun convert(currencies: String, fromValue: Double, success: (String) -> Unit,
                         failure: (String) -> Unit) {

    }
}