package br.com.leonamalmeida.mobilechallenge.data.repositories

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.data.source.local.RateLocalDataSource
import br.com.leonamalmeida.mobilechallenge.data.source.remote.RateRemoteDataSource
import br.com.leonamalmeida.mobilechallenge.util.formatDecimal
import br.com.leonamalmeida.mobilechallenge.util.setSchedulers
import io.reactivex.disposables.CompositeDisposable

/**
 * Created by Leo Almeida on 29/06/20.
 */

interface RateRepository {

    fun makeConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): LiveData<Result<Pair<String, String>>>
}

@Suppress("UnstableApiUsage")
class RateRepositoryImpl(
    private val remoteDataSource: RateRemoteDataSource,
    private val localDataSource: RateLocalDataSource
) : RateRepository {

    private val disposable = CompositeDisposable()

    override fun makeConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): LiveData<Result<Pair<String, String>>> {
        val data = MutableLiveData<Result<Pair<String, String>>>()

        getRealTimeRateFromRemote(data)

        disposable.add(
            localDataSource.getRealTimeRate()
                .filter { it.isNotEmpty() }
                .map { calculateConversion(originCode, destinyCode, amount) }
                .setSchedulers()
                .subscribe(
                    { data.value = Result.Success(it) },
                    {
                        it.printStackTrace()
                        data.value = Result.Error(R.string.fetch_rate_default_error_message)
                    })
        )

        return data
    }

    private fun calculateConversion(
        originCode: String,
        destinyCode: String,
        amount: Float
    ): Pair<String, String> {
        val origin = localDataSource.getRateByCode(originCode)
        val destiny = localDataSource.getRateByCode(destinyCode)
        val convertedAmount = (amount / origin.value) * destiny.value

        return Pair(origin.getLastUpdateDate(), convertedAmount.formatDecimal())
    }

    private fun getRealTimeRateFromRemote(data: MutableLiveData<Result<Pair<String, String>>>) {
        disposable.add(
            remoteDataSource.getRealTimeRate()
                .doOnSubscribe { data.postValue(Result.Loading(true)) }
                .doOnTerminate { data.postValue(Result.Loading(false)) }
                .flatMapCompletable { localDataSource.saveRates(it) }
                .setSchedulers()
                .subscribe({}, {
                    it.printStackTrace()
                    data.value = Result.Error(R.string.fetch_rate_default_error_message)
                })
        )
    }
}