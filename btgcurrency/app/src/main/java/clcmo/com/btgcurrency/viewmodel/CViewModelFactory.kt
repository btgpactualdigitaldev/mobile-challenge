package clcmo.com.btgcurrency.viewmodel

import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import clcmo.com.btgcurrency.repository.domain.uc.CUserCase

class CViewModelFactory(private val application: Application, private val userCase: CUserCase)
    : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T = modelClass.getConstructor(
        Application::class.java,
        CUserCase::class.java
    ).newInstance(
        application,
        userCase
    )
}