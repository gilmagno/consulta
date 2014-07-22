use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type  => 'Text',
            name  => 'date',
            label => 'Data',
            constraints => ['Required'],
            attrs => {
                class => 'form-control datepicker',
            },
            inflator => {
                type => 'DateTime',
                parser => {
                    strptime => '%d/%m/%Y',
                },
            },
            deflator => {
                type => 'Strftime',
                strftime => '%d/%m/%Y',
            },
        },

        {
            type        => 'Textarea',
            name        => 'text',
            label       => 'Anotações',
            constraints => ['Required'],
            attrs       => {
                class => 'form-control',
                rows => 9
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
