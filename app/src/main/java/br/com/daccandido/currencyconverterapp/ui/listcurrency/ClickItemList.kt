package br.com.daccandido.currencyconverterapp.ui.listcurrency

import br.com.daccandido.currencyconverterapp.data.model.Currency

interface ClickItemList {
    fun onClick (currency: Currency)
}