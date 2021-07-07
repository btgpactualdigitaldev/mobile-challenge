package br.net.easify.currencydroid.services

import android.app.Service
import android.content.Intent
import android.os.IBinder
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import br.net.easify.currencydroid.MainApplication
import br.net.easify.currencydroid.api.QuoteService
import br.net.easify.currencydroid.api.model.Quote
import br.net.easify.currencydroid.database.AppDatabase
import br.net.easify.currencydroid.util.DatabaseUtils
import br.net.easify.currencydroid.util.SharedPreferencesUtil
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import java.util.*
import javax.inject.Inject

class RateService: Service() {

    private var timer: Timer? = null
    private var timerTask: TimerTask? = null

    private val oneSecond: Long = 1000*5*60
    private val oneHour: Long = 1000*60*60

    private val disposable = CompositeDisposable()

    @Inject
    lateinit var database: AppDatabase

    @Inject
    lateinit var quoteService: QuoteService

    @Inject
    lateinit var sharedPreferencesUtil: SharedPreferencesUtil

    companion object {
        const val rateServiceUpdate =
            "br.net.easify.currencydroid.services.RateService"
    }

    override fun onBind(p0: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(
        intent: Intent?,
        flags: Int,
        startId: Int
    ): Int {
        super.onStartCommand(intent, flags, startId)
        startTimer()
        return START_STICKY
    }

    override fun onCreate() {
        super.onCreate()
        (application as MainApplication).getAppComponent()?.inject(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        disposable.clear()
        stopTimerTask()
    }

    private fun startTimer() {
        timer = Timer()
        initializeTimerTask()
        timer!!.schedule(timerTask, oneSecond, oneHour)
    }

    private fun initializeTimerTask() {
        timerTask = object : TimerTask() {
            override fun run() {
                disposable.add(
                    quoteService.live()
                        .subscribeOn(Schedulers.newThread())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribeWith(object : DisposableSingleObserver<Quote>() {
                            override fun onSuccess(res: Quote) {
                                if (res.success) {
                                    val quotes =
                                        DatabaseUtils.mapToQuote(res.quotes)

                                    database.quoteDao().deleteAll()
                                    database.quoteDao().insert(quotes)

                                    sharedPreferencesUtil.setLastRateUpdate(res.timestamp)

                                    val intent = Intent(rateServiceUpdate)
                                    val broadcastManager =
                                        LocalBroadcastManager.getInstance(applicationContext)
                                    broadcastManager.sendBroadcast(intent)
                                }
                            }

                            override fun onError(e: Throwable) {
                                e.printStackTrace()
                            }
                        })
                )
            }
        }
    }

    private fun stopTimerTask() {
        if (timer != null) {
            timer!!.cancel()
            timer = null
        }
    }
}