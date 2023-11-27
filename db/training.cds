namespace com.training;

using {
    cuid,
    managed
} from '@sap/cds/common';

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

// definicion de ENTIDADES CON PARAMETROS

// entity ParamProducts(pName : String) as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;

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