package com.btg.convertercurrency.features.util

import android.graphics.drawable.Drawable
import android.widget.EditText
import android.widget.ImageView
import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import br.com.concrete.canarinho.watcher.MascaraNumericaTextWatcher
import kotlin.String as String1

//object ImageBinding {
//    @JvmStatic
//    @BindingAdapter("app:imageUrl")
//    fun setImageUrl(imageView: ImageView, url: String1?) {
//        if (url != null && url.isNotEmpty()) {
//            Glide
//                .with(imageView.context)
//                .load(url)
//                .placeholder(
//                    ContextCompat.getDrawable(
//                        imageView.context,
//                        R.drawable.ic_placeholder_news
//                    )
//                )
//                .centerInside()
//                .error(R.drawable.ic_placeholder_news)
//                .into(imageView)
//        }
//    }
//}

object SetErrorBinding {
    @JvmStatic
    @BindingAdapter(value = ["app:setErrorMensage", "app:idView"], requireAll = false)
    fun setErrorMensage(edi: EditText, setErrorMensage: String1 = "", idView: Int = 0) {
        if (edi.id == idView) {
            edi.error = setErrorMensage
        }
    }
}

object RecyclerViewBinding {

    interface BindableAdapter<T> {
        fun setData(data: T?)
    }

    @BindingAdapter("app:recycle_data")
    @JvmStatic
    fun <T> setRecyclerViewProperties(recyclerView: RecyclerView, data: T?) {
        if (recyclerView.adapter is BindableAdapter<*>) {
            (recyclerView.adapter as BindableAdapter<T?>).setData(data)
        }
    }
}

object RecyclerViewRefreshBinding {
    @BindingAdapter("app:recycle_refresh")
    @JvmStatic
    fun setRecyclerViewItem(recyclerView: RecyclerView, position: Int) {
        recyclerView.adapter?.notifyItemChanged(position)
    }
}

object RecyclerViewTextFilterItemBinding {

    interface BindableTextFilterAdapter {
        fun setFilterText(text: String1)
    }

    @BindingAdapter("app:recycle_text_filter")
    @JvmStatic
    fun setRecyclerViewItem(recyclerView: RecyclerView, text: String1) {
        if (recyclerView.adapter is BindableTextFilterAdapter) {
            (recyclerView.adapter as BindableTextFilterAdapter).setFilterText(text)
        }
    }
}

object ImageButtonDrawableBinding {
    @JvmStatic
    @BindingAdapter("setImageDrawable")
    fun setImageDrawable(imageView: ImageView, imageDrawable: Drawable) {
        imageView.setImageDrawable(imageDrawable)
    }
}

object AddMaskEditTextBinding {
    @JvmStatic
    @BindingAdapter("app:type_formater")
    fun setImageDrawable(editText: EditText, typeFormater : kotlin.String) {

        when(typeFormater){
            "data" ->{
                editText.addTextChangedListener( MascaraNumericaTextWatcher("##/##/####"))
            }
        }
    }
}
