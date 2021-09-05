<div style="color: blue;padding: 10px;height: 10px;font-size: 20px;float: left;font-weight: bold;">

    Ambiente de 

    @if(App::environment() == 'local')
        Desenvolvimento
    @elseif(App::environment() != 'production')
        Homologação
    @endif
</div>