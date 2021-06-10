package clcmo.com.btgcurrency.view.model

import clcmo.com.btgcurrency.repository.domain.model.Currency

data class CurrencyUI(val id: String, val name: String) {
    companion object {
        fun fromEntity(it: Currency) = CurrencyUI(it.id, it.name)
    }
}