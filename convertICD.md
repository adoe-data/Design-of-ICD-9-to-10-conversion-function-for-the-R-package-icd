# ConvertICD9toICD10

## convertICD9toICD10(data$var)

Many multi-year electronic health record datasets have both ICD-9 and ICD-10 codes. This can make analysis of comorbidities or other diagnoses complicated, as both code sets must be considered without double-counting diagnoses within a patient. It would be helpful to have all codes in the same revision instance. This function will convert ICD-9 codes to their associated ICD-10 codes. As many of the codes do not result in a one-to-one match, the resulting data frame will have more rows than the input data. The function requires input of short ICD-9 codes. If your codes are in decimal format, you must first convert them to short format (which can be done using the decimal_to_short function in this package). Attempting to input a decimal form variable will result in an error. 

````
library(icd)

dim(vermont_dx)
[1] 1000   25

head(vermont_dx)
visit_id   age_group    sex death  DRG   DX1   DX2   DX3   DX4   DX5   DX6   DX7   DX8 ...
       7      40-44     male  TRUE 640 27801 03842 51881 41519 99591 42842  5849  5609 ...
      10  75 and over female FALSE 470 71526 25000 42830  4280  4019  4241   311  49390 ...
      13  75 and over female FALSE 470 71535 59651 78052 27800 V8537   311  4019  53081 ...
      16       55-59  female FALSE 470 71535 49390 53081 27800  V140  V141  V142  V160 ...
      37       70-74    male FALSE 462 71536  4241  2859  2720  4414 53081 V5866  <NA> ...
      41       70-74    male FALSE 462 71536 V1259 V1582  V160  V171  <NA>  <NA>  <NA> ...


data <- convertICD9toICD10(data$var)
```

Input data:
```
PATIENTID   ICD9
Patient1    0730
Patient2    75435
```

Output data:
```
PATIENT ID  ICD9    ICD10
Patient1    0730    A70
Patient1    0730    J17
Patient2    75435   Q6501
Patient2    75435   Q6502
Patient2    75435   Q6531
Patient2    75435   Q6532
````

The default function will return all ICD-10 codes associated with ICD-9 codes in your data. You can also add arguments for reporting CMS conversion flags. 

```
data<-convertICD9toICD10(data$var, flag=TRUE)
```

Input data:
```
PATIENTID   ICD9
Patient1    0730
Patient2    75435
```

Output data:
```
PATIENT ID  ICD9    ICD10   approximate   noMap  combination   scenario      choicelist
Patient1    0730    A70     1             0      1             1             1
Patient1    0730    J17     1             0      1             1             2
Patient2    75435   Q6501   1             0      1             1             1
Patient2    75435   Q6502   1             0      1             2             1
Patient2    75435   Q6531   1             0      1             2             2
Patient2    75435   Q6532   1             0      1             1             2
```

