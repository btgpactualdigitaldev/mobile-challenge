package br.com.convertify.ui

import android.os.Bundle
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.lifecycle.ViewModelProviders
import br.com.convertify.R
import br.com.convertify.models.CurrencyItem
import br.com.convertify.viewmodel.ConvertViewModel
import kotlinx.android.synthetic.main.fragment_currency_item_list_dialog.*
import kotlinx.android.synthetic.main.fragment_currency_item_list_dialog_item.view.*

const val ARG_ITEM_LIST = "@ARG_ITEM_LIST"

class CurrencyPickerDialog : BottomSheetDialogFragment(){

    lateinit var onItemSelected: (CurrencyItem) -> Unit

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(
            R.layout.fragment_currency_item_list_dialog,
            container,
            false
        )
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        list.layoutManager = LinearLayoutManager(context)

        val currencyItems: Array<CurrencyItem> =
            (arguments?.getParcelableArray(ARG_ITEM_LIST) as Array<CurrencyItem>)

        val adapter = CurrencyItemAdapter(currencyItems)

        list.adapter = adapter
    }

    fun setOnItemClick(handler: (CurrencyItem) -> Unit): CurrencyPickerDialog {
        onItemSelected = handler
        return this
    }

    private inner class ViewHolder constructor(
        inflater: LayoutInflater,
        parent: ViewGroup
    ) : RecyclerView.ViewHolder(
        inflater.inflate(
            R.layout.fragment_currency_item_list_dialog_item,
            parent,
            false
        )
    ) {
        val text: TextView = itemView.text
    }

    private inner class CurrencyItemAdapter(private val mCurrencyItems: Array<CurrencyItem>) :
        RecyclerView.Adapter<ViewHolder>() {

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
            return ViewHolder(LayoutInflater.from(parent.context), parent)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {

            val currencyItem: CurrencyItem = mCurrencyItems[position]

            holder.text.text = "${currencyItem.slug} ( ${currencyItem.code} )"
            holder.text.setOnClickListener {
                onItemSelected.invoke(currencyItem)
                dismiss()
            }
        }

        override fun getItemCount(): Int {
            return mCurrencyItems.size
        }
    }

    companion object {
        fun newInstance(currencyList: Array<CurrencyItem>): CurrencyPickerDialog =
            CurrencyPickerDialog().apply {
                arguments = Bundle().apply {
                    putParcelableArray(ARG_ITEM_LIST, currencyList)
                }
            }

    }
}
