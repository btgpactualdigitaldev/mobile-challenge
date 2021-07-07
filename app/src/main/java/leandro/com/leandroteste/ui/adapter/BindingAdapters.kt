package leandro.com.leandroteste.ui.adapter

import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView

class BindingAdapters {
    companion object{
        @BindingAdapter("items")
        @JvmStatic
        fun setItems(recyclerView: RecyclerView, items: MutableList<Any>){
            recyclerView.adapter.let {
                if(it is AdapterItemsContract){
                    it.replaceItems(items)
                }
            }
        }
    }
}