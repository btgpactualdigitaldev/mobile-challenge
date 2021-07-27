package com.btg.teste.viewmodel

import androidx.databinding.BaseObservable
import androidx.databinding.Bindable
import com.btg.teste.BR

class MoneyConvert : BaseObservable() {

    @Bindable
    var value: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.value)
        }

    @Bindable
    var valueFinal: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.valueFinal)
        }

    @Bindable
    var origin: Conversion? = null
        set(value) {
            field = value
            notifyPropertyChanged(BR.valueFinal)
        }

    @Bindable
    var destination: Conversion? = null
        set(value) {
            field = value
            notifyPropertyChanged(BR.valueFinal)
        }

    @Bindable
    var filter: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.filter)
        }

    @Bindable
    var errorMessage: String = ""
        set(value) {
            field = value
            notifyPropertyChanged(BR.errorMessage)
        }


}