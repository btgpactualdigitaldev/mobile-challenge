package com.gui.antonio.testebtg.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.gui.antonio.testebtg.repository.IAppRepository
import javax.inject.Inject

class MainViewModelFactory @Inject constructor(val repository: IAppRepository) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = MainViewModel(repository) as T
}