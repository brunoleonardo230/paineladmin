<template>
    <div id="edit-levantamento">
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
                                            <select class="form-control m-input" id="entidade_id" v-model="levantamento.entidade_id" name="entidade_id">
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
                                                    {{ tecnico.cpf }} - {{ tecnico.nome }}
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
                                                <option v-for="fornecedor in fornecedores" :value="tecnico.fornecedor_id">
                                                    {{ fornecedor.cpf }} - {{ fornecedor.nome }}
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
                                        <div class="col-lg-4 col-xl-4 col-md-12">
                                            <label>
                                                Produto
                                            </label>
                                            <select class="form-control m-input" id="fornecedor_id" v-model="levantamento.tecnico_id" name="fornecedor_id">
                                                <option value="" selected>Selecione o Produto</option>
                                                <option v-for="fornecedor in fornecedores" :value="tecnico.fornecedor_id">
                                                    {{ fornecedor.cpf }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione o produto
                                            </span>
                                        </div>
                                        <div class="col-lg-4 col-xl-4 col-md-12">
                                            <label>
                                                Mês
                                            </label>
                                            <select class="form-control m-input" id="fornecedor_id" v-model="levantamento.tecnico_id" name="fornecedor_id">
                                                <option value="" selected>Selecione o Mês</option>
                                                <option v-for="fornecedor in fornecedores" :value="tecnico.fornecedor_id">
                                                    {{ fornecedor.cpf }}
                                                </option>
                                            </select>
                                            <span class="m-form__help">
                                                Por favor, selecione o mês
                                            </span>
                                        </div>
                                        <div class="col-lg-3 col-xl-3 col-md-12">
                                            <label>
                                                Quantidade
                                            </label>
                                            <input type="text" class="form-control m-input" v-model="levantamento.tecnico_id" placeholder="Digite a Quantidade">
                                            <span class="m-form__help">
                                                Por favor, digite a quantidade
                                            </span>
                                        </div>
                                        <div class="col-lg-1 text-center">
                                            <label class="">
                                                Adicionar
                                            </label>
                                            <button type="button" class="btn btn-success"">
                                                <i class="fa fa-plus"></i>
                                            </button>
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
    import Conta from '../conta/Conta.vue'
    import Contatos from '../contato/Contatos.vue'
    import Endereco from '../endereco/Endereco.vue'

    export default {
        components: { Endereco, Contatos, Conta },
        name: 'edit-levantamento',
        data () {
            return {
                urlBase: urlBase,
                titulo: 'Editar Levantamento',
                formRequest : '',
                form_errors: {},
                levantamento: {
                    levantamento_produtivo_id : '',
                    entidade_id : '',
                    tecnico_id : '',
                    fornecedor_id : '',
                    endereco : {},
                    projecoes : [],
                },
            }
        },
        methods : {
            salvar : function() {
                self = this;
                
                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/levantamentos-produtivos/salvar', self.levantamento).then((response) => {
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
            }
        },
    };
</script>

<style scoped>
</style>
