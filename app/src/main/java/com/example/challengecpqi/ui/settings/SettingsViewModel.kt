package com.example.challengecpqi.ui.settings

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.navigation.NavController
import androidx.navigation.fragment.findNavController
import com.example.challengecpqi.R
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.repository.SyncDownRepository
import kotlinx.coroutines.launch

class SettingsViewModel(val repository: SyncDownRepository, val navController: NavController) : ViewModel() {

    val errorMsg = MutableLiveData<String>()
    val notNetwork = MutableLiveData<Unit>()

    fun start() {
        viewModelScope.launch {
            when (val success = repository.startSyncDown()) {
                is Result.NetworkError -> {
                    notNetwork.value = Unit
                    goToConversionScreen()
                }
                is Result.GenericError-> errorMsg.value = success.errorResponse?.error?.info!!
                is Result.Success -> {
                    goToConversionScreen()
                }
            }
        }
    }

    private fun goToConversionScreen() {
        navController.popBackStack(R.id.navigation_settings, true)
        navController.navigate(R.id.navigation_conversion)
    }

}