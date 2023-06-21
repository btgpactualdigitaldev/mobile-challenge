package com.btg.convertercurrency.features.currency_converter.view

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.*
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import com.btg.convertercurrency.BR
import com.btg.convertercurrency.R
import com.btg.convertercurrency.base.BaseFragment
import com.btg.convertercurrency.databinding.CurrencyConverterFragmentBinding
import com.btg.convertercurrency.features.currency_converter.entity.CurrencyType
import com.btg.convertercurrency.features.util.navigateSafe
import com.btg.convertercurrency.features.util.poupup_currency_select.CustomPopupCurrencySelect
import kotlinx.android.synthetic.main.currency_converter_fragment.*
import org.koin.androidx.viewmodel.ext.android.viewModel

class CurrencyConverterFragment : BaseFragment() {

    private val currencyConverterViewModel: CurrencyConverterViewModel by viewModel()
    private var currencyType = CurrencyType.FROM

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setHasOptionsMenu(true)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return (DataBindingUtil.inflate(
            inflater,
            R.layout.currency_converter_fragment,
            container,
            false
        ) as CurrencyConverterFragmentBinding).apply {
            lifecycleOwner = this@CurrencyConverterFragment
            lifecycle.addObserver(currencyConverterViewModel)
            setVariable(BR.currencyParametter, currencyConverterViewModel.apply {
                etValueCurrency.addTextChangedListener(
                    currencyConverterViewModel.convertCurrency()
                )
            })
        }.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)

        btFromCurrency.setOnClickListener {
            currencyConverterViewModel.showPopupUpSelectCurrency()
            currencyType = CurrencyType.FROM
        }

        btToCurrency.setOnClickListener {
            currencyConverterViewModel.showPopupUpSelectCurrency()
            currencyType = CurrencyType.TO
        }

        setUpObservables()
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.munu_currency_converter, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        super.onOptionsItemSelected(item)

        when (item.itemId) {
            R.id.mnCurrencyList -> {
                findNavController().navigateSafe(R.id.action_currencyConverterFragment_to_listCurrencyFragment)
            }
            R.id.mnCurrencyUpdate -> {
                currencyConverterViewModel.updateQuoties()
            }
        }
        return true
    }

    private fun setUpObservables() {
        with(currencyConverterViewModel) {
            showPopupUpSelecCurrency.observe(viewLifecycleOwner, Observer { event ->
                if (!event.hasBeenHandled)
                    context?.let {
                        CustomPopupCurrencySelect(it).apply {
                            display(event.getContentIfNotHandled() ?: mutableListOf())
                            onClickCallback = { currencyItem ->
                                currencyConverterViewModel.setToCurrency(currencyItem, currencyType)
                            }
                        }
                    }
            })
        }
    }
}