<template>
    <div id="form-usuario">
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
						<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
							<div class="m-portlet__body">
								<div class="form-group m-form__group row">
									<div class="col-lg-6 col-xl-6 col-md-6">
										<label>
											Usuário
										</label>
										<input type="text" v-model="usuario.name" class="form-control m-input" placeholder="Digite o nome">
										<span class="m-form__help">
											Por favor, digite o nome
										</span>
									</div>
                                    <div class="col-lg-6 col-xl-6 col-md-6">
                                        <label>
                                            Email
                                        </label>
                                        <input type="email" v-model="usuario.email" class="form-control m-input" placeholder="Digite o email">
                                        <span class="m-form__help">
                                            Por favor, digite o email
                                        </span>
                                    </div>
								</div>
							</div>
                            <div class="m-portlet__body">
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-6 col-xl-6 col-md-6">
                                        <label>
                                            Senha
                                        </label>
                                        <input type="password" v-model="usuario.password" class="form-control m-input" placeholder="Digite a senha">
                                        <span class="m-form__help">
                                            Por favor, digite a senha
                                        </span>
                                    </div>
                                    <div class="col-lg-6 col-xl-6 col-md-6">
                                        <label>
                                            Senha de Confirmação
                                        </label>
                                        <input type="password" v-model="usuario.password_confirmation" class="form-control m-input" placeholder="Digite a senha de confirmação">
                                        <span class="m-form__help">
                                            Por favor, digite a senha de confirmação
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
        name: 'form-usuario',
        data () {
            return {
                urlBase: '',
                titulo: 'Cadastrar Usuário',
                formRequest : '',
                form_errors: {},
                usuario : {
                    id : '',
                    name : '',
                    email : '',
                    password : '',
                    password_confirmation : '',
                },
            }
        },
        methods : {
            salvar : function() {
                self = this;

                Swal({
                    title: this.titulo + '?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase+'usuario/salvar', self.usuario).then((response) => {
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
