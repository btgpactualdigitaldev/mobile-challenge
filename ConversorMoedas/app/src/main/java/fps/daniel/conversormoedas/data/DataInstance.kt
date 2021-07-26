package fps.daniel.conversormoedas.data

import fps.daniel.conversormoedas.enity.CurrencyLayer
import io.realm.Realm

class DataInstance: Data {

    private lateinit var realm: Realm

    override fun onCreate() {
        realm = Realm.getDefaultInstance()
    }

    override fun getCurrencies(): List<CurrencyLayer> {
        val response = mutableListOf<CurrencyLayer>()
        val realmList = realm.where(DataModel::class.java).findAll()
        realmList.forEach {
            response.add(
                CurrencyLayer(
                    it.symbol,
                    it.name,
                    it.quote
                )
            )
        }
        return response
    }

    override fun postCurrencies(currencies: List<CurrencyLayer>) {

        currencies.forEach {
            val currencyToAdd = DataModel(it.symbol, it.name, it.quote)
            realm.beginTransaction()
            realm.insertOrUpdate(currencyToAdd)
            realm.commitTransaction()
        }
    }

    override fun onDestroy() {
        realm.close()
    }
}