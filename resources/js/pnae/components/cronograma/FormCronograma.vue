<template>
    <div id="form-cronograma">
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
										Cadastro de Cronograma
									</h3>
								</div>
							</div>
						</div>
						<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
							<div class="m-portlet__body">
								<div class="form-group m-form__group row">
									<div class="col-lg-6 col-xl-6 col-md-12">
										<label>
											Nome
										</label>
										<input type="text" v-model="cronograma.frequencia" class="form-control m-input" placeholder="Semanal">
										<span class="m-form__help">
											Digite o nome
										</span>
									</div>
                                    <div class="col-lg-6 col-xl-6 col-md-12">
                                        <label>
                                            Número de dias
                                        </label>
                                        <input type="text" v-model="cronograma.qtde_dias" class="form-control m-input" placeholder="30">
                                        <span class="m-form__help">
                                            Digite o número de dias
                                        </span>
                                    </div>
								</div>
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-6 col-xl-6 col-md-12">
                                        <label>
                                            Descrição
                                        </label>
                                        <textarea v-model="cronograma.descricao" class="form-control m-input" placeholder="Descrição">
                                        </textarea>
                                        <span class="m-form__help">
                                            Digite a Descrição
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
        name: 'form-cronograma',
        data () {
            return {
                urlBase: '',
                titulo: 'Cadastrar cronograma',
                formRequest : '',
                form_errors: {},
                cronograma : {
                    cronograma_entrega_id   : '',
                    frequencia              : '',
                    descricao               : '',
                    qtde_dias               : '',
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
                        return self.$http.post(urlBase + '/pnae/cronogramas-de-entrega/salvar', self.cronograma).then((response) => {
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
        },
    };
</script>

<style scoped>
</style>
