package br.net.easify.currencydroid.view

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.OnBackPressedCallback
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import br.net.easify.currencydroid.R
import br.net.easify.currencydroid.database.model.Currency
import br.net.easify.currencydroid.databinding.FragmentCurrenciesBinding
import br.net.easify.currencydroid.util.hideKeyboard
import br.net.easify.currencydroid.view.adapters.CurrenciesAdapter
import br.net.easify.currencydroid.viewmodel.CurrenciesViewModel
import kotlinx.android.synthetic.main.fragment_currencies.*

class CurrenciesFragment : Fragment(), CurrenciesAdapter.OnItemClick {
    private lateinit var viewModel: CurrenciesViewModel
    private lateinit var dataBinding: FragmentCurrenciesBinding
    private lateinit var currenciesAdapter: CurrenciesAdapter

    private var currencyDestination = 0

    private val currenciesObserver = Observer<List<Currency>> {
        currenciesAdapter.updateData(it)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val callback: OnBackPressedCallback =
            object : OnBackPressedCallback(true /* enabled by default */) {
                override fun handleOnBackPressed() {
                    val action = CurrenciesFragmentDirections.actionHome(0, 0)
                    Navigation.findNavController(currencies).navigate(action)
                }
            }
        requireActivity().onBackPressedDispatcher.addCallback(this, callback)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        dataBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_currencies,
            container,
            false
        )

        return dataBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupViewModel()
        setupRecyclerView()
        setupButtons()
        setupTextSearch()
        checkArguments()
    }

    private fun checkArguments() {
        arguments?.let {
            currencyDestination = CurrenciesFragmentArgs.fromBundle(it).currencyDestination
        }
    }

    private fun setupTextSearch() {
        dataBinding.filterText.addTextChangedListener(object : TextWatcher {
            override fun afterTextChanged(s: Editable?) {

            }

            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                currenciesAdapter.filter.filter(s.toString())
            }
        })
    }

    private fun setupButtons() {
        dataBinding.backButton.setOnClickListener(View.OnClickListener {
            hideKeyboard()
            val action = CurrenciesFragmentDirections.actionHome(0, 0)
            Navigation.findNavController(currencies).navigate(action)
        })
    }

    private fun setupRecyclerView() {
        currenciesAdapter =
            CurrenciesAdapter(this, arrayListOf())

        dataBinding.currencies.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = currenciesAdapter
        }
    }

    private fun setupViewModel() {
        viewModel = ViewModelProviders.of(this).get(CurrenciesViewModel::class.java)
        viewModel.currencies.observe(viewLifecycleOwner, currenciesObserver)
    }

    override fun onItemClick(currency: Currency) {
        hideKeyboard()
        val action = CurrenciesFragmentDirections.actionHome(currency.id, currencyDestination)
        Navigation.findNavController(currencies).navigate(action)
    }
}