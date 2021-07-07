package com.gft.presentation.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.liveData
import androidx.lifecycle.viewModelScope
import com.gft.domain.entities.CurrencyLabelList
import com.gft.domain.entities.Resource
import com.gft.domain.usecases.GetLabelsUseCase
import kotlinx.coroutines.Dispatchers

class ChooseCurrencyViewModel(private val getLabelsUseCase: GetLabelsUseCase) : ViewModel() {

    private var labels: LiveData<Resource<CurrencyLabelList>> =
        liveData(context = viewModelScope.coroutineContext + Dispatchers.IO) {
            emit(getLabelsUseCase.execute())
        }

    fun getLabelsLiveData() = labels
}