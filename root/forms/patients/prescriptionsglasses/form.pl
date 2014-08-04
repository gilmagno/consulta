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
            type => 'Block',
            attrs => { class => 'row' },
            elements => [
                {
                    type => 'Text',
                    name => 'spherical_left',
                    label => 'Esférico OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'col-lg-6 col-md-6 col-sm-6',
                    },
                },

                {
                    type => 'Text',
                    name => 'spherical_right',
                    label => 'Esférico OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => ' col-lg-6 col-md-6 col-sm-6',
                    },
                },
               ],
        },

        {
            type => 'Block',
            attrs => { class => 'row' },
            elements => [
                {
                    type => 'Text',
                    name => 'cilindrical_left',
                    label => 'Cilíndrico OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'col-lg-6 col-md-6 col-sm-6',
                    },
                },

                {
                    type => 'Text',
                    name => 'cilindrical_right',
                    label => 'Cilíndrico OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => ' col-lg-6 col-md-6 col-sm-6',
                    },
                },
               ],
        },

        {
            type => 'Block',
            attrs => { class => 'row' },
            elements => [
                {
                    type => 'Text',
                    name => 'axis_left',
                    label => 'Eixo OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'col-lg-6 col-md-6 col-sm-6',
                    },
                },

                {
                    type => 'Text',
                    name => 'axis_right',
                    label => 'Eixo OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => ' col-lg-6 col-md-6 col-sm-6',
                    },
                },
               ],
        },

        {
            type => 'Block',
            attrs => { class => 'row' },
            elements => [
                {
                    type => 'Text',
                    name => 'npd_left',
                    label => 'DNP OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'col-lg-6 col-md-6 col-sm-6',
                    },
                },

                {
                    type => 'Text',
                    name => 'npd_right',
                    label => 'DNP OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => ' col-lg-6 col-md-6 col-sm-6',
                    },
                },
               ],
        },

        {
            type        => 'Text',
            name        => 'add',
            label       => 'Adição',
            attrs       => {
                class => 'form-control',
            },
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
