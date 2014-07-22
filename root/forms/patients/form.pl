use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type        => 'Text',
            name        => 'name',
            label       => "Nome",
            constraints => ['Required'],
            attrs       => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'rg',
            label => 'RG',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'cpf',
            label => 'CPF',
            attrs => {
                class => 'form-control',
            },
        },


        {
            type  => 'Text',
            name  => 'address_street_etc',
            label => 'Logradouro, número, complemento',
            attrs => {
                class => 'form-control',
                placeholder => 'Exemplo: Avenida Santos Dummont, 30, ap. 202',
            },
        },

        {
            type  => 'Text',
            name  => 'address_district',
            label => 'Bairro',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'address_zip_code',
            label => 'CEP',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'phone',
            label => 'Telefone',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'phone2',
            label => 'Telefone Adicional',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'email',
            label => 'Email',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'email2',
            label => 'Email Adicional',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Text',
            name  => 'username',
            label => 'Login',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Password',
            name  => 'password',
            label => 'Senha',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Submit',
            value => 'Enviar',
            attrs => {
                class => 'btn btn-default',
            },
        },
    ],
}

