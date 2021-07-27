package com.autopass.rechargeapp.repository.local.attendant

import com.hotmail.fignunes.btg.repository.local.currency.resources.LocalCurrencyResources

interface LocalFactory {
    val currency: LocalCurrencyResources
}