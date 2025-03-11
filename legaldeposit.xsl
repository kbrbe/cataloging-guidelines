<?xml version="1.0" encoding="utf-8"?>
  <xsl:stylesheet version="1.0"
                  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                  xmlns:marc="http://www.bs.dk/standards/MarcXchange"
                  xmlns:solr-core-extensions="SolrCoreExtensions"
                  extension-element-prefixes="solr-core-extensions">
<xsl:output method="html" encoding="UTF-8" indent="no"/>
  <xsl:template match="/">
    <html>
        <head>
          <META content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
        </head>
	<body>
  <!-- Link to translations document -->
  <xsl:variable name="translations" select="document('translations.xml')" />
  <!-- <xsl:template name="translate">
    <xsl:param name="key" />
    <xsl:value-of select="$translations//text[@key=$key]/lang[@code=$lang]" />
</xsl:template> -->

<xsl:for-each select="response/result/record">
	
<!-- ISBN check via javascript -->
	<xsl:variable name="TEST020A" select="translate(translate(datafield[@tag='020']/subfield[@code='a'],'-',''),' ','')"/>
		<xsl:if test="string-length($TEST020A) = 13">
		
		   <div id="isbn_result"></div>
			
			<xsl:variable name="ISBA020" select="translate(translate(datafield[@tag='020']/subfield[@code='a'],'-',''),' ','')"/>
			<xsl:variable name="IB040" select="datafield[@tag='040']/subfield[@code='b']"/>
			<script><![CDATA[

			function isValidISBN13(isbn) {
			  // Remove any hyphens or spaces from the input
			  isbn = isbn.replace(/[-\s]/g, '');
			  
			  // Check that the input consists of exactly 13 digits
			  if (isbn.length !== 13 || !/^\d+$/.test(isbn)) {
				return false;
			  }
			  
			  // Calculate the check digit
			  let sum = 0;
			  for (let i = 0; i < 12; i++) {
				sum += parseInt(isbn.charAt(i)) * (i % 2 === 0 ? 1 : 3);
			  }
			  let checkDigit = (10 - (sum % 10)) % 10;
			  
			  // Compare the check digit to the last digit of the input
			  return checkDigit === parseInt(isbn.charAt(12));
			}
			const isbn = ']]><xsl:value-of select="$ISBA020"/><![CDATA[';
			const isbn_result = document.getElementById('isbn_result');
			if (isValidISBN13(isbn)) {
			  isbn_result.innerHTML = '<p style="color:MediumSeaGreen;">' + isbn + ']]><xsl:value-of select="$translations//text[@key='isbnValid']/lang[@code=$IB040]"/><![CDATA[</p>';
			} else {
			  isbn_result.innerHTML = '<p style="color:Tomato;">' + isbn + ']]><xsl:value-of select="$translations//text[@key='isbnInvalid']/lang[@code=$IB040]"/><![CDATA[</p>';
			  
			}

			]]>
			</script>
		</xsl:if>
		
<!-- lijst van velden die opgenomen zijn in de QC -->
	<xsl:variable name="LEADER" select="leader"/>
	<xsl:variable name="FIELD007" select="controlfield[@tag='007']"/>
	<xsl:variable name="CFLD008" select="controlfield[@tag='008']"/>
	<xsl:variable name="P949" select="datafield[@tag='949']/subfield[@code='p']"/>
	<xsl:variable name="Z949" select="datafield[@tag='949']/subfield[@code='z']"/>
	<xsl:variable name="A017" select="datafield[@tag='017']/subfield[@code='a']"/>
	<xsl:variable name="B017" select="datafield[@tag='017']/subfield[@code='b']"/>
	<xsl:variable name="A020" select="datafield[@tag='020']/subfield[@code='a']"/>
	<xsl:variable name="C020" select="datafield[@tag='020']/subfield[@code='c']"/>
	<xsl:variable name="A040" select="datafield[@tag='040']/subfield[@code='a']"/>
	<xsl:variable name="B040" select="datafield[@tag='040']/subfield[@code='b']"/>
	<xsl:variable name="A041" select="datafield[@tag='041']/subfield[@code='a']"/>
	<xsl:variable name="H041" select="datafield[@tag='041']/subfield[@code='h']"/>
	<xsl:variable name="A044" select="datafield[@tag='044']/subfield[@code='a']"/>	
	<xsl:variable name="A100" select="datafield[@tag='100']/subfield[@code='a']"/>
	<xsl:variable name="A1004" select="datafield[@tag='100']/subfield[@code='4']"/>
	<xsl:variable name="A110" select="datafield[@tag='110']/subfield[@code='a']"/>
	<xsl:variable name="A1104" select="datafield[@tag='110']/subfield[@code='4']"/>	
	<xsl:variable name="C245" select="datafield[@tag='245']/subfield[@code='c']"/>
	<xsl:variable name="H245" select="datafield[@tag='245']/subfield[@code='h']"/>
	<xsl:variable name="G246" select="datafield[@tag='246']/subfield[@code='g']"/>
	<xsl:variable name="I246" select="datafield[@tag='246']/subfield[@code='i']"/>
	<xsl:variable name="A260" select="datafield[@tag='260']/subfield[@code='a']"/>
	<xsl:variable name="A264" select="datafield[@tag='264']/subfield[@code='a']"/>
	<xsl:variable name="B264" select="datafield[@tag='264']/subfield[@code='b']"/>
	<xsl:variable name="C264" select="datafield[@tag='264']/subfield[@code='c']"/>
	<xsl:variable name="A300" select="datafield[@tag='300']/subfield[@code='a']"/>
	<xsl:variable name="B300" select="datafield[@tag='300']/subfield[@code='b']"/>
	<xsl:variable name="C300" select="datafield[@tag='300']/subfield[@code='c']"/>
	<xsl:variable name="A336" select="datafield[@tag='336']/subfield[@code='a']"/>
	<xsl:variable name="A337" select="datafield[@tag='337']/subfield[@code='a']"/>
	<xsl:variable name="A338" select="datafield[@tag='338']/subfield[@code='a']"/>
	<xsl:variable name="A385" select="datafield[@tag='385']/subfield[@code='a']"/>
	<xsl:variable name="L340" select="datafield[@tag='340']/subfield[@code='l']"/>
	<xsl:variable name="A490" select="datafield[@tag='490']/subfield[@code='a']"/>
	<xsl:variable name="A911" select="datafield[@tag='911']/subfield[@code='a']"/>
	<xsl:variable name="A650" select="datafield[@tag='650']/subfield[@code='a']"/>
	<xsl:variable name="X650" select="datafield[@tag='650']/subfield[@code='x']"/>
	<xsl:variable name="A700" select="datafield[@tag='700']/subfield[@code='a']"/>
	<xsl:variable name="A710" select="datafield[@tag='710']/subfield[@code='a']"/>	
	<xsl:variable name="G997" select="datafield[@tag='997']/subfield[@code='g']"/>
<!-- CONTROLE LANGUE DE CATALO -->
<xsl:if test="not(contains($B040, 'fre') or contains($B040, 'dut') or contains($B040, 'ger') or contains($B040, 'eng'))">
	<p class="error"><xsl:value-of select="$translations//text[@key='catLang']/lang" /></p>
</xsl:if>
<!-- TYPE SELON LEADER ET 007 -->
<xsl:choose>
	<xsl:when test="substring($LEADER, 7, 2) = 'am' and substring($FIELD007, 1, 1) != 'c'">
		<xsl:if test="not($C300 != '')">
			<p class="error"><xsl:value-of select="$translations//text[@key='ebook']/lang[@code=$B040]" /></p>
		</xsl:if>
	</xsl:when>
	<!-- <xsl:when test="substring($LEADER, 7, 2) = 'ac' ">
		<p class="error">Het type van de beschrijving is REEKS volgens de leader, controleer of dit correct is, zo nee, pas aan volgens de regels in de cataloguing guidelines</p>
	</xsl:when>
	<xsl:when test="substring($LEADER, 7, 2) = 'em' ">
		<p class="error">Het type van de beschrijving is KAART volgens de leader, controleer of dit correct is, zo nee, pas aan volgens de regels in de cataloguing guidelines</p>
	</xsl:when>
	<xsl:when test="substring($LEADER, 7, 2) = 'cm' ">
		<p class="error">Het type van de beschrijving is PARTITUUR volgens de leader, controleer of dit correct is, zo nee, pas aan volgens de regels in de cataloguing guidelines</p>
	</xsl:when>
	<xsl:when test="substring($LEADER, 7, 2) = 'dm' ">
		<p class="error">Het type van de beschrijving is PARTITUUR volgens de leader, controleer of dit correct is, zo nee, pas aan volgens de regels in de cataloguing guidelines</p>
	</xsl:when> -->
	<xsl:otherwise></xsl:otherwise>
</xsl:choose>
<!-- controle of alle verplichte velden aanwezig zijn -->
<xsl:choose>
<xsl:when test="substring($LEADER, 8, 1) = 's' or substring($LEADER, 8, 1) = 'c'">
	<xsl:if test="not($A040 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='catAgency']/lang[@code=$B040]" /></p>
	</xsl:if>	
	<!-- Deze controle staat nu elders : <xsl:if test="not($B040 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='catLang']/lang[@code=$B040]" /></p>
	</xsl:if> -->
	<xsl:if test="not($A041 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='bookLang']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A044 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='bookCountry']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='publishingLocation']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($B264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='publisher']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($C264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='yearPubColl']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A336 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='RDA336']/lang[@code=$B040]" /></p>
	</xsl:if>		
	<xsl:if test="not($A337 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='RDA337']/lang[@code=$B040]" /></p>
	</xsl:if>			
	<xsl:if test="$A040 != '' and $B040 != '' and $A041 != '' and $A044 != '' and $A264 != '' and $B264 != '' and $C264 != '' and $A336 != '' and $A337 != ''">
		<p class="error"><xsl:value-of select="$translations//text[@key='allCheckedColl']/lang[@code=$B040]" /></p>
	</xsl:if>
</xsl:when>
<xsl:otherwise>	
	<!-- <xsl:if test="not($P949 != '')">
		<p class="error">949$p : manquant, indiquez vos initiales</p>
	</xsl:if>	 -->
	<xsl:if test="not($A017 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='legalDepositNr']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A020 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='isbn']/lang[@code=$B040]" /></p>
	</xsl:if>		
	<xsl:if test="not($A040 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='catAgency']/lang[@code=$B040]" /></p>
	</xsl:if>	
	<!-- Deze controle staat nu elders : <xsl:if test="not($B040 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='catLang']/lang[@code=$B040]" /></p>
	</xsl:if> -->
	<xsl:if test="not($A041 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='bookLang']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A044 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='bookCountry']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='publishingLocation']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($B264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='publisher']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($C264 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='yearPub']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($A300 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='collation']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($C300 != '')">
		<xsl:if test="not(substring($FIELD007, 1, 1) = 'c')">
			<p class="error"><xsl:value-of select="$translations//text[@key='dimensions']/lang[@code=$B040]" /></p>
		</xsl:if>
	</xsl:if>		
	<xsl:if test="not($A336 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='RDA336']/lang[@code=$B040]" /></p>
	</xsl:if>		
	<xsl:if test="not($A337 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='RDA337']/lang[@code=$B040]" /></p>
	</xsl:if>		
	<xsl:if test="not($A338 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='RDA338']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="not($L340 != '')">
		<xsl:if test="substring($LEADER, 7, 2) = 'am' and substring($FIELD007, 1, 1) != 'c' ">
		<xsl:if test="not($A338 = 'rdact:1048')">
			<p class="error"><xsl:value-of select="$translations//text[@key='binding']/lang[@code=$B040]" /></p>
		</xsl:if>
		</xsl:if>
	</xsl:if>		
	<xsl:if test="not($A911 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='rubriek']/lang[@code=$B040]" /></p> 
	</xsl:if>
	<xsl:if test="not($Z949 != '')">
		<p class="error"><xsl:value-of select="$translations//text[@key='statusLacking']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="$A017 != '' and $A020 != '' and $A040 != '' and $B040 != '' and $A041 != '' and $A044 != '' and $A264 != '' and $B264 != '' and $C264 != '' and $A300 != '' and $C300 != '' and $A336 != '' and $A337 != '' and $A338 != '' and $L340 != '' and $A911 != '' and $Z949 != ''">
		<p class="error"><xsl:value-of select="$translations//text[@key='allChecked']/lang[@code=$B040]" /></p>
	</xsl:if>
</xsl:otherwise>	
</xsl:choose>
	
<!-- controle op catalogiseerfouten -->
<!-- <xsl:if test="$CFLD008 != ''">
		<xsl:if test="not(substring($CFLD008, 7, 1) = 'q' or substring($CFLD008, 7, 1) = 's' or substring($CFLD008, 7, 1) = 't')"><p class="error">008 pos. 06 : indiquez le type de date ou le statut de publication (q, s ou t)</p></xsl:if>
	</xsl:if> -->
	<xsl:if test="$Z949 != ''">
		<xsl:if test="contains($Z949,'4a')">
			<xsl:if test="$C264 != ''">
				<xsl:variable name="nonDigits" select="'()[]-abcdefghijklmnopqrstvwxyz.?'"/>
				<xsl:variable name="yearPub" select="translate($C264,$nonDigits,'')"/>
				<xsl:variable name="currentYear" select="2025"/>
				<xsl:variable name="totalYears" select="$currentYear - $yearPub"/>
				<xsl:if test="$totalYears > 5 ">
					<p class="error"><xsl:value-of select="$translations//text[@key='statusOld']/lang[@code=$B040]" /></p>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(contains($Z949,'4a') or contains($Z949,'5b') or contains($Z949,'6'))">
			<p class="error"><xsl:value-of select="$translations//text[@key='statusWrong']/lang[@code=$B040]" /></p>
		</xsl:if>
	</xsl:if>
	<!-- <xsl:if test="$A020 != ''">
		<xsl:variable name="vDigits1" select="'0123456789'"/>
		<xsl:if test="string-length(translate($A020,$vDigits1,'')) != 0 "><p class="error">020$a : indiquez l'ISBN sans tirets</p></xsl:if>
	</xsl:if> -->
	<xsl:if test="$C020 != ''">
		<xsl:if test="contains($C020, '€')"><p class="error"><xsl:value-of select="$translations//text[@key='eurSymbol']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($C020, ',00')"><p class="error"><xsl:value-of select="$translations//text[@key='zeros']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<xsl:if test="$B040 != ''">		
		<xsl:choose>
			<xsl:when test="contains($B040, 'fre')">
				<xsl:if test="contains($A041, 'dut')">
				<p class="error"><xsl:value-of select="$translations//text[@key='catLangDut']/lang[@code=$B040]" /></p>
				</xsl:if>
			</xsl:when>
			<xsl:when test="contains($B040, 'dut')">
				<xsl:if test="contains($A041, 'fre')">
				<p class="error"><xsl:value-of select="$translations//text[@key='catLangFre']/lang[@code=$B040]" /></p>
				</xsl:if>
			</xsl:when>		
		</xsl:choose>	
	</xsl:if>	
	<xsl:if test="$A041 != ''">	
		<xsl:if test="contains($A041, 'mul')"><p class="error"><xsl:value-of select="$translations//text[@key='mulLang']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>	
	<xsl:if test="not($H041 != '')">
		<xsl:if test="contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke') or contains($I246, 'original') or contains($I246, 'Original')"><p class="error"><xsl:value-of select="$translations//text[@key='origLang']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>		
	<xsl:if test="$A044 != ''">	
		<xsl:if test="contains($A044, 'vp')"><p class="error"><xsl:value-of select="$translations//text[@key='vpCountry']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>		
	<xsl:if test="$A100 != ''">
		<xsl:if test="not($A1004 != '')"><p class="error"><xsl:value-of select="$translations//text[@key='codeFoncLacking100']/lang[@code=$B040]" /><xsl:value-of select="$A100"/></p></xsl:if>
		<xsl:if test="$A110 != ''"><p class="error"><xsl:value-of select="$translations//text[@key='twoMainEntries']/lang[@code=$B040]" /></p>
		</xsl:if>
	</xsl:if>
	<xsl:if test="$A110 != ''">
		<xsl:if test="not($A1104 != '')"><p class="error"><xsl:value-of select="$translations//text[@key='codeFoncLacking110']/lang[@code=$B040]" /><xsl:value-of select="$A110"/></p></xsl:if>
	</xsl:if>
	<xsl:for-each select="datafield[@tag='245']">
		<xsl:if test="@ind1 = ' '"><p class="error"><xsl:value-of select="$translations//text[@key='titleInd1']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="@ind2 = ' '"><p class="error"><xsl:value-of select="$translations//text[@key='titleInd2']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:for-each>		
	<xsl:if test="$C245 != ''">
		<xsl:if test="contains($C245, '[et al.')"><p class="error"><xsl:value-of select="$translations//text[@key='resp']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<xsl:if test="$H245 != ''">
		<xsl:if test="not(contains($H245, 'Catalogue de vente') or contains($H245, 'Veilingcatalogus') or contains($H245, 'Auction') or contains($H245, 'Musique') or contains($H245, 'muziek') or contains($H245, 'Score') or contains($H245, 'Partituur') or contains($H245, 'Partition') or contains($H245, 'Geluidenboekje') or contains($H245, 'Lettre') or contains($H245, 'Brief') or contains($H245, 'graphic') or contains($H245, 'Graphic') or contains($H245, 'matrix') or contains($H245, 'print') or contains($H245, 'obituary') or contains($H245, 'iconographique') or contains($H245, 'Iconografisch') or contains($H245, 'postcard') or contains($H245, 'Carte postale') or contains($H245, 'photoroman') or contains($H245, 'roman-photo') or contains($H245, 'accordéon') or contains($H245, 'leporello') or contains($H245, 'Accordion'))"><p class="error"><xsl:value-of select="$translations//text[@key='titleMedium']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<xsl:if test="$G246 != ''">
		<xsl:if test="string-length($G246) = 3 "><p class="error"><xsl:value-of select="$translations//text[@key='origtitleLang']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<xsl:if test="$I246 != ''">
		<xsl:choose>
			<xsl:when test="contains($B040, 'fre')">
				<xsl:if test="contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke')"><p class="error"><xsl:value-of select="$translations//text[@key='origTitleFre']/lang[@code=$B040]" /></p></xsl:if>
			</xsl:when>
			<xsl:when test="contains($B040, 'dut')">
				<xsl:if test="contains($I246, 'original') or contains($I246, 'Original')"><p class="error"><xsl:value-of select="$translations//text[@key='origTitleDut']/lang[@code=$B040]" /></p>
				</xsl:if>
			</xsl:when>		
			<!-- <xsl:when test="contains($B040, 'eng')">
				<xsl:if test="contains($I246, 'titre original') or contains($I246, 'Titre original') or contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke')">
				<p class="error">246$i : indiquez 'Original title' dans la langue du 040$b</p>
				</xsl:if>
			</xsl:when>	-->
		</xsl:choose>
	</xsl:if>	
	<xsl:if test="$A260 != ''"><p class="error"><xsl:value-of select="$translations//text[@key='wrongPubField']/lang[@code=$B040]" /></p></xsl:if>
	<xsl:for-each select="datafield[@tag='264']">
		<xsl:if test="@ind2 = ' '"><p class="error"><xsl:value-of select="$translations//text[@key='pubInd']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains(subfield[@code='a'],'S.l.') or contains(subfield[@code='a'],'s.l.')"><p class="error"><xsl:value-of select="$translations//text[@key='sineLoc']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:for-each>	
	<xsl:if test="$C264 != ''">
		<xsl:variable name="vDigits" select="'0123456789'"/>
		<xsl:if test="string-length(translate($C264,$vDigits,'')) != 0 ">
			<xsl:choose>
			<xsl:when test="$CFLD008 != ''">
				<xsl:if test="substring($CFLD008, 8, 1) = '|' or substring($CFLD008, 8, 1) = ' '">
					<p class="error"><xsl:value-of select="$translations//text[@key='controlledYearPub']/lang[@code=$B040]" /></p>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<p class="error"><xsl:value-of select="$translations//text[@key='controlledYearPub']/lang[@code=$B040]" /><u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank"></a></u></p>			
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:if>
	<xsl:if test="$A300 != ''">	
		<xsl:if test="contains($A300, '=')"><p class="error"><xsl:value-of select="$translations//text[@key='noTranslate']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($A300, 'pagina') and contains($B040, 'fre')"><xsl:if test="not(contains($A300, 'pagination'))"><p class="error"><xsl:value-of select="$translations//text[@key='numberOfPages']/lang[@code=$B040]" /></p></xsl:if></xsl:if>
		<xsl:if test="contains($A300, 'pages') and contains($B040, 'dut')"><p class="error"><xsl:value-of select="$translations//text[@key='numberOfPages']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:choose>
			<xsl:when test="contains($A300, '[')"><p class="error"><xsl:value-of select="$translations//text[@key='unnumberedPages']/lang[@code=$B040]" /></p></xsl:when>
			<xsl:when test="contains($A300, ' p.')"><p class="error"><xsl:value-of select="$translations//text[@key='abbrevPages']/lang[@code=$B040]" /></p></xsl:when>
		</xsl:choose>
		<xsl:if test="contains($A300, 'veelv.') or contains($A300, 'Veelv.') or contains($A300, 'mul.') or contains($A300, 'mult.')"><p class="error"><xsl:value-of select="$translations//text[@key='mulPages']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($A300, 'Niet gepag.') or contains($A300, 'N. gepag.') or contains($A300, 'Non pag.') or contains($A300, 'N. pag.') or contains($A300, 'Non p.') or contains($A300, 'N.')"><p class="error"><xsl:value-of select="$translations//text[@key='nonPages']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<xsl:if test="$B300 != ''">
		<xsl:if test="contains($B300, '.')">
		<p class="error"><xsl:value-of select="$translations//text[@key='abbrevIll']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($B300, '=')"><p class="error"><xsl:value-of select="$translations//text[@key='donotTranslate']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($B300, 'illustratie') and contains($B040, 'fre')"><p class="error"><xsl:value-of select="$translations//text[@key='illFreDut']/lang[@code=$B040]" /></p></xsl:if>
		<xsl:if test="contains($B300, 'illustration') and contains($B040, 'dut')"><p class="error"><xsl:value-of select="$translations//text[@key='illFreDut']/lang[@code=$B040]" /></p></xsl:if>
	</xsl:if>
	<!-- <xsl:for-each select="datafield[@tag='336']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">336$2 : code source manquant, ajoutez $2 'rdacontent'</p></xsl:if>
	</xsl:for-each>	
	<xsl:for-each select="datafield[@tag='337']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">337$2 : code source manquant, ajoutez $2 'rdamedia'</p></xsl:if>
	</xsl:for-each>	
	<xsl:for-each select="datafield[@tag='338']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">338$2 : code source manquant, ajoutez $2 'rdacarrier'</p></xsl:if>
	</xsl:for-each>	-->	
	<xsl:if test="$A385 != ''">
		<p class="error"><xsl:value-of select="$translations//text[@key='targetAudience']/lang[@code=$B040]" /></p>
	</xsl:if>	
	<xsl:if test="$A490 != ''">
		<p class="error"><xsl:value-of select="$translations//text[@key='series']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:if test="$X650 != ''">
		<p class="error"><xsl:value-of select="$translations//text[@key='subject']/lang[@code=$B040]" /></p>
	</xsl:if>
	<xsl:for-each select="datafield[@tag='700']">
		<xsl:if test="not(subfield[@code='4'] != '')"><p class="error"><xsl:value-of select="$translations//text[@key='codeFoncLacking700']/lang[@code=$B040]" /><xsl:value-of select="subfield[@code='a']"/></p></xsl:if>
	</xsl:for-each>
	<xsl:for-each select="datafield[@tag='710']">
		<xsl:if test="not(subfield[@code='4'] != '')"><p class="error"><xsl:value-of select="$translations//text[@key='codeFoncLacking710']/lang[@code=$B040]" /><xsl:value-of select="subfield[@code='a']"/></p></xsl:if>
	</xsl:for-each>
	<!-- <xsl:if test="$A700 != ''">
		<xsl:if test="not($A100 != '') and not($A110 != '')">
			<p class="error">100/700 : s'il y a plusieurs auteurs, mettez le 1er dans le 100 et les autres dans le 700</p>
		</xsl:if>
	</xsl:if> -->
	<xsl:if test="not($A100 != '') and not($A110 != '') and not($A700 != '') and not($A710 != '')">
		<xsl:choose>
			<xsl:when test="$C245 != ''"><p class="error"><xsl:value-of select="$translations//text[@key='addAutorities']/lang[@code=$B040]" /></p></xsl:when>
			<xsl:when test="$B264 != ''"><xsl:if test="not(contains($B264, 's.n')) and not(contains($B264, 'S.n')) and not(contains($B264, 'sine nomine'))"><p class="error"><xsl:value-of select="$translations//text[@key='addAutorities']/lang[@code=$B040]" /></p></xsl:if></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<xsl:if test="$C300 != ''">
		<xsl:if test="not($G997 != '')">
			<p class="error"><xsl:value-of select="$translations//text[@key='noCallnr']/lang[@code=$B040]" /></p>
		</xsl:if>
	</xsl:if>
</xsl:for-each>  
</body>
</html>
</xsl:template>
</xsl:stylesheet>