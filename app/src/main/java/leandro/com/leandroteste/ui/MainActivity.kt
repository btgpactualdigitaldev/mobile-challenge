package leandro.com.leandroteste.ui

import android.app.Application
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import androidx.room.Room
import leandro.com.leandroteste.R
import leandro.com.leandroteste.Util.AppExecutors
import leandro.com.leandroteste.databinding.ActivityMainBinding
import leandro.com.leandroteste.datasource.CurrencyLocalDataSource
import leandro.com.leandroteste.model.CurrencyDataSource
import leandro.com.leandroteste.model.api.CurrencyApi
import leandro.com.leandroteste.model.dao.AppDatabase
import leandro.com.leandroteste.model.dao.CurrencyDao
import leandro.com.leandroteste.model.repository.CurrencyRepository
import leandro.com.leandroteste.viewmodel.ConvertViewModel
import leandro.com.leandroteste.viewmodel.ConvertViewModelFactory
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


class MainActivity : AppCompatActivity() {

    companion object {
        const val CONVERT_FROM = "covertFrom"
        const val CONVERT_FROM_RESULT_OK = 1
        const val CONVERT_FROM_RESULT_INITIALS = "CONVERT_FROM_RESULT_INITIALS"
        const val CONVERT_FROM_RESULT_NAME = "CONVERT_FROM_RESULT_NAME"
        const val CONVERT_TO = "covertTo"
        const val CONVERT_TO_RESULT_OK = 2
        const val CONVERT_TO_RESULT_INITIALS = "CONVERT_TO_RESULT_INITIALS"
        const val CONVERT_TO_RESULT_NAME = "CONVERT_TO_RESULT_NAME"
    }

    lateinit var viewModel: ConvertViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding: ActivityMainBinding =
            DataBindingUtil.setContentView(this, R.layout.activity_main)

        viewModel = creatViewModel(application)
        binding.viewModel = viewModel
        binding.convertFromInfo.setOnClickListener {
            val intent = Intent(this, CurrencyListActivity::class.java)
            intent.putExtra(CONVERT_FROM, true)
            startActivityForResult(
                intent,
                CONVERT_FROM_RESULT_OK
            )
        }
        binding.convertToInfo.setOnClickListener {
            val intent = Intent(this, CurrencyListActivity::class.java)
            intent.putExtra(CONVERT_TO, true)
            startActivityForResult(
                intent,
                CONVERT_TO_RESULT_OK
            )
        }
        binding.convertBtn.setOnClickListener {
            viewModel.convertMoney(binding.convertFromValueEdt.text.toString())
        }
        binding.lifecycleOwner = this
        this.lifecycle.addObserver(viewModel)

    }


    fun creatViewModel(application: Application): ConvertViewModel {

        val retrofit = Retrofit.Builder().baseUrl("http://apilayer.net/api/")
            .addConverterFactory(GsonConverterFactory.create()).build()
        val currencyDataSource = CurrencyDataSource(retrofit.create(CurrencyApi::class.java))

        val localDataSource = CurrencyLocalDataSource(currencyDao(application), AppExecutors())

        val repository = CurrencyRepository(currencyDataSource, localDataSource)

        val factory = ConvertViewModelFactory(repository, application)

        return ViewModelProvider(this, factory).get(ConvertViewModel::class.java)
    }

    fun currencyDao(applicationContext: Application): CurrencyDao {
        return Room.databaseBuilder(
            applicationContext,
            AppDatabase::class.java, "currency-app"
        )
            .build()
            .currencyDao()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (resultCode == CONVERT_FROM_RESULT_OK) {
            val fromItemInitials = data?.getStringExtra(CONVERT_FROM_RESULT_INITIALS)
            val fromItemName = data?.getStringExtra(CONVERT_FROM_RESULT_NAME)
            viewModel.setFromInfo(fromItemInitials!!, fromItemName!!)
        } else if (resultCode == CONVERT_TO_RESULT_OK) {
            val toItemInitials = data?.getStringExtra(CONVERT_TO_RESULT_INITIALS)
            val toItemName = data?.getStringExtra(CONVERT_TO_RESULT_NAME)
            viewModel.setToInfo(toItemInitials!!, toItemName!!)
        }
        super.onActivityResult(requestCode, resultCode, data)
    }

}
