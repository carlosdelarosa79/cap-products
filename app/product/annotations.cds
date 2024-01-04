/**
 * En el fichero “annotations.cds” disponemos de anotaciones generadas por
   el wizard con la creación del proyecto Fiori Elements
 */

using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    /**
     * En el fichero “annotations.cds” implementamos la anotación que 
        deshabilita la opción del botón “Delete”
     */
     Capabilities : {DeleteRestrictions : {Deletable : false}},
    /**
     * En el fichero de “annotations.cds” agregamos la anotación UI.HeaderInfo
    para mostrar la información de cabecera
     */
    UI.HeaderInfo     : {
        TypeName      : 'Product',
        TypeNamePlural: 'Products',
        ImageUrl      : ImageUrl,
        Title         : {Value: PoductName},
        Description   : {Value: Description}
    },
    /**
     * En el fichero “annotations.cds”, del proyecto Fiori Elements, agregamos los
         campos de selección de la categoría, moneda y la disponibilidad del stock.
     */
    UI.SelectionFields: [
        ToCategory,
        ToCurrency,
        StockAvailability
    ],
    /**
     * Agregamos los campos que forman en listado de los productos
     * en esta aplicación se visualizan las columnas que forman el listado
     */
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
        /**
         * Para mostrar la información del contacto de comunicación, agregamos la
            columna del proveedor en la colección de UI.LineItem, indicando en el
            Target la columna de proyección, junto con el @Communication.Contact.
            Al final del fichero agregamos la Annotations for Supplier_Id Entity (anotación para la entidad Supplier)
            realizando la implementación necesaria para la anotación @Communication.Contact.
         */
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
        /**
         * En el fichero “annotations.cds” agregamos la propiedad “Criticality” para el objeto StockAvailability.
         * En la aplicación, visualizamos la criticidad para la columna “Stock Availability”
         */
        {
            Label      : 'StockAvailability',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },
        /**
         * Modificamos las propiedades de la columna “Rating” que está agrupada en
            la anotación “LineItem”, para indicar que la referencia del “DataPoint” a
            través de la propiedad “Target”.
            Modificamos la misma propiedad “Rating” agrupada en la anotación
            “FieldGroup” para indicar la misma referencia al “DataPoint”
            Al final del fichero realizamos la implementación del ”DataPoint”, con el
            mismo identificador “AverageRating” indicado en la propiedad Target de las
            anteriores modificaciones.
         */
        {
            //$Type: 'UI.DataField',
            Label : 'Rating',
            //Value: Rating,
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'
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

/**
 * En la vista de los detalles, en cuanto se navega pulsando sobre un registro,
    se puede observar la información con los campos que se muestran por la
    anotación UI.FieldGroup
 */
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
                //$Type: 'UI.DataField',
                Label : 'Rating',
                //Value: Rating,
                $Type : 'UI.DataFieldForAnnotation',
                Target: '@UI.DataPoint#AverageRating'
            },
            {
                $Type: 'UI.DataField',
                Label: 'StockAvailability',
                Value: StockAvailability,
            },
        ],
    },
    /**
     * En la página de los detalles del producto agregamos una nueva pestaña en
        la anotación “Facets”, haciendo referencia a los mismos elementos
        agrupados en “FieldGroup” y esto genera una copia
     */
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'General Information Copia para ver que hace el UI.Facets',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);

/**
 *  En el fichero “annotations.cds” agregamos la anotación UI.IsImageURL para
    la columna ImageUrl.
    En la carpeta “/producto/webapp/” creamos una nueva carpeta llamada
    “assets”, donde subimos las imágenes para cada uno de los productos
 */
annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};

/**
 * Data Point for AverageRaiting
 */
annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Rating,
    Title        : 'Rating',
    TargetValue  : 5,
    Visualization: #Rating
});


/**
 * ANNOTATIONS FOR SH
 */
/**
 * En el fichero “annotations.cds” agregamos la lógica para las
   correspondientes ayudas de búsqueda: Category - Currency - StockAvailability, y abajo terminando se realiza para cada uno
   Annotations for VH_Categories Entity - Annotations for VH_Currencies Entity - Annotations for StockAvailability Entity
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
