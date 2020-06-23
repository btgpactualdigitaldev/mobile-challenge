package com.example.currencyconverter.mocks

import com.example.currencyconverter.entity.Currency
import com.example.currencyconverter.infrastructure.database.Database
import com.example.currencyconverter.presentation.converter.MessageView

class MessageViewMock: MessageView {

    //Sensors
    var toastCalled = false

    override fun showToast(message: String) {
        toastCalled = true
    }
}