package br.com.daccandido.currencyconverterapp

import android.app.Application
import br.com.daccandido.currencyconverterapp.helper.PreferencesHelper
import io.realm.Realm
import io.realm.RealmConfiguration

private lateinit var preferencesHelper: PreferencesHelper

val dataBaseRealm : Realm get () = Realm.getDefaultInstance()
val prefs: PreferencesHelper get() = preferencesHelper

class CurrencyConvert: Application() {

    override fun onCreate() {
        super.onCreate()
        Realm.init(this)

        val config = RealmConfiguration.Builder()
            .name("teste-btg.realm")
            .deleteRealmIfMigrationNeeded()
            .build()

        Realm.setDefaultConfiguration(config)
        preferencesHelper = PreferencesHelper(this)
    }
}