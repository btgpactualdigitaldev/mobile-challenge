package com.romildosf.currencyconverter.dao

interface DAOProvider {
    fun currencyDao(): CurrencyDao
}