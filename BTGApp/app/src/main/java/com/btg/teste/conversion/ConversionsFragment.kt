package com.btg.teste.conversion


import android.content.Context
import android.os.Bundle
import android.text.Editable
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.btg.teste.R
import com.btg.teste.databinding.FragmentConversionBinding
import com.btg.teste.recyclerview.adapter.CurrencyAdapter
import com.btg.teste.viewmodel.*
import com.google.android.material.snackbar.Snackbar
import kotlinx.coroutines.launch
import javax.inject.Inject

class ConversionsFragment : Fragment(), ConversionContracts.ConversionPresenterOutput,
    ConversionContracts.ConversionFilter {

    @Inject
    lateinit var iConversionPresenterInput: ConversionContracts.ConversionPresenterInput

    private lateinit var binding: FragmentConversionBinding
    private lateinit var conversion: ConversionViewModel
    private lateinit var moneyConvertViewModel: MoneyConvertViewModel
    private lateinit var currencyAdapter: CurrencyAdapter

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentConversionBinding.inflate(layoutInflater)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        DaggerConversionComponents
            .builder()
            .conversionModule(
                ConversionModule(
                    requireActivity(),
                    binding.root,
                    origin = requireArguments().getBoolean("origin", false),
                    conversionsFragment = this
                )
            )
            .build()
            .inject(this)

        lifecycleScope.launch {

            conversion =
                activity?.run {
                    ViewModelProvider(requireActivity()).get(ConversionViewModel::class.java)
                } ?: ConversionViewModel()

            moneyConvertViewModel =
                activity?.run {
                    ViewModelProvider(requireActivity()).get(MoneyConvertViewModel::class.java)
                } ?: MoneyConvertViewModel()

            moneyConvertViewModel.moneyConvert.filter = ""
            binding.filterAction = this@ConversionsFragment
            binding.filter = moneyConvertViewModel.moneyConvert


            conversion.listfilter = ArrayList(conversion.list)
            currencyAdapter = CurrencyAdapter(conversion.listfilter, callback = {
                iConversionPresenterInput.popConversions(it)
            })

            binding.listConversion.apply {
                adapter = currencyAdapter
                layoutManager = LinearLayoutManager(requireActivity(), RecyclerView.VERTICAL, false)
            }

            conversion.conversionLiveData.observe(viewLifecycleOwner,
                Observer {
                    conversion.list.clear()
                    conversion.list.addAll(it)
                    conversion.listfilter = ArrayList(conversion.list)
                    apresentationConversionsFilter(it)
                })

            binding.refrashConversion.setOnRefreshListener {
                iConversionPresenterInput.loadConversions(conversion, true)
            }

            iConversionPresenterInput.loadConversions(conversion, false)
        }
    }

    override fun filter(editable: Editable) {
        moneyConvertViewModel.moneyConvert.filter = editable.toString()
        conversion.listfilter = ArrayList(conversion.list)
        iConversionPresenterInput.filter(
            moneyConvertViewModel.moneyConvert.filter,
            conversion.listfilter
        )
    }

    override fun visibleFilter() {
        binding.editTextFilter.visibility = View.VISIBLE
    }

    override fun upOrigin(conversion: Conversion?) {
        moneyConvertViewModel.moneyConvert.origin = conversion
    }

    override fun upRecipient(conversion: Conversion?) {
        moneyConvertViewModel.moneyConvert.destination = conversion
    }

    override fun visibleRefrash() {
        binding.refrashConversion.isRefreshing = true
    }

    override fun goneRefrash() {
        binding.refrashConversion.isRefreshing = false
    }

    override fun getConversions(): MutableList<Conversion> =
        this.currencyAdapter.itens

    override fun apresentationConversions(conversions: MutableList<Conversion>) {
        this.conversion.conversionLiveData.value = conversions
    }

    override fun apresentationConversionsFilter(conversions: MutableList<Conversion>) {
        iConversionPresenterInput.cleanAndAddConversions(conversions)
        currencyAdapter.notifyDataSetChanged()
    }

    override fun errorConversions() =
        Snackbar.make(binding.root, R.string.fail_connection, Snackbar.LENGTH_LONG).show()

    override fun errorService(mensage: String?) =
        Snackbar.make(
            binding.root,
            mensage ?: requireActivity().getText(R.string.fail_result_request),
            Snackbar.LENGTH_LONG
        ).show()

    override fun failRequest() =
        Snackbar.make(binding.root, R.string.fail_request, Snackbar.LENGTH_LONG).show()

    override fun failNetWork() =
        Snackbar.make(binding.root, R.string.fail_connection, Snackbar.LENGTH_LONG).show()

    override fun onDestroyView() {
        hideKeyboard(requireContext(), binding.editTextFilter)
        super.onDestroyView()
    }

    fun hideKeyboard(context: Context, editText: View) {
        val imm: InputMethodManager =
            context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(editText.windowToken, 0)
    }
}
