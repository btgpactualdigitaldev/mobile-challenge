package leandro.com.leandroteste.datasource

import leandro.com.leandroteste.model.data.Currency

interface ICurrencyDataSource {
    fun listAll(success: (List<Currency>) -> Unit, failure: (String) -> Unit)
    fun save(currency: Currency)
    fun convert(currencies:String, fromValue:Double, success: (String) -> Unit, failure: (String) -> Unit)
}