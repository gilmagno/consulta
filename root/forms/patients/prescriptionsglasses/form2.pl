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
            type => 'Fieldset',
            legend => 'Esférico',
            elements => [
                {
                    type => 'Text',
                    name => 'esferico_oe',
                    label => ' OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
                    },
                },
                {
                    type => 'Text',
                    name => 'esferico_od',
                    label => ' OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
                    },
                },
            ],
        },

        {
            type => 'Fieldset',
            legend => 'Cilíndrico',
            elements => [
                {
                    type => 'Text',
                    name => 'esferico_oe',
                    label => ' OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
                    },
                },
                {
                    type => 'Text',
                    name => 'esferico_od',
                    label => ' OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
                    },
                },
            ],
        },

        {
            type => 'Fieldset',
            legend => 'Eixo',
            elements => [
                {
                    type => 'Text',
                    name => 'esferico_oe',
                    label => ' OE',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
                    },
                },
                {
                    type => 'Text',
                    name => 'esferico_od',
                    label => ' OD',
                    attrs => {
                        class => 'form-control',
                    },
                    container_attributes => {
                        class => 'form-group-indented',
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
                                    name => 'esferico_oe',
                                    label => 'Esférico OE',
                                    constraints => ['Required'],
                                    attrs => {
                                        class => 'form-control',
                                    },
                                    container_attributes => {
                                        class => 'col-lg-6 col-md-6 col-sm-6',
                                    },
                                },

                                {
                                    type => 'Text',
                                    name => 'esferico_od',
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
                                    name => 'esferico_oe',
                                    label => 'Cilíndrico OE',
                                    constraints => ['Required'],
                                    attrs => {
                                        class => 'form-control',
                                    },
                                    container_attributes => {
                                        class => 'col-lg-6 col-md-6 col-sm-6',
                                    },
                                },

                                {
                                    type => 'Text',
                                    name => 'esferico_od',
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
            type => 'Fieldset',
            legend => 'DP',
            elements => [

                {
                    type => 'Block',
                    attrs => { class => 'row form-group-indented' },
                    elements => [

                                {
                                    type => 'Text',
                                    name => 'esferico_oe',
                                    label => 'DP OE',
                                    constraints => ['Required'],
                                    attrs => {
                                        class => 'form-control',
                                    },
                                    container_attributes => {
                                        class => 'col-lg-6 col-md-6 col-sm-6',
                                    },
                                },

                                {
                                    type => 'Text',
                                    name => 'esferico_od',
                                    label => 'DP OD',
                                    attrs => {
                                        class => 'form-control',
                                    },
                                    container_attributes => {
                                        class => ' col-lg-6 col-md-6 col-sm-6',
                                    },
                                },

                    ],
                },

            ],
        },

        {
            type        => 'Text',
            name        => 'text',
            label       => 'Adição',
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
