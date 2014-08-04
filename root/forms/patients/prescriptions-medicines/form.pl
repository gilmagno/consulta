use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type        => 'Text',
            name        => 'date',
            label       => 'Data',
            constraints => ['Required'],
            attrs       => {
                class => 'form-control datepicker',
            },
            inflator => {
                type   => 'DateTime',
                parser => {
                    strptime => '%d/%m/%Y',
                },
            },
            deflator => {
                type     => 'Strftime',
                strftime => '%d/%m/%Y',
            },
        },

        {
            type => 'Select',
            name => 'use_method',
            label => 'Modo de Uso',
            attrs => {
                class => 'form-control',
            },
            options => [
                ['Uso Tópico',  'Uso Tópico'],
                ['Uso Oral',    'Uso Oral'],
                ['Uso Ocular',  'Uso Ocular'],
                ['Uso Interno', 'Uso Interno'],
                ['Uso Externo', 'Uso Externo'],
                ['Uso Local',   'Uso Local'],
            ],
        },

        {
            type => 'Select',
            name => 'medicine_id',
            label => 'Medicamento',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type => 'Text',
            name => 'quantity',
            label => 'Quantidade',
            attrs => {
                class => 'form-control',
            },
        },

        {
            type        => 'Text',
            name        => 'unity',
            label       => 'Unidade',
            attrs       => {
                class => 'form-control',
            },
        },

        {
            type        => 'Textarea',
            name        => 'text',
            label       => 'Anotações',
            constraints => ['Required'],
            attrs       => {
                class => 'form-control',
                rows  => 9
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
