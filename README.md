# KBR cataloging guidelines
Currently this repository contains only the XSLT to enforce mandatory parts of the cataloging guidelines

XSLT Validation for cataloguing records

## Overview
This repository contains an XSLT stylesheet designed to validate cataloguing records according to our internal cataloguing guidelines. The validation process helps ensure compliance with these guidelines by converting records into an HTML list of errors and presenting them through an internal URL.
More information about the principles behind this validation method can be found in the IFLA Metadata Newsletter, Volume 8, Number 1, June 2022 : https://repository.ifla.org/handle/20.500.14598/1976

## Purpose
In preparation for implementing RDA (Resource Description and Access) in our cataloguing rules, we have developed a real-time validation method that assists cataloguers in their daily work. This method provides immediate feedback on errors related to cataloguing rules.

## How It Works
Each record undergoes validation through an XSLT transformation and is displayed as an HTML list of errors via an internal URL. This URL contains three key parameters:
*	Language: Dutch or French, the two main languages used by cataloguers in Belgium.
*	Profile: Each document type has a specific validation profile, and different XSLT stylesheets are applied accordingly.
*	Record Identifier: Identifies the specific cataloguing record being validated.
A PHP script selects the appropriate XSLT file based on the language and profile parameters. The validation result, determined by the combination of language, profile, and record identifier, is displayed within our Library Management System (LMS) using an iframe, ensuring cataloguers receive feedback in their working language.

## Elements Controlled
This XSLT validation checks various aspects of cataloguing records, including but not limited to:
*	ISBN Check-Digit Verification: Ensures that the ISBN is correctly formatted and free of typos.
*	Mandatory Fields: Identifies and lists missing required fields in the record.
*	Abbreviation Standardisation: Detects outdated abbreviations (e.g., ‘ill.’ or ‘p.’) and suggests replacements (‘illustrations’ or ‘pages’) in line with new RDA-based agreements.

## Future Developments
We are continuously investigating further enhancements to improve validation accuracy and expand the range of elements checked. Our goal is to make cataloguing more efficient and ensure compliance with evolving cataloguing standards.
