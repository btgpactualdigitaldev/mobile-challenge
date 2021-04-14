package br.com.jlcampos.desafiobtg.presentation

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import br.com.jlcampos.desafiobtg.R
import br.com.jlcampos.desafiobtg.data.model.Currency
import br.com.jlcampos.desafiobtg.data.model.ResponseAPIList
import br.com.jlcampos.desafiobtg.data.model.ResponseAPIQuote
import br.com.jlcampos.desafiobtg.databinding.ActivityMainBinding
import br.com.jlcampos.desafiobtg.utils.AppPrefs
import org.json.JSONObject

@Suppress("NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")
class MainActivity : AppCompatActivity(), View.OnClickListener {

    private lateinit var binding: ActivityMainBinding

    private lateinit var viewModel: MainViewModel

    private val origem = 0
    private val destino = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.mainBtDestino.setOnClickListener(this)
        binding.mainBtOrigem.setOnClickListener(this)
        binding.mainBtCalc.setOnClickListener(this)

        viewModel = ViewModelProvider(this).get(MainViewModel::class.java)

        viewModel.mainGetListLiveData.observe(this, fun(resp: ResponseAPIList) {

            if (resp.success) {
                enableButton(true)
            } else {
                val session = AppPrefs(this@MainActivity)

                val alert = AlertDialog.Builder(this@MainActivity).create()
                alert.setMessage(resp.errorApi?.info)
                alert.setButton(AlertDialog.BUTTON_POSITIVE, getString(R.string.tentar_novamente)) { dialog, _ ->
                    dialog.dismiss()
                    getList()
                }
                if (!session.getListCurrencies().isNullOrEmpty()) {
                    alert.setButton(AlertDialog.BUTTON_NEGATIVE, getString(R.string.utilizar_list_offline)) { dialog, _ ->
                        dialog.dismiss()
                        enableButton(true)
                    }
                }
                alert.show()
            }
        })

        viewModel.mainGetQuoteLiveData.observe(this, fun(resp: ResponseAPIQuote) {

            if (resp.success) {

                enableButton(true)
                binding.mainTvResult.text = resp.calc

            } else {
                val alert = AlertDialog.Builder(this@MainActivity).create()
                alert.setMessage(resp.errorApi?.info)
                alert.setButton(AlertDialog.BUTTON_POSITIVE, getString(R.string.tentar_novamente)) { dialog, _ ->
                    dialog.dismiss()
                    converterMoeda()
                }
                if (JSONObject(AppPrefs(this@MainActivity).getMyQuotes()).has(binding.mainTvOrigem.text.toString() + binding.mainTvDestino.text.toString())) {
                    alert.setButton(AlertDialog.BUTTON_NEGATIVE, getString(R.string.utilizar_list_offline)) { dialog, _ ->
                        dialog.dismiss()
                        converterOff(binding.mainEtValor.text.toString(), binding.mainTvOrigem.text.toString() + binding.mainTvDestino.text.toString())
                        enableButton(true)
                    }
                }
                alert.setOnCancelListener {
                    enableButton(true)
                }
                alert.show()
            }

        })

        viewModel.mainGetQuoteOfflineLiveData.observe(this, fun(resp: String) {
            enableButton(true)
            binding.mainTvResult.text = resp
        })

        getList()
    }

    private fun converterOff(valor: String, quote: String) {
        enableButton(false)
        viewModel.quoteOff(valor, quote)
    }

    private fun getList() {
        enableButton(false)
        viewModel.getList()
    }

    private fun converterMoeda() {
        enableButton(false)
        viewModel.getQuote(
                binding.mainTvDestino.text.toString(),
                binding.mainTvOrigem.text.toString(),
                binding.mainEtValor.text.toString()
        )
    }

    private fun enableButton(enable: Boolean) {
        binding.mainBtOrigem.isEnabled = enable
        binding.mainBtDestino.isEnabled = enable
        binding.mainBtCalc.isEnabled = enable
        binding.mainEtValor.isEnabled = enable
    }

    override fun onClick(view: View) {
        when (view) {
            binding.mainBtDestino -> {
                shwoList(destino)
            }

            binding.mainBtOrigem -> {
                shwoList(origem)
            }

            binding.mainBtCalc -> {
                if (binding.mainTvDestino.text.isNullOrEmpty() || binding.mainTvOrigem.text.isNullOrEmpty() || binding.mainEtValor.text.toString().isEmpty()) {
                    Toast.makeText(this@MainActivity, getString(R.string.campo_vazio), Toast.LENGTH_LONG).show()
                } else {
                    converterMoeda()
                }
            }
        }
    }

    private fun shwoList(mFlag: Int) {
        val intent = Intent(this, ListCurrActivity::class.java)
        intent.putExtra(ListCurrActivity.EXTRA_FLAG, mFlag)
        intent.putExtra(ListCurrActivity.EXTRA_LIST, viewModel.getListAll())
        startActivityForResult(intent, ListCurrActivity.LAUNCH_SECOND_ACTIVITY)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == ListCurrActivity.LAUNCH_SECOND_ACTIVITY) {
            if (resultCode == Activity.RESULT_OK) {
                if (data?.getIntExtra(ListCurrActivity.EXTRA_FLAG, 0) == destino) {
                    data.getParcelableExtra<Currency>(ListCurrActivity.EXTRA_RESULT).let { binding.mainTvDestino.text = it?.key }
                }
                if (data?.getIntExtra(ListCurrActivity.EXTRA_FLAG, 1) == origem) {
                    data.getParcelableExtra<Currency>(ListCurrActivity.EXTRA_RESULT).let { binding.mainTvOrigem.text = it?.key }
                }
            }
        }
    }

}