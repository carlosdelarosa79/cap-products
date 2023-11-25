namespace com.logali;

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

// type EmailsAddresses_01 : array of {
//     kind  : String;
//     email : String;
// };

// entity Emails {
//     email_01 : EmailsAddresses_01;
// };

//entity Car {
//  key ID                 : UUID;
//    Name               : String;
//  virtual discount_1 : Decimal;
//virtual discount_2 : Decimal;
//}

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
    SalesData        : Association to many SalesData;
    Reviews          : Association to many ProductReview;

};

// como vemos en item  tenmos una COMPOSITION  esto es para que si el padre no existe todo se borra es la diferencia entre la COMPOSITION Y ASSOCIATION
entity Orders : cuid {
    Date     : Date;
    Customer : String;
    Item     : Composition of many OrderItems
                   on Item.order = $self
};

entity OrderItems : cuid {
    order    : Association to Orders;
    Product  : Association to Products;
    Quantity : Integer;
};

entity Suppliers : cuid, managed {
    Name    : type of Products : Name;
    Address : Address;
    Email   : String;
    Phone   : String;
    Fax     : String;
    Product : Association to many Products
                  on Product.Supplier_Id;

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

entity Months : cuid {
    Description      : localized String;
    ShortDescription : localized String(3);
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
};

entity SalesData : cuid, managed {
    DeliveryDate     : DateTime;
    Revenue          : Decimal(16, 2);
    Product_Id       : UUID;
    Currency_Id      : String;
    DeliveryMonth_Id : Integer;

};


// son entidades de projeccion y esta entidad utiliza otra entidad ya DEFINIDA para selecionar los DATOS
entity SelProducts  as select from Products;

entity SelProducts1 as
    select from Products {
        *
    };

entity SelProducts2 as
    select from Products {
        Name,
        Price,
        Quantity
    };

entity SelProducts3 as
    select from Products
    left join ProductReview
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

//para crear vistas de tipo proyeccion 3 formas diferentes , y aca tenemos restricciones por que no soportan los join
entity ProProducts  as projection on Products;

entity ProProducts2 as projection on Products {
    *
};

entity ProProducts3 as projection on Products {
    ReleaseDate,
    Name
};

// definicion de ENTIDADES CON PARAMETROS

// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;


// ENTIDADES AMPLIACION
// esto nos sirve para AMPLIAR LA ENTIDAD Produts
extend Products with {
    priceCondition     : String(2);
    priceDetermination : String(3);
};

// nos sirve para poder hacer la relacion MANY TO MANY ya q toca hacerlo asi como en este codigo no se puede directo
entity Course : cuid {
    Student : Association to many StudentCourse
                  on Student.Course = $self;
}

entity Student : cuid {
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    Student : Association to Student;
    Course  : Association to Course;
}
