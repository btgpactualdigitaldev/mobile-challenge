package br.com.btg.mobile.challenge.ui.currency.convert

import android.os.Bundle
import android.view.View
import android.widget.ArrayAdapter
import android.widget.Spinner
import androidx.appcompat.widget.AppCompatEditText
import androidx.appcompat.widget.AppCompatTextView
import androidx.navigation.fragment.findNavController
import br.com.arch.toolkit.delegate.viewProvider
import br.com.btg.mobile.challenge.R
import br.com.btg.mobile.challenge.base.BaseFragment
import br.com.btg.mobile.challenge.extension.coins
import br.com.btg.mobile.challenge.extension.message
import br.com.btg.mobile.challenge.extension.orZero
import br.com.btg.mobile.challenge.ui.HomeViewModel
import com.google.android.material.floatingactionbutton.FloatingActionButton
import org.koin.androidx.viewmodel.ext.android.sharedViewModel

class ConvertCurrencyFragment : BaseFragment(R.layout.fragment_convert) {

    private val spinnerCurrent: Spinner by viewProvider<Spinner>(R.id.sp_coin1)
    private val spinnerConvert: Spinner by viewProvider<Spinner>(R.id.sp_coin2)
    private val edtValueConvert: AppCompatEditText by viewProvider<AppCompatEditText>(R.id.edt_value)
    private val tvResult: AppCompatTextView by viewProvider<AppCompatTextView>(R.id.tv_result)
    private val fab: FloatingActionButton by viewProvider<FloatingActionButton>(R.id.fab_list_coins)

    private val viewModel: HomeViewModel by sharedViewModel()
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        observer()
        fab.setOnClickListener { goToListCurrency() }
    }

    private fun observer() {
        viewModel.dataRatesSuccess.observe(viewLifecycleOwner) { rates ->
            setUpSpinnerCurrent(rates.coins())
            setUpSpinnerConvert(rates.coins())
        }
        viewModel.error.observe(viewLifecycleOwner) {
            activity?.message(getString(R.string.server_error))
        }
    }

    private fun setUpSpinnerCurrent(list: List<String>) {
        activity?.apply {
            val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, list)
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinnerCurrent.adapter = adapter
            spinnerCurrent.setOnItemClickListener { _, _, i, _ ->
                tvResult.text = convertValue(i)
            }
        }
    }

    private fun setUpSpinnerConvert(list: List<String>) {
        activity?.apply {
            val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, list)
            adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
            spinnerConvert.adapter = adapter
            spinnerConvert.setOnItemClickListener { _, _, i, _ ->
                tvResult.text = convertValue(i)
            }
        }
    }

    private fun convertValue(position: Int): CharSequence {
        viewModel.run {
            return convertValue(
                edtValueConvert.text.toString().toDouble(),
                listRates[position].exchangeRate.orZero()
            )
        }
    }

    private fun goToListCurrency() {
        findNavController().navigate(R.id.action_convertCurrencyFragment_to_listCurrencyFragment)
    }
}
