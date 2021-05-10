package com.geocdias.convecurrency.ui.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.repository.CurrencyRepository
import com.geocdias.convecurrency.util.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class CurrencyViewModel @Inject constructor(val repository: CurrencyRepository): ViewModel() {

    val currencies: LiveData<Resource<List<CurrencyModel>>> = repository.fetchCurrencies()
}
