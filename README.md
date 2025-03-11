# KBR cataloging guidelines
This repository contains the HTML cataloging guidelines of The Royal Library of Belgium (KBR) as well XSLT rules to enforce parts of it if possible.

## XSLT Validation for cataloguing records

### Overview
This repository contains an XSLT stylesheet and its accompanying translations file, designed to validate cataloguing records according to our internal cataloguing guidelines. The validation process helps ensure compliance with these guidelines by converting records into an HTML list of errors and presenting them through an internal URL.
More information about the principles behind this validation method can be found in the IFLA Metadata Newsletter, Volume 8, Number 1, June 2022 : https://repository.ifla.org/handle/20.500.14598/1976 (although it must be noted it discusses an earlier version without translations file, with two separate stylesheets for the Dutch and French language).

### Purpose
In preparation for implementing RDA (Resource Description and Access) in our cataloguing rules, we have developed a real-time validation method that assists cataloguers in their daily work. This method provides immediate feedback on errors related to cataloguing rules.

### How It Works
Each record undergoes validation through an XSLT transformation and is displayed as an HTML list of errors via an internal URL. This URL contains a couple key parameters:
*	Profile: Each document type has a specific validation profile, and different XSLT stylesheets are applied accordingly.
*	Record Identifier: Identifies the specific cataloguing record being validated.
A PHP script selects the appropriate XSLT file based on the profile parameter. The validation result, determined by the combination of profile, and record identifier, is displayed within our Library Management System (LMS) using an iframe.
The list of errors is shown in the language of cataloguing selected in datafield 040$b. Four languages are possible : Dutch, French, English or German. When the datafield is empty or contains another language, a generic message is shown asking to select a language of cataloguing. The translations are stored in the translations.xml file which the stylesheet refers to.
 
### Elements Controlled
This XSLT validation checks various aspects of cataloguing records, including but not limited to:
*	ISBN Check-Digit Verification: Ensures that the ISBN is correctly formatted and free of typos.
*	Mandatory Fields: Identifies and lists missing required fields in the record.
*	Abbreviation Standardisation: Detects outdated abbreviations (e.g., ‘ill.’ or ‘p.’) and suggests replacements (‘illustrations’ or ‘pages’) in line with new RDA-based agreements.

### Future Developments
We are continuously investigating further enhancements to improve validation accuracy and expand the range of elements checked. Our goal is to make cataloguing more efficient and ensure compliance with evolving cataloguing standards.

## Contact
Hannes Lowagie - Hannes.Lowagie@kbr.be - Royal Library of Belgium (KBR) - https://www.kbr.be/en/

