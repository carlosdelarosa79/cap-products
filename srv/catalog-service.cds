using {com.logali as logali} from '../db/schema';
using {com.training as training} from '../db/training';

// service CatalogService {
//     entity Products         as projection on logali.materials.Products;
//     entity Suppliers        as projection on logali.sales.Suppliers;
//     entity UnitOfMeasures   as projection on logali.materials.UnitOfMeasures;
//     entity Currency_Id      as projection on logali.materials.Currencies;
//     entity DimensionUnit_Id as projection on logali.materials.DimensionUnits;
//     entity Category_Id      as projection on logali.materials.Categories;
//     entity SalesData        as projection on logali.sales.SalesData;
//     entity Reviews          as projection on logali.materials.ProductReview;
//     entity UnitOfMeasure_Id as projection on logali.materials.UnitOfMeasures;
//     entity Months           as projection on logali.sales.Months;
//     entity Order            as projection on logali.sales.Orders;
//     entity OrderItem        as projection on logali.sales.OrderItems;
// }

/* tener en cuenta que para que se vea este cambio debe cambiar el nombre a los archivos que estan en la carpeta data
con esta ya no exponemos todo el servicio odata
si no solo lo que nosotros queramos exponer
cuando agregamos el @mandatory es para que ese campo se debe llenar obligatoriamente  */

define service CatalogService {
    entity Products          as
        select from logali.reports.Products {
            ID,
            Name             as PoductName      @mandatory,
            Description                         @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                               @mandatory,
            Height,
            Width,
            Depth,
            Quantity                            @(
                mandatory,
                assert.range: [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure_Id as ToUnitOfMeasure @mandatory,
            Currency_Id      as ToCurrency      @mandatory,
            Category_Id      as ToCategory      @mandatory,
            DimensionUnit_Id as ToDimensionUnit_Id,
            SalesData,
            Supplier_Id,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailibity
        };

    @readonly
    entity Suppliers         as
        select from logali.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
        // Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency_Id                  as CurrencyKey,
            DeliveryMonth_Id             as DeliveryMonthId,
            DeliveryMonth_Id.Description as DeliveryMonth,
        //Product                      as ToProduct
        };

    entity StockAvailability as
        select from logali.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from logali.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select from logali.materials.DimensionUnits {
            ID          as Code,
            Description as Text
        };

}

define service MyService {

    entity SuppliersProduct  as
        select from logali.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Products.Supplier_Id
        };

    entity SuppliersToSales  as select ProProducts.Name from logali.materials.ProProducts;
    entity EntityInfix       as select Supplier_Id from logali.materials.Products
}

define service Reports {
    entity AverageRating     as projection on logali.reports.AverageRating;

    entity EntityCasting as 
    select
        cast (Price as Integer) as Price,
        Price as Price2 : Integer
    from logali.materials.Products;

entity EntityExists as 
    select from logali.reports.Products {
        ID,
        Name as ProductName @mandatory
    } 


}
