package com.br.cambio.customviews

import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.Window
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.br.cambio.R
import java.util.HashMap

class DialogSpinner : DialogFragment(), DialogSpinnerSearchListener {

    private lateinit var dialogSpinnerEnum: DialogSpinnerEnum
    private lateinit var listener: (DialogSpinnerModel) -> Unit
    private lateinit var dialogSpinnerAdapter: DialogSpinnerAdapter
    private lateinit var spinnerList: List<DialogSpinnerModel>

    private var dialogSpinnerTitle: TextView? = null
    private var emptySearch: LinearLayout? = null
    private lateinit var recyclerView: RecyclerView
    private lateinit var editText: EditText
    private lateinit var buttonClear: Button
    private lateinit var containerSearch: LinearLayout

    companion object {

        const val INTENT_EXTRA_SPINNER_ENUM = "spinnerEnum"

        var isShowing: Boolean = false

        @JvmStatic
        fun newInstance(dialogSpinnerEnum: DialogSpinnerEnum?,
                        listener: (DialogSpinnerModel) -> Unit): DialogSpinner {

            val bundle = Bundle().apply {
                putSerializable(INTENT_EXTRA_SPINNER_ENUM, dialogSpinnerEnum)
            }

            val fragment = DialogSpinner()
            fragment.arguments = bundle
            fragment.listener = listener
            return fragment
        }

        @JvmStatic
        fun newInstance(spinnerList: ArrayList<DialogSpinnerModel>,
                        listener: (DialogSpinnerModel) -> Unit): DialogSpinner {

            val bundle = Bundle().apply {
                putParcelableArrayList(INTENT_EXTRA_SPINNER_ENUM, spinnerList)
            }

            val fragment = DialogSpinner()
            fragment.arguments = bundle
            fragment.listener = listener
            return fragment
        }

        fun createDialog(dialogSpinnerEnum: DialogSpinnerEnum?,
                         listener: (DialogSpinnerModel) -> Unit): DialogSpinner {
            return newInstance(dialogSpinnerEnum, listener)
        }

        fun createDialog(spinnerList: ArrayList<DialogSpinnerModel>,
                         listener: (DialogSpinnerModel) -> Unit): DialogSpinner {
            return newInstance(spinnerList, listener)
        }
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        isShowing = true
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View {
        val view = inflater.inflate(R.layout.dialog_spinner, container, false)

        getSpinnerEnum()
        findViews(view)
        setListeners()
        getSpinnerList()

        dialogSpinnerAdapter = DialogSpinnerAdapter(spinnerList, activity) { dialogSpinnerModel: DialogSpinnerModel ->
            dismiss()
            listener(dialogSpinnerModel)
        }

        val itemDecorator = DividerItemDecoration(activity, DividerItemDecoration.VERTICAL)
        ContextCompat.getDrawable(requireActivity(), R.drawable.divider_dialog_spinner)?.let { drawable ->
            itemDecorator.setDrawable(drawable)
        }

        recyclerView.apply {
            this.adapter = dialogSpinnerAdapter
            this.layoutManager = LinearLayoutManager(context, LinearLayoutManager.VERTICAL, false)
            this.addItemDecoration(itemDecorator)
        }

        setTextWatcher()
        setSearchVisibility()
        setTexts()

        return view
    }

    private fun getSpinnerEnum() {
        arguments?.getParcelableArrayList<DialogSpinnerModel>(INTENT_EXTRA_SPINNER_ENUM)?.let {
            spinnerList = it
            dialogSpinnerEnum = DialogSpinnerEnum.CURRENTY
        } ?: run {
            dialogSpinnerEnum = arguments?.getSerializable(INTENT_EXTRA_SPINNER_ENUM) as DialogSpinnerEnum
        }
    }

    private fun setSearchVisibility() {
        if (dialogSpinnerEnum.showSearchBar) {
            containerSearch.visibility = View.VISIBLE
        } else {
            containerSearch.visibility = View.GONE
        }
    }

    private fun findViews(view: View) {
        recyclerView = view.findViewById(R.id.dialog_list)
        editText = view.findViewById(R.id.dialog_search_edittext)
        buttonClear = view.findViewById(R.id.clear_search)
        containerSearch = view.findViewById(R.id.container_search)
        dialogSpinnerTitle = view.findViewById(R.id.dialog_spinner_title)
        emptySearch = view.findViewById(R.id.empty_search)
    }

    private fun setListeners() {
        buttonClear.setOnClickListener { editText.setText("") }
    }

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        setStyle()
        val dialog = super.onCreateDialog(savedInstanceState)
        dialog.window?.requestFeature(Window.FEATURE_NO_TITLE)
        return dialog
    }

    private fun setStyle() {
        setStyle(STYLE_NORMAL, R.style.DialogFullScreen)
    }

    private fun setTexts() {
        editText.hint = getString(dialogSpinnerEnum.searchHint)
        dialogSpinnerTitle?.text = getString(dialogSpinnerEnum.title)
    }

    private fun setTextWatcher() {
        editText.addTextChangedListener(DialogSpinnerTextWatcher(spinnerList, dialogSpinnerAdapter, this))
    }

    private fun getSpinnerList() {
        arguments?.getParcelableArrayList<DialogSpinnerModel>(INTENT_EXTRA_SPINNER_ENUM).let {
            if (it == null) {
                spinnerList = DialogSpinnerHelper().createSpinnerList(dialogSpinnerEnum)
            }
        }
    }

    override fun setFilteredState() {
        emptySearch?.visibility = View.GONE
        recyclerView.visibility = View.VISIBLE
    }

    override fun setEmptyState() {
        emptySearch?.visibility = View.VISIBLE
        recyclerView.visibility = View.GONE
    }

    override fun hideButtonClear() {
        buttonClear.visibility = View.GONE
    }

    override fun showButtonClear() {
        buttonClear.visibility = View.VISIBLE
    }

    override fun onDestroy() {
        super.onDestroy()
        isShowing = false
    }
}