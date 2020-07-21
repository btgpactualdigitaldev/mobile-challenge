package com.btg.converter.presentation.util.placeholder

import android.content.Context
import android.util.AttributeSet
import android.view.LayoutInflater
import android.widget.FrameLayout
import com.btg.converter.R
import com.btg.converter.databinding.LoadingPlaceholderBinding
import com.btg.converter.presentation.util.placeholder.types.Action
import com.btg.converter.presentation.util.placeholder.types.Loading
import com.btg.converter.presentation.util.placeholder.types.Message

class PlaceholderView constructor(
    context: Context,
    attrs: AttributeSet
) : FrameLayout(context, attrs) {

    private lateinit var binding: LoadingPlaceholderBinding
    private val layoutInflater by lazy { LayoutInflater.from(context) }

    fun setPlaceholder(placeholder: Placeholder?) {
        placeholder?.let { _placeholder ->
            setBaseVariables(_placeholder)
            when (_placeholder) {
                is Action -> configureActionPlaceholder(_placeholder)
                is Loading -> configureLoadingPlaceholder(_placeholder)
                is Message -> configureMessagePlaceholder(_placeholder)
            }
        }
    }

    init {
        loadBinding()
    }

    private fun loadBinding() {
        binding = LoadingPlaceholderBinding.inflate(layoutInflater, this, true)
    }

    private fun setBaseVariables(placeholder: Placeholder) {
        binding.run {
            visible = placeholder.visible
            buttonVisible = placeholder.buttonVisible
            messageVisible = placeholder.messageVisible
            progressVisible = placeholder.progressVisible
        }
    }

    private fun configureActionPlaceholder(placeholder: Action) {
        binding.run {
            actionButton.setOnClickListener { placeholder.onActionButtonClicked() }
            messageTextView.text = placeholder.message
            actionButton.text = placeholder.buttonText
        }
    }

    private fun configureMessagePlaceholder(placeholder: Message) {
        binding.messageTextView.text = placeholder.message
    }

    private fun configureLoadingPlaceholder(placeholder: Loading) {
        binding.messageTextView.text = placeholder.message ?: context.getString(R.string.app_name)
    }
}