using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    // EL UI.SelectionFields SIRVE PARA HACER CAMPOS DE SELECCION PARA LA APP
    UI.SelectionFields: [
        ToCategory,
        ToCurrency,
        StockAvailability
    ],

    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Label: 'ImageUrl',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: 'PoductName',
            Value: PoductName,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Description',
            Value: Description,
        },
        // VA A LA PAR CON LA LINEA 343 HAY QUE AREGLAR GENERA ERROR EN LA INTEFACE USUARIO 
        // {
        //     $Type : 'UI.DataFieldForAnnotation',
        //     Label : 'Supplier_Id',
        //     Target: 'Supplier_Id/@Communication.Contact'
        // },

        {
            $Type: 'UI.DataField',
            Label: 'ReleaseDate',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: 'DiscontinuedDate',
            Value: DiscontinuedDate,
        },
        {
            Label      : 'StockAvailability',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Rating',
            Value: Rating,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Price',
            Value: Price,
        },
    ]
);

annotate service.Products with {
    SalesData @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'SalesData',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: SalesData_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DeliveryDate',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Revenue',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'CurrencyKey',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'DeliveryMonth',
            },
        ],
    }
};

annotate service.Products with {
    Reviews @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Reviews',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Reviews_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Rating',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Comment',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'createdAt',
            },
        ],
    }
};
// ESTE SIRVE PARA AGRUPAR CADA PRODUCTO Y MOSTRAR A INFO DE CADA UNO CUANO LO SELECCIONE EN LA INTERFACE U
annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'PoductName',
                Value: PoductName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: Description,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ImageUrl',
                Value: ImageUrl,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ReleaseDate',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantity',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToUnitOfMeasure',
                Value: ToUnitOfMeasure,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCurrency',
                Value: ToCurrency,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCategory',
                Value: ToCategory,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToDimensionUnit_Id',
                Value: ToDimensionUnit_Id,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Supplier_Id',
                Value: Supplier_Id,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Rating',
                Value: Rating,
            },
            {
                $Type: 'UI.DataField',
                Label: 'StockAvailability',
                Value: StockAvailability,
            },
        ],
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    }, ]
);

/**
 *  SIRVE PARA VER LAS Imageurl
 */
annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};


/**
 * ANNOTATIONS FOR SH
 */
annotate service.Products with {
    //Category
    ToCategory        @(Common: {
        Text     : {
            $value                : ToCategory,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //Currency
    ToCurrency        @(Common: {
        ValueListWithFixedValues: false,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });

    //StockAvailability
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'ID'
            }, ]
        },
    });


};

/**
 * Annotations for VH_Categories Entity
 */
annotate service.VH_Categories with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly,
        }, }
    );
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for VH_Currencies Entity
 */
annotate service.VH_Currencies with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for StockAvailability Entity
 */
annotate service.StockAvailability with {
    ID @(Common: {Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextOnly,
    }, })

};

/**
 * Annotations for VH_UnitOfMeasure Entity
 */
annotate service.VH_UnitOfMeasure with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};


/**
 * Annotations for VH_DimensionUnits Entity
 */
annotate service.VH_DimensionUnits with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for Supplier_Id Entity
 */
 //ME GENERA UN ERROR POR EL SUPPLIER_ID HAY QUE AREGLARLO ESTO ES PARA GENERAR OTRO CAMPO CON LA INFI DEL SUPPLIER

// annotate service.Supplier_Id with @(Communication: {Contact: {
//     $Type: 'Communication.ContactType',
//     fn   : Name,
//     role : 'Supplier_Id',
//     photo: 'sap-icon://Supplier_Id'

// }, });
