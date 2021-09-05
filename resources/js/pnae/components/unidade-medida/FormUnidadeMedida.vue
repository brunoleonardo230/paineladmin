<template>
    <div id="form-unidade-medida">
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
										Cadastro de Unidade de Medida
									</h3>
								</div>
							</div>
						</div>
						<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
							<div class="m-portlet__body">
								<div class="form-group m-form__group row">
									<div class="col-lg-8 col-xl-8 col-md-12">
										<label>
											Unidade de medida
										</label>
										<input type="text" v-model="unidade_medida.nome" class="form-control m-input" placeholder="Quilograma">
										<span class="m-form__help">
											Digite o nome
										</span>
									</div>
                                    <div class="col-lg-4 col-xl-4 col-md-12">
										<label>
											Sigla
										</label>
										<input type="text" v-model="unidade_medida.sigla" class="form-control m-input" placeholder="KG">
										<span class="m-form__help">
											Digite a sigla
										</span>
									</div>
								</div>
							</div>
							<div class="m-portlet__foot m-portlet__foot--fit">
								<div class="m-form__actions m-form__actions">
									<button type="button" @click="salvarUnidade()" class="btn btn-primary">
										{{ btn.action }}
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
        name: 'form-unidade-medida',
        data () {
            return {
                urlBase: '',
                titulo: 'Cadastrar unidade de medida',
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
                unidade_medida : {
                    unidade_medida_id   : '',
                    nome                : '',
                    sigla               : '',
                },
            }
        },
        methods : {
            salvarUnidade : function() {
                self = this;

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/unidades-de-medidas/salvar', self.unidade_medida).then((response) => {
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
            checkEdit : function() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.unidade_medida.unidade_medida_id   = dados.unidade_medida_id;
                    this.unidade_medida.nome                = dados.nome;

                    this.titulo = 'Editar unidade de medida';

                    this.btn.action = "Salvar";
                    this.btn.icon   = "fa fa-check";
                } else {
                    this.btn.action = "Cadastrar";
                    this.btn.icon   = "fa fa-check";
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
