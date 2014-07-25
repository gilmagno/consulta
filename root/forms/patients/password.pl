use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type  => 'Hidden',
            name  => 'id'
        },

        {
            type  => 'Text',
            name  => 'username',
            label => 'Login',
            constraints => [
                'Required',
                { type      => 'DBIC::Unique',
                  resultset => 'User',
                  message   => 'Login já em uso',
                  id_field  => 'id' },
            ],
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Password',
            name  => 'password',
            label => 'Senha',
            constraints => [
                'Required',
                { type    => 'Equal',
                  others  => 'password_confirmation',
                  message => 'As senhas devem ser iguais' },
            ],
            attrs => {
                class => 'form-control',
                autocomplete => 'off',
            },
        },

        {
            type  => 'Password',
            name  => 'password_confirmation',
            label => 'Senha (novamente)',
            constraints => ['Required'],
            attrs => {
                class => 'form-control',
                autocomplete => 'off',
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
