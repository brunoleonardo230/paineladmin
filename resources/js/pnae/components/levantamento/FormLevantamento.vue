<template>
    <div id="form-levantamento">
        <div class="m-content">
			<div class="row">
				<div class="col-lg-12">
					<div class="m-portlet">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <span class="m-portlet__head-icon m--hide">
                                        <i class="la la-gear"></i>
                                    </span>
                                    <h3 class="m-portlet__head-text">
                                        {{ titulo }}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <form class="m-form m-form--fit">
                            <div class="m-portlet__body">
                                <div class="m-form__section m-form__section--first">
                                    <div class="m-form__heading">
                                        <h3 class="m-form__heading-title">
                                            1. Entidade Executora:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-6 col-xl-6 col-md-12">
                                            <label>
                                                Entidade Executora
                                            </label>
                                            <select class="form-control m-input" id="entidade_id" v-model="entidade_id" name="entidade_id" @change="getUnidadesOperacionais">
                                                <option value="" selected>Selecione a Entidade Executora</option>
                                                <option v-for="entidade in entidades" :value="entidade.entidade_id">
                                                    {{ entidade.nome }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione o banco
                                            </span>
                                        </div>
                                        <div class="col-lg-6 col-xl-6 col-md-12">
                                            <label>
                                                Unidade Operacional
                                            </label>
                                            <select class="form-control m-input" id="unidade_operacional_id" v-model="levantamento.unidade_operacional_id" name="unidade_operacional_id">
                                                <option value="" selected>Selecione a Unidade Operacional</option>
                                                <option v-for="unidade_operacional in unidades_operacionais" :value="unidade_operacional.unidade_operacional_id">
                                                    {{ unidade_operacional.sigla }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione a unidade operacional
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="m-form__seperator m-form__seperator--dashed"></div>
                                <div class="m-form__section m-form__section">
                                    <div class="m-form__heading">
                                        <h3 class="m-form__heading-title">
                                            2. Técnico Responsável:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-10 col-xl-10 col-md-12">
                                            <label>
                                                Técnico Responsável
                                            </label>
                                            <select class="form-control m-input" id="tecnico_id" v-model="levantamento.tecnico_id" name="tecnico_id">
                                                <option value="" selected>Selecione o Técnico Responsável</option>
                                                <option v-for="tecnico in tecnicos" :value="tecnico.tecnico_id">
                                                    {{ tecnico.cpf | maskCpfCnpj }} - {{ tecnico.nome }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione o técnico responsável
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <endereco v-model="levantamento.endereco" titulo="3. Local de Realização da Entrevista"></endereco>

                                <div class="m-form__seperator m-form__seperator--dashed"></div>
                                <div class="m-form__section m-form__section">
                                    <div class="m-form__heading">
                                        <h3 class="m-form__heading-title">
                                            4. Agricultor/Fornecedor:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-10 col-xl-10 col-md-12">
                                            <label>
                                                Agricultor/Fornecedor
                                            </label>
                                            <select class="form-control m-input" id="fornecedor_id" v-model="levantamento.fornecedor_id" name="fornecedor_id">
                                                <option value="" selected>Selecione o Agricultor/Fornecedor</option>
                                                <option v-for="fornecedor in fornecedores" :value="fornecedor.fornecedor_id">
                                                    {{ fornecedor.cpf_cnpj }} - {{ fornecedor.nome }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione o agricultor/fornecedor
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="m-form__seperator m-form__seperator--dashed"></div>
                                <div class="m-form__section m-form__section">
                                    <div class="m-form__heading">
                                        <h3 class="m-form__heading-title">
                                            5. Projeções:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-md-12">
                                            <!-- Button trigger modal -->
                                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                                                Add projeções
                                            </button>
                                        </div>
                                    </div>
                                    <!-- Modal -->
                                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="exampleModalLabel">Projeção</h5>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="form-group row">
                                                        <div class="col-lg-12 col-xl-12 col-md-12">
                                                            <label>
                                                                Produto
                                                            </label>
                                                            <select class="form-control m-input" id="produto_id" v-model="projecao_aux.produto" name="produto_id">
                                                                <option value="" selected>Selecione o Produto</option>
                                                                <option v-for="produto in produtos" :value="produto">
                                                                    {{ produto.produto }}
                                                                </option>
                                                            </select>
                                                            <span class="m-form__help">
                                                                Por favor, selecione o produto
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div class="form-group row">
                                                        <div class="col-lg-6 col-xl-6 col-md-12">
                                                            <label>
                                                                Mês
                                                            </label>
                                                            <select class="form-control m-input" id="mes" v-model="projecao_mensal_aux.mes_referencia" name="mes">
                                                                <option value="" selected>Selecione o Mês</option>
                                                                <option v-for="mes in meses" :value="mes">
                                                                    {{ mes.nome }}
                                                                </option>
                                                            </select>
                                                            <span class="m-form__help">
                                                                Por favor, selecione o mês
                                                            </span>
                                                        </div>
                                                        <div class="col-lg-4 col-xl-4 col-md-12">
                                                            <label>
                                                                Quantidade
                                                            </label>
                                                            <input type="number" class="form-control m-input" v-model="projecao_mensal_aux.quantidade" placeholder="Digite a Quantidade">
                                                            <span class="m-form__help">
                                                                Por favor, digite a quantidade
                                                            </span>
                                                        </div>
                                                        <div class="col-lg-1 text-center">
                                                            <label class="">
                                                                Adicionar
                                                            </label>
                                                            <button @click="addProjecaoMensal()" type="button" class="btn btn-success">
                                                                <i class="fa fa-plus"></i> Add
                                                            </button>
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <div class="col-lg-12">
                                                            <div class="table-responsive">
                                                                <table class="table table-striped table-bordered table-hover">
                                                                    <thead>
                                                                        <tr>
                                                                            <th class="">
                                                                                #
                                                                            </th>
                                                                            <th class="">
                                                                                Mês
                                                                            </th>
                                                                            <th class="">
                                                                                Quantidade
                                                                            </th>
                                                                            <th class="text-center">
                                                                                Opções
                                                                            </th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr v-for="(projecao_mensal, key) in projecao_aux.projecao_mensal">
                                                                            <td class="align-middle">
                                                                                {{key+1}}
                                                                            </td>
                                                                            <td class="align-middle">
                                                                                {{projecao_mensal.mes_referencia.nome}}
                                                                            </td>
                                                                            <td class="align-middle">
                                                                                {{projecao_mensal.quantidade}}
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <button type="button" title="Descartar" @click="excluirProjecaoMensal(key)" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill">
                                                                                    <i class="la la-trash"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                                    <button type="button" @click="addProjecao()" class="btn btn-primary">Adicionar</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-12">
                                            <div class="table-responsive">
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th class="">
                                                                #
                                                            </th>
                                                            <th class="">
                                                                Cod. produto
                                                            </th>
                                                            <th class="">
                                                                Produto
                                                            </th>
                                                            <th class="text-center">
                                                                Opções
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr v-if="levantamento.projecao.length < 1">
                                                            <td colspan="4">
                                                                <p class="text-center">
                                                                    Adicione projeções!
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        <tr v-else v-for="(projecao, key) in levantamento.projecao">
                                                            <td class="align-middle">
                                                                {{ key + 1 }}
                                                            </td>
                                                            <td class="align-middle">
                                                                {{ projecao.produto.produto_id }}
                                                            </td>
                                                            <td class="align-middle">
                                                                {{ projecao.produto.produto }}
                                                            </td>
                                                            <td class="text-center">
                                                                <button type="button" title="Editar" @click="editar(projecao, key)" data-toggle="modal" data-target="#exampleModal" class="btn btn-info m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill">
                                                                    <i class="la la-edit"></i>
                                                                </button>
                                                                <button type="button" title="Descartar" @click="descartar(key)" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill">
                                                                    <i class="la la-trash"></i>
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="m-portlet__foot m-portlet__foot--fit">
                                <div class="m-form__actions m-form__actions">
                                    <button type="button" @click="salvar()" class="btn btn-primary">
                                        Salvar
                                    </button>
                                    <button type="reset" class="btn btn-secondary">
                                        Cancelar
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
				</div>
			</div>
		</div>
    </div>
</template>

<script>
    import Endereco from '../endereco/Endereco.vue'

    export default {
        components: { Endereco },
        name: 'form-levantamento',
        data () {
            return {
                urlBase : urlBase,
                titulo : 'Cadastro de Levantamento',
                formRequest : '',
                form_errors : {},
                levantamento : {
                    levantamento_produtivo_id : '',
                    unidade_operacional_id : '',
                    tecnico_id : '',
                    fornecedor_id : '',
                    endereco : {},
                    projecao : [],
                },
                projecao_aux : {
                    key : null,
                    projecao_id : '',
                    produto : '',
                    levantamento_produtivo_id : '',
                    projecao_mensal : [],
                },
                projecao_mensal_aux : {
                    key : null,
                    projecao_mensal_id : '',
                    quantidade : '',
                    mes_referencia : '',
                },
                entidade_id : '',
                entidades : [],
                tecnicos : [],
                fornecedores : [],
                produtos : [],
                unidades_operacionais : [],
                meses : this.retornarMeses(),
            }
        },
        methods : {
            editar(projecao, key){
                self = this;

                self.projecao_aux.key                       = key;
                self.projecao_aux.projecao_id               = projecao.projecao_id;
                self.projecao_aux.produto                   = projecao.produto;
                self.projecao_aux.levantamento_produtivo_id = projecao.levantamento_produtivo_id;
                self.projecao_aux.projecao_mensal           = projecao.projecao_mensal;
            },
            addProjecaoMensal(){
                self = this;
                let isEnter = true;

                self.projecao_aux.projecao_mensal.forEach(function(mensal, key){
                    if (mensal.mes_referencia.mes_id == self.projecao_mensal_aux.mes_referencia.mes_id) {
                        isEnter = false;
                    }
                });

                if (isEnter) {
                    if (self.projecao_mensal_aux.mes_referencia == '' || self.projecao_mensal_aux.quantidade == '') {
                        Swal({
                            type: 'error',
                            title: 'Atenção',
                            html: 'Há campos acima vazio. Por favor, preencher!',
                        });

                        return true;
                    }
                    
                    self.projecao_aux.projecao_mensal.push(self.projecao_mensal_aux);

                    self.projecao_mensal_aux = {
                        key : null,
                        projecao_mensal_id : '',
                        quantidade : '',
                        mes_referencia : '',
                    };
                }else {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Esse mês já foi adicionado!',
                    });
                }
            },
            excluirProjecaoMensal(key){
                self = this;
                self.projecao_aux.projecao_mensal.splice(key, 1);
            },
            addProjecao() {
                self = this;
                var comp = false;

                if (!self.validarCamposProjecao()) {
                    return;
                }

                if (self.projecao_aux.key == null) {
                    if (self.levantamento.projecao.length == 0) {
                        self.levantamento.projecao.push(self.projecao_aux);

                        self.limparProjecao();
                    } else {
                        var indexProjecao = 0;

                        self.levantamento.projecao.forEach(function(projecao) {
                            indexProjecao++;

                            if (self.projecao_aux.produto.produto_id == projecao.produto.produto_id) {
                                Swal({
                                    type: 'error',
                                    title: 'Atenção',
                                    html: 'Produto já adicionado para o mês selecionado!',
                                });
                            } else {
                                self.levantamento.projecao.push(self.projecao_aux);
                                self.limparProjecao();
                            }
                        });
                    }
                } else {
                    self.levantamento.projecao[self.projecao_aux.key] = self.projecao_aux;
                    self.limparProjecao();
                }
            },
            validarCamposProjecao() {
                if (this.projecao_aux.produto == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Adicione o produto!',
                    });

                    return false;
                }

                if (this.projecao_aux.projecao_mensal.length == 0) {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Adicione pelo menos uma projeção mensal!',
                    });

                    return false;
                }
                return true;
            },
            limparProjecao() {
                this.projecao_aux = {
                    projecao_id : '',
                    produto_id : '',
                    levantamento_produtivo_id : '',
                    projecao_mensal : [],
                };
            },
            salvar() {
                self = this;
                let levantamento = self.trataDados();

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/levantamentos-produtivos/salvar', levantamento).then((response) => {
                            self.retorno = response.body;
                            self.formRequest = {};
                        }, response => {
                            var form = response.body;
                            self.formRequest = form.errors;
                            self.retorno = 0;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    self.loading = false;

                    if (self.retorno == 0) {
                        self.form_errors = self.mountErrors(self.formRequest);
                        var msg = self.formErros(self.formRequest);

                        return Swal({
                            type: 'error',
                            title: 'Há campos em brancos!',
                            html: msg,
                        });
                    }

                    return Swal({
                        type: self.retorno.status,
                        title: self.retorno.msg,
                    });
                }).catch(Swal.noop)
            },
            editProjecao(projecao, key) {
                self = this;
                self.projecao_aux = projecao;
                self.projecao_aux.key = key;
            },
            removeProjecao(key) {
                self = this;
                self.levantamento.projecao.splice(key, 1);
            },
            getFornecedores() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/fornecedores/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.fornecedores = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getProdutos() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/produtos/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.produtos = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getTecnicos() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/responsaveis-tecnicos/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.tecnicos = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getEntidades() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/entidades/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.entidades = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getUnidadesOperacionais() {
                self = this;
                self.loading = true;

                var url = urlBase + '/pnae/unidades-operacionais/recuperar-por-entidade/' + self.entidade_id;

                self.$http.get(url).then((response) => {
                    self.unidades_operacionais = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            trataDados() {
                self = this;
                let projecoes = [];

                self.levantamento.projecao.forEach(function(proj, key){
                    let projecaoMensal = [];
                    
                    proj.projecao_mensal.forEach(function(mes, keyMes){
                        projecaoMensal[keyMes] = {
                            projecao_mensal_id : mes.projecao_mensal_id,
                            quantidade : mes.quantidade,
                            mes_id : mes.mes_referencia.mes_id,
                        };
                    });

                    projecoes[key] = {
                        projecao_id                 : proj.projecao_id,
                        produto_id                  : proj.produto.produto_id,
                        levantamento_produtivo_id   : proj.levantamento_produtivo_id,
                        projecao_mensal             : projecaoMensal,
                    }
                });

                let levantamento = {
                    levantamento_produtivo_id   : self.levantamento.levantamento_produtivo_id,
                    unidade_operacional_id      : self.levantamento.unidade_operacional_id,
                    tecnico_id                  : self.levantamento.tecnico_id,
                    fornecedor_id               : self.levantamento.fornecedor_id,
                    endereco                    : self.levantamento.endereco,
                    projecao                    : projecoes
                }

                return levantamento;
            },
        },
        mounted () {
            this.getFornecedores();
            this.getProdutos();
            this.getTecnicos();
            this.getEntidades();
        },
    };
</script>

<style scoped>
</style>
