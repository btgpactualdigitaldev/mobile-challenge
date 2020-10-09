package br.com.cabral.pedro.conversaodemoeda.dialog

import android.content.Context
import android.content.DialogInterface
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.ViewUtils

class DialogUtils {

    companion object{

        fun DialogErro(context: Context,
                       titulo: String? = null,
                       mensagem: String? = null,
                       onClickListener: DialogInterface.OnClickListener) : AlertDialog {

            val builder = AlertDialog.Builder(context)
            builder.setTitle(titulo)
            builder.setMessage(mensagem)
            builder.setPositiveButton("OK", onClickListener)

            val dialog: AlertDialog = builder.create()
            dialog.show()

            return dialog
        }

    }

}
