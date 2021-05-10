package com.geocdias.convecurrency.data.database

import com.geocdias.convecurrency.data.database.entities.CurrencyEntity

object CurrencyFakeProvider {
    fun currencyList(): List<CurrencyEntity> = listOf(
        CurrencyEntity(id = 1, code = "AED", name =  "United Arab Emirates Dirham"),
        CurrencyEntity(id = 2, code = "AFN", name =  "Afghan Afghani"),
        CurrencyEntity(id = 3, code = "ALL", name =  "Albanian Lek"),
        CurrencyEntity(id = 4, code = "AMD", name =  "Armenian Dram"),
        CurrencyEntity(id = 5, code = "ANG", name =  "Netherlands Antillean Guilder"),
        CurrencyEntity(id = 6, code = "AOA", name =  "Angolan Kwanza"),
        CurrencyEntity(id = 7, code = "ARS", name =  "Argentine Peso"),
        CurrencyEntity(id = 8, code = "AUD", name =  "Australian Dollar"),
        CurrencyEntity(id = 9, code = "AWG", name =  "Aruban Florin"),
        CurrencyEntity(id = 10, code = "AZN", name =  "Azerbaijani Manat"),
        CurrencyEntity(id = 11, code = "BAM", name =  "Bosnia-Herzegovina Convertible Mark"),
        CurrencyEntity(id = 12, code = "BBD", name =  "Barbadian Dollar"),
        CurrencyEntity(id = 13, code = "BDT", name =  "Bangladeshi Taka"),
        CurrencyEntity(id = 14, code = "BGN", name =  "Bulgarian Lev"),
        CurrencyEntity(id = 15, code = "BHD", name =  "Bahraini Dinar"),
        CurrencyEntity(id = 16, code = "BIF", name =  "Burundian Franc"),
        CurrencyEntity(id = 17, code = "BMD", name =  "Bermudan Dollar"),
        CurrencyEntity(id = 18, code = "BND", name =  "Brunei Dollar"),
        CurrencyEntity(id = 19, code = "BOB", name =  "Bolivian Boliviano"),
        CurrencyEntity(id = 20, code = "BRL", name =  "Brazilian Real"),
        CurrencyEntity(id = 21, code = "BSD", name =  "Bahamian Dollar")
    )

    fun currencyCodes(): List<String> {
        return currencyList().map { currencyEntity ->
            currencyEntity.code
        }
    }
}
