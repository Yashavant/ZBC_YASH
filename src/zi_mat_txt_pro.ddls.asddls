@EndUserText.label: 'Material Projection'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZI_MAT_TXT_PRO as projection on ZI_MAT_TXT {
    key Matnr,
    Ersda,
    CreatedAtTime,
    Ernam,
    Mtart,
    Mbrsh,
    Matkl,
    Meins,
    Brgew,
    Ntgew,
    Gewei,
    Volum,
    Voleh
}
