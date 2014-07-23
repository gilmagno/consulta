use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type  => 'Text',
            name  => 'username',
            label => 'Login',
            constraints => ['Required'],
            attrs => {
                class => 'form-control',
            },
        },

        {
            type  => 'Password',
            name  => 'password',
            label => 'Senha',
            constraints => ['Required'],
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
