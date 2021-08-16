package com.br.cambio.customviews

class DialogSpinnerHelper {

    /**
     * Cria uma lista para ser usada no DialogSpinner a partir de um DialogSpinnerEnum.
     *
     * @param spinnerEnum enum com a lista selecionada pelo spinner para ser populada na lista do
     * dialog.
     *
     * @return lista pronta para ser utilizada pelo Adapter da DialogSpinner.
     */
    fun createSpinnerList(spinnerEnum: DialogSpinnerEnum): List<DialogSpinnerModel> {
        val spinnerListJson = JsonUtil.getInstance().convertJsonFile(
                clazz = Array<DialogSpinnerModel>::class.java,
                filePath = spinnerEnum.jsonPath
        )

        return spinnerListJson.toList()
    }

    /**
     * Filtra a lista do DialogSpinner, retornando apenas os itens que contém o texto passado
     * pela pesquisa.
     *
     * @param spinnerList lista com todos os itens do campo selecionado.
     * @param charSequence texto contendo a palavra chave para filtrar a lista em questão.
     *
     * @return lista filtrada que atualizará o RecyclerView da DialogSpinner.
     */
    fun filterList(spinnerList: List<DialogSpinnerModel>,
                   charSequence: CharSequence?): List<DialogSpinnerModel> {
        return spinnerList.filter {
                it.codigo.contains(charSequence.toString(), true) ||
                it.nome.contains(charSequence.toString(), true)
        }.toList()
    }


}