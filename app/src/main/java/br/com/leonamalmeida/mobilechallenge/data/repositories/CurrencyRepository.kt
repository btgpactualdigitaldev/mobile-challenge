package br.com.leonamalmeida.mobilechallenge.data.repositories

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.data.source.local.CurrencyLocalDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.remote.CurrencyRemoteDataSource
import br.com.leonamalmeida.mobilechallenge.data.Currency
import br.com.leonamalmeida.mobilechallenge.util.setSchedulers
import io.reactivex.disposables.CompositeDisposable

/**
 * Created by Leo Almeida on 27/06/20.
 */

interface CurrencyRepository {
    fun getCurrencies(
        refreshData: Boolean,
        keyToSearch: String,
        orderByName: Boolean
    ): LiveData<Result<List<Currency>>>
}

@Suppress("UnstableApiUsage")
class CurrencyRepositoryImpl(
    private val remoteDataSource: CurrencyRemoteDataSource,
    private val localDataSource: CurrencyLocalDataSource
) : CurrencyRepository {

    private val disposable = CompositeDisposable()

    override fun getCurrencies(
        refreshData: Boolean,
        keyToSearch: String,
        orderByName: Boolean
    ): LiveData<Result<List<Currency>>> {
        val data = MutableLiveData<Result<List<Currency>>>()

        if (refreshData)
            getCurrenciesFromNetwork(data)

        disposable.add(
            localDataSource.getCurrencies(keyToSearch, orderByName)
                .setSchedulers()
                .subscribe(
                    { data.value = (Result.Success(it)) },
                    {
                        it.printStackTrace()
                        data.value = (Result.Error(R.string.fetch_currency_default_error_message))
                    }
                )
        )

        return data
    }

    private fun getCurrenciesFromNetwork(data: MutableLiveData<Result<List<Currency>>>) {
        disposable.add(
            remoteDataSource.getCurrencies()
                .doOnSubscribe { data.postValue(Result.Loading(true)) }
                .doOnTerminate { data.postValue(Result.Loading(false)) }
                .flatMapCompletable { localDataSource.saveCurrencies(it) }
                .setSchedulers()
                .subscribe({},
                    {
                        it.printStackTrace()
                        data.value = (Result.Error(R.string.fetch_currency_default_error_message))
                    })
        )
    }
}