<template>
    <div id="edit-tipo-contato">
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
										Editar de Unidade de Medida
									</h3>
								</div>
							</div>
						</div>
						<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
							<div class="m-portlet__body">
								<div class="form-group m-form__group row">
                                    <div class="col-lg-8 col-xl-8 col-md-12">
                                        <label>
                                            Tipo de Contato
                                        </label>
                                        <input type="text" v-model="tipo_contato.nome" class="form-control m-input" placeholder="Digite o tipo de contato">
                                        <span class="m-form__help">
                                            Por favor, digite o nome
                                        </span>
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
    export default {
    	props : ['dados'],
        name: 'edit-tipo-contato',
        data () {
            return {
                urlBase: '',
                titulo: 'Editar Tipo de Contato',
                formRequest : '',
                form_errors: {},
                tipo_contato : {
                    tipo_contato_id   : '',
                    nome              : '',
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
                        return self.$http.post(urlBase+'/pnae/tipos-de-contato/salvar', self.tipo_contato).then((response) => {
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
            checkEdit : function() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.tipo_contato.tipo_contato_id   = dados.tipo_contato_id;
                    this.tipo_contato.nome              = dados.nome;
                }
            },
        },
        mounted () {
            this.checkEdit();
        },
    };
</script>

<style scoped>
</style>
