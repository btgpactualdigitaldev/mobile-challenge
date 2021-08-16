package com.br.cambio.customviews

import com.br.cambio.R

const val DIALOGSPINNER_LIST_CURRENCIES = "dialogspinner/list_currencies.json"

enum class DialogSpinnerEnum(val showSearchBar: Boolean,
                                 val title: Int,
                                 val searchHint: Int,
                                 val jsonPath: String) {

    CURRENTY(true, R.string.select_your_currencies, R.string.search_currency, DIALOGSPINNER_LIST_CURRENCIES)
}