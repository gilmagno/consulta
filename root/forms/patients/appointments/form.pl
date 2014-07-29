use utf8;

{
    languages => ['pt-br'],

    auto_container_class => 'form-group',

    elements => [
        {
            type        => 'Select',
            name        => 'doctor_id',
            label       => 'Médico',
            constraints => ['Required'],
            attrs       => {
                class => 'form-control',
            },
        },

        {
            type        => 'Text',
            name        => 'date_time',
            label       => 'Data e Hora',
            constraints => ['Required'],
            attrs       => {
                class => 'form-control datetimepicker',
            },
            inflator => {
                type   => 'DateTime',
                parser => {
                    strptime => '%d/%m/%Y %H:%M',
                },
            },
            deflator => {
                type     => 'Strftime',
                strftime => '%d/%m/%Y %H:%M',
            },
        },

        {
            type => 'Select',
            name => 'status',
            label => 'Status',
            attrs => {
                class => 'form-control',
            },
            options => [
                ['Marcado', 'Marcado'],
                ['Confirmado', 'Confirmado'],
                ['Inconcluso', 'Inconcluso'],
                ['Concluído', 'Concluído'],
            ],
        },

        {
            type        => 'Textarea',
            name        => 'text',
            label       => 'Anotações',
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
