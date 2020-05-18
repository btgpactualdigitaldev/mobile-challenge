package com.btg.teste.viewmodel

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import com.btg.teste.BR

class Conversion : BaseObservable() {

    @Bindable
    var currency: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.currency)
        }

    @Bindable
    var name: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.name)
        }

    @Bindable
    var value: Double = 0.0
        set(value) {
            field = value
            notifyPropertyChanged(BR.value)
        }


    fun mapper(currency: String, name: String): Conversion {
        this.currency = currency
        this.name = name
        return this
    }
}