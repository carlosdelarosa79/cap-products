namespace com.logali;

/* utilizamos una libreria, el CUID nos sirve para remplazar el tipo UUID de las entidades, MANAGED Este aspecto común nos proporciona cuatro campos de creación y
modificación que utilizaremos en la definición de las entidades */
using {
    cuid,
    managed
} from '@sap/cds/common';


type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

//  contex "el nombre" { }, podemos modularizar todos las entidades para tener mejor organizacion
context materials {
    entity Products : cuid, managed {
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        UnitOfMeasure_Id : String;
        Currency_Id      : String;
        Category_Id      : String;
        Supplier_Id      : String;
        DimensionUnit_Id : String;
        SalesData        : Association to many sales.SalesData;
        Reviews          : Association to many ProductReview;

    };

    entity Categories : cuid {
        Name : localized String;
    };

    entity StockAvailability : cuid {
        Description : localized String;
        Product     : Association to Products;
    };

    entity Currencies : cuid {
        Description : localized String;
    };

    entity UnitOfMeasures : cuid {
        Description : localized String;
    };

    entity DimensionUnits : cuid {
        Description : localized String;
    };


    entity ProductReview : cuid {
        createdAt  : DateTime;
        createdBy  : String;
        modifiedAt : String;
        modifiedby : String;
        Name       : String;
        Rating     : Integer;
        Comment    : String;
        Product_ID : UUID;
    //Product    : Association to materials.Products;
    };

    //para crear vistas de tipo proyeccion 3 formas diferentes , y aca tenemos restricciones por que no soportan los join
    entity ProProducts  as projection on Products;

    entity ProProducts2 as
        projection on Products {
            *
        };

    entity ProProducts3 as
        projection on Products {
            ReleaseDate,
            Name
        };


    // ENTIDADES AMPLIACION
    // esto nos sirve para AMPLIAR LA ENTIDAD Produts
    extend Products with {
        priceCondition     : String(2);
        priceDetermination : String(3);
    };
}

context sales {

    /* como vemos en item  tenmos una COMPOSITION
    esto es para que si el padre no existe todo se borra es la diferencia entre la COMPOSITION Y ASSOCIATION */
    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.order = $self
    };

    entity OrderItems : cuid {
        order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;
    };

    entity Suppliers : cuid, managed {
        Name    : type of materials.Products : Name;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier_Id;

    };


    entity Months : cuid {
        Description      : localized String;
        ShortDescription : localized String(3);
    };

    // son entidades de projeccion y esta entidad utiliza otra entidad ya DEFINIDA para selecionar los DATOS
    entity SelProducts  as select from materials.Products;

    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;

    entity SalesData : cuid, managed {
        DeliveryDate     : DateTime;
        Revenue          : Decimal(16, 2);
        Product_Id       : UUID;
        Currency_Id      : String;
        DeliveryMonth_Id : Association to sales.Months;
    //Product          : Association to materials.Products;

    };

}

context reports {
    entity AverageRating as
        select from logali.materials.ProductReview {
            Product_ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)
        }
        group by
            Product_ID;


    entity Products      as
        select from logali.materials.Products
        mixin {
            ToStockAvailibity : Association to logali.materials.StockAvailability
                                    on ToStockAvailibity.ID = $projection.StockAvailability;
            ToAverageRating   : Association to AverageRating
                                    on ToAverageRating.ProductId = ID;
        }
        into {
            *,
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity > 0
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,
            ToStockAvailibity
        }

}
