namespace com.logali;

entity Products {
    key ID               : UUID;
        Name             : String;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        UnitOfMeasure_Id : String;
        Currency_Id      : String;
        Category_Id      : String;
        Supplier_Id      : UUID;
        DimensionUnit_Id : String;


};

entity Supplier {
    key ID         : UUID;
        Name       : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String;
        Email      : String;
        Phone      : String;
        Fax        : String;

};

entity Categories {
    key ID   : String(1);
        Name : String;
};

entity StockAvailability {
    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasures {
    key ID          : String(3);
        Description : String;
};

entity DimensionUnits {
    key ID          : String(3);
        Description : String;
};

entity Months {
    key ID               : String(3);
        Description      : String;
        ShortDescription : String(3);
};

entity ProductReview {
    key Name    : String;
        Rating  : Integer;
        Comment : String;
};

entity SalesData {
    key DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);

};
