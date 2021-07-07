package br.net.easify.currencydroid.view

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.FragmentHomeBinding
import br.net.easify.currencydroid.model.ConversionValues
import br.net.easify.currencydroid.util.Constants
import br.net.easify.currencydroid.viewmodel.HomeViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class HomeFragment : Fragment() {

    private lateinit var viewModel: HomeViewModel
    private lateinit var dataBinding: FragmentHomeBinding
    private lateinit var conversionValues: ConversionValues
    private lateinit var fromValue: Currency
    private lateinit var toValue: Currency

    private val currenciesFromApiObserver =
        Observer<br.net.easify.currencydroid.api.model.Currency> {
        viewModel.saveCurrenciesDataIntoLocalDatabase(it)
    }

    private val loadingErrorObserver = Observer<Boolean> {
        if (it) {
            val action = HomeFragmentDirections.actionError()
            Navigation.findNavController(requireView()).navigate(action)
        }
    }

    private val bannerTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            dataBinding.info.visibility = View.VISIBLE
            dataBinding.banner.visibility = View.VISIBLE
            dataBinding.banner.text = it
        } else {
            dataBinding.info.visibility = View.GONE
            dataBinding.banner.visibility = View.GONE
        }
    }

    private val lastUpdateTextObserver = Observer<String> {
        if (it.isNotEmpty()) {
            dataBinding.lastUpdate.visibility = View.VISIBLE
            dataBinding.lastUpdate.text = getString(R.string.last_update) +  ": " + it
        } else {
            dataBinding.lastUpdate.visibility = View.GONE
        }
    }

    private val fromValueObserver = Observer<Currency> {
        if (it != null) {
            this.fromValue = it
            dataBinding.fromValue = this.fromValue
        }
    }

    private val toValueObserver = Observer<Currency> {
        if (it != null) {
            this.toValue = it
            dataBinding.toValue = this.toValue
        }
    }

    private val conversionValuesObserver = Observer<ConversionValues> {
        if (it != null) {
            this.conversionValues = it
            dataBinding.conversionValues = this.conversionValues
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        dataBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_home,
            container,
            false
        )

        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupViewModel()
        setupBanner()
        setupCardListeners()
        setupInvertCurrenciesButton()
        setupCurrencyValueListener()
        checkArguments()

        //TODO For some yet unknown reason, the default currencies were not updated
        // when the fragment started. This is a workaround to solve the problem.
        // I need to investigate it. It happens only on the first launch.
        // Once the default currency values are saved on shared preferences,
        // the problem disappears
        GlobalScope.launch(context = Dispatchers.Main) {
            delay(3000)
            viewModel.loadDefaultCurrencies()
        }
    }

    private fun setupCurrencyValueListener() {
        dataBinding.currencyValue.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {
                viewModel.calculate()
            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                if (s.toString().trim { it <= ' ' }.isEmpty())
                    viewModel.clearConvertedValue()
            }
        })
    }

    private fun setupInvertCurrenciesButton() {
        dataBinding.invertCurrencies.setOnClickListener(View.OnClickListener {
            viewModel.invertCurrencies()
        })
    }

    private fun checkArguments() {
        arguments?.let {
            val id = HomeFragmentArgs.fromBundle(it).currencyId
            val currencyDestination = HomeFragmentArgs.fromBundle(it).currencyDestination
            if (id > 0) {
                if (currencyDestination == Constants.currencyDestinationFrom) {
                    viewModel.updateFromCurrency(id)
                } else {
                    viewModel.updateToCurrency(id)
                }
            }
        }
    }

    private fun setupCardListeners() {
        dataBinding.fromCard.setOnClickListener(View.OnClickListener {
            val action = HomeFragmentDirections.actionCurrencies(Constants.currencyDestinationFrom)
            Navigation.findNavController(it).navigate(action)
        })

        dataBinding.toCard.setOnClickListener(View.OnClickListener {
            val action = HomeFragmentDirections.actionCurrencies(Constants.currencyDestinationTo)
            Navigation.findNavController(it).navigate(action)
        })
    }

    private fun setupViewModel() {
        viewModel = ViewModelProviders.of(this).get(HomeViewModel::class.java)
        viewModel.bannerText.observe(viewLifecycleOwner, bannerTextObserver)
        viewModel.lastUpdateText.observe(viewLifecycleOwner, lastUpdateTextObserver)
        viewModel.fromValue.observe(viewLifecycleOwner, fromValueObserver)
        viewModel.toValue.observe(viewLifecycleOwner, toValueObserver)
        viewModel.conversionValues.observe(viewLifecycleOwner, conversionValuesObserver)
        viewModel.currenciesFromApi.observe(viewLifecycleOwner, currenciesFromApiObserver)
        viewModel.loadingError.observe(viewLifecycleOwner, loadingErrorObserver)
    }

    private fun setupBanner() {
        dataBinding.banner.isSelected = true
    }
}