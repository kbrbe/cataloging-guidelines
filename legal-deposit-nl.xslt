<?xml version="1.0" encoding="utf-8"?>
  <xsl:stylesheet version="1.0"
                  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                  xmlns:marc="http://www.bs.dk/standards/MarcXchange"
                  xmlns:solr-core-extensions="SolrCoreExtensions"
                  extension-element-prefixes="solr-core-extensions">
<xsl:output method="html"/>
  <xsl:template match="/">
    <xsl:for-each select="response/result/record">
	<xsl:variable name="TEST020A" select="translate(translate(datafield[@tag='020']/subfield[@code='a'],'-',''),' ','')"/>
	<xsl:if test="string-length($TEST020A) = 13">
	
	   <html> <div id="isbn_result"></div></html>

<xsl:variable name="ISBA020" select="translate(translate(datafield[@tag='020']/subfield[@code='a'],'-',''),' ','')"/>
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
  isbn_result.innerHTML = '<p style="color:MediumSeaGreen;">' + isbn + ' is een geldig ISBN-13 nummer.</p>';
} else {
  isbn_result.innerHTML = '<p style="color:Tomato;">' + isbn + ' is geen geldig ISBN-13 nummer!';
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
<!-- TYPE VOLGENS LEADER EN 007 -->
<xsl:choose>
	<xsl:when test="substring($LEADER, 7, 2) = 'am' and substring($FIELD007, 1, 1) != 'c'">
		<xsl:if test="not($C300 != '')">
			<p class="error">Type beschrijving: als het een ebook is, vul dan veld 007 in met 'cu'</p>
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
		<p class="error">040$a : ontbreekt, vul BE-KBR00 in</p>
	</xsl:if>
	<xsl:if test="not($B040 != '')">
		<p class="error">040$b : ontbreekt, vul taal van catalogisering in</p>
	</xsl:if>
	<xsl:if test="not($A041 != '')">
		<p class="error">041$a : ontbreekt, voer taalcode in</p>
	</xsl:if>
	<xsl:if test="not($A044 != '')">
		<p class="error">044$a : ontbreekt, voer landcode in</p>
	</xsl:if>
	<xsl:if test="not($A264 != '')">
		<p class="error">264$a : ontbreekt, vul plaats van uitgave in</p>
	</xsl:if>
	<xsl:if test="not($B264 != '')">
		<p class="error">264$b : ontbreekt, vul uitgever in</p>
	</xsl:if>
	<xsl:if test="not($C264 != '')">
		<p class="error">264$c : ontbreekt, vul beginjaar van uitgave reeks in</p>
	</xsl:if>
	<xsl:if test="not($A336 != '')">
		<p class="error">336$a : ontbreekt, voeg info toe</p>
	</xsl:if>		
	<xsl:if test="not($A337 != '')">
		<p class="error">337$a : ontbreekt, voeg info toe</p>
	</xsl:if>		
	<xsl:if test="$A040 != '' and $B040 != '' and $A041 != '' and $A044 != '' and $A264 != '' and $B264 != '' and $C264 != '' and $A336 != '' and $A337 != '' ">
		<p class="error">Alle verplichte velden voor de reeks zijn ingevuld!</p>
	</xsl:if>	
</xsl:when>
<xsl:otherwise>
	<!-- <xsl:if test="not($P949 != '')">
		<p class="error">949$p : ontbreekt, vul uw initialen in</p>
	</xsl:if> -->
	<xsl:if test="not($A017 != '')">
		<div id="017check" class="error">017$a : niet ingevuld, controleer of er een wettelijk depotnummer is</div>
		<button onclick="function017()">Gecontroleerd, geen wettelijk depotnummer</button>
	</xsl:if>
	<xsl:if test="not($A020 != '')">
		<div id="020check" class="error">020$a : niet ingevuld, controleer of er een ISBN is</div>
		<button onclick="function020()">Gecontroleerd, geen ISBN aanwezig</button>
	</xsl:if>		
	<xsl:if test="not($A040 != '')">
		<p class="error">040$a : ontbreekt, vul BE-KBR00 in</p>
	</xsl:if>
	<xsl:if test="not($B040 != '')">
		<p class="error">040$b : ontbreekt, vul taal van catalogisering in</p>
	</xsl:if>
	<xsl:if test="not($A041 != '')">
		<p class="error">041$a : ontbreekt, voer taalcode in</p>
	</xsl:if>
	<xsl:if test="not($A044 != '')">
		<p class="error">044$a : ontbreekt, voer landcode in</p>
	</xsl:if>
	<xsl:if test="not($A264 != '')">
		<p class="error">264$a : ontbreekt, vul plaats van uitgave in</p>
	</xsl:if>
	<xsl:if test="not($B264 != '')">
		<p class="error">264$b : ontbreekt, vul uitgever in</p>
	</xsl:if>
	<xsl:if test="not($C264 != '')">
		<p class="error">264$c : ontbreekt, vul jaar van uitgave in</p>
	</xsl:if>
	<xsl:if test="not($A300 != '')">
		<p class="error">300$a : ontbreekt, voeg omvang toe</p>
	</xsl:if>
	<xsl:if test="not($C300 != '')">
		<xsl:if test="not(substring($FIELD007, 1, 1) = 'c')">
			<p class="error">300$c : ontbreekt, voeg formaat toe (uitgez. ebooks)</p>
		</xsl:if>
	</xsl:if>		
	<xsl:if test="not($A336 != '')">
		<p class="error">336$a : ontbreekt, voeg info toe</p>
	</xsl:if>		
	<xsl:if test="not($A337 != '')">
		<p class="error">337$a : ontbreekt, voeg info toe</p>
	</xsl:if>		
	<xsl:if test="not($A338 != '')">
		<p class="error">338$a : ontbreekt, voeg info toe</p>
	</xsl:if>	
	<xsl:if test="not($L340 != '')">
		<xsl:if test="substring($LEADER, 7, 2) = 'am' and substring($FIELD007, 1, 1) != 'c' ">
		<xsl:if test="not($A338 = 'rdact:1048')">
			<p class="error">340$l : ontbreekt, voeg type boekband toe (uitgez. reeksen, kaarten, ebooks)</p>
		</xsl:if>
		</xsl:if>
	</xsl:if>	
	<xsl:if test="not($A911 != '')">
		<p class="error">Rubriek BB : ontbreekt, voeg rubriek toe</p>
	</xsl:if>
	<xsl:if test="not($Z949 != '')">
		<p class="error">Status BB : ontbreekt, voeg status toe</p>
	</xsl:if>
	<xsl:if test="$A017 != '' and $A020 != '' and $A040 != '' and $B040 != '' and $A041 != '' and $A044 != '' and $A264 != '' and $B264 != '' and $C264 != '' and $A300 != '' and $C300 != '' and $A336 != '' and $A337 != '' and $A338 != '' and $L340 != '' and $A911 != ''  and $Z949 != ''">
		<p class="error">Alle verplichte velden zijn ingevuld!</p>
	</xsl:if>
</xsl:otherwise>	
</xsl:choose>
	
<!-- controle op catalogiseerfouten -->
<!-- <xsl:if test="$CFLD008 != ''">
		<xsl:if test="not(substring($CFLD008, 7, 1) = 'q' or substring($CFLD008, 7, 1) = 's' or substring($CFLD008, 7, 1) = 't')"><p class="error">008 pos. 6 : vul het type datum of status van de publicatie in (q, s of t)</p></xsl:if>
	</xsl:if> -->
	<xsl:if test="$Z949 != ''">
		<xsl:if test="contains($Z949,'4a')">
			<xsl:if test="$C264 != ''">
				<xsl:variable name="nonDigits" select="'()[]-abcdefghijklmnopqrstvwxyz.?'"/>
				<xsl:variable name="yearPub" select="translate($C264,$nonDigits,'')"/>
				<xsl:variable name="currentYear" select="2025"/>
				<xsl:variable name="totalYears" select="$currentYear - $yearPub"/>
				<xsl:if test="$totalYears > 5 ">
						<p class="error">949$z: de publicatie is al ouder dan 5 jaar en moet niet in de BB verschijnen, verander de status naar '5b'</p>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(contains($Z949,'4a') or contains($Z949,'5b') or contains($Z949,'6'))">
			<p class="error">949$z: verander de status naar 4a voor publicatie in de Belgische Bibliografie of 5b als het niet in BB moet verschijnen</p>
		</xsl:if>
	</xsl:if>
	<!-- <xsl:if test="$A020 != ''">
		<xsl:variable name="vDigits1" select="'0123456789'"/>
		<xsl:if test="string-length(translate($A020,$vDigits1,'')) != 0 "><p class="error">020$a : vul het ISBN zonder streepjes in</p></xsl:if>
	</xsl:if> -->
	<xsl:if test="$C020 != ''">
		<xsl:if test="contains($C020, '€')"><p class="error">020$c : gebruik EUR in plaats van €</p></xsl:if>
		<xsl:if test="contains($C020, ',00')"><p class="error">020$c : gebruik geen nullen achter de komma voor gehele getallen</p></xsl:if>
	</xsl:if>
	<xsl:if test="$B040 != ''">		
		<xsl:choose>
			<xsl:when test="contains($B040, 'fre')">
				<xsl:if test="contains($A041, 'dut')">
				<p class="error">040$b : komt niet overeen met de taalcode in 041$a, verander de taal van catalogering naar 'dut'</p>
				</xsl:if>
			</xsl:when>
			<xsl:when test="contains($B040, 'dut')">
				<xsl:if test="contains($A041, 'fre')">
				<p class="error">040$b : komt niet overeen met de taalcode in 041$a, verander de taal van catalogering naar 'fre'</p>
				</xsl:if>
			</xsl:when>			
		</xsl:choose>	
	</xsl:if>
	<xsl:if test="$A041 != ''">	
		<xsl:if test="contains($A041, 'mul')"><p class="error">041$a : niet meer de code 'mul' gebruiken: herhaal $a en geef alle taalcodes in</p></xsl:if>
	</xsl:if>
	<xsl:if test="not($H041 != '')">
		<xsl:if test="contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke') or contains($I246, 'original') or contains($I246, 'Original')"><p class="error">041$h : vul de oorspronkelijke taal in als het werk een vertaling is</p></xsl:if>
	</xsl:if>	
	<xsl:if test="$A044 != ''">	
		<xsl:if test="contains($A044, 'vp')"><p class="error">044$a : niet meer de code 'vp' gebruiken: herhaal $a en geef alle landcodes in</p></xsl:if>
	</xsl:if>	
	<xsl:if test="$A100 != ''">
		<xsl:if test="not($A1004 != '')"><p class="error">100$4 : bij autoriteit <xsl:value-of select="$A100"/> ontbreekt functiecode, voeg $4 toe</p></xsl:if>
		<xsl:if test="$A110 != ''"><p class="error">1XX : twee hoofdingangen aanwezig, verplaats 110 naar 710</p>
		</xsl:if>
	</xsl:if>
	<xsl:if test="$A110 != ''">
		<xsl:if test="not($A1104 != '')"><p class="error">110$4 : bij autoriteit <xsl:value-of select="$A110"/> ontbreekt functiecode, voeg $4 toe</p></xsl:if>
	</xsl:if>
	<xsl:for-each select="datafield[@tag='245']">
		<xsl:if test="@ind1 = ' '"><p class="error">245 : vul als 1ste indicator '0' in</p></xsl:if>
		<xsl:if test="@ind2 = ' '"><p class="error">245 : vul als 2de indicator '0' in</p></xsl:if>
	</xsl:for-each>	
	<xsl:if test="$C245 != ''">
		<xsl:if test="contains($C245, '[et al.')"><p class="error">245$c : in plaats van '[et al.]' zet '[en X anderen]', zie de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">catalografierichtlijnen</a></u></p></xsl:if>
	</xsl:if>	
	<xsl:if test="$H245 != ''">
		<xsl:if test="not(contains($H245, 'Catalogue de vente') or contains($H245, 'Veilingcatalogus') or contains($H245, 'Auction') or contains($H245, 'Musique') or contains($H245, 'muziek') or contains($H245, 'Score') or contains($H245, 'Partituur') or contains($H245, 'Partition') or contains($H245, 'Geluidenboekje') or contains($H245, 'Lettre') or contains($H245, 'Brief') or contains($H245, 'graphic') or contains($H245, 'Graphic') or contains($H245, 'matrix') or contains($H245, 'print') or contains($H245, 'obituary') or contains($H245, 'iconographique') or contains($H245, 'Iconografisch') or contains($H245, 'postcard') or contains($H245, 'Carte postale') or contains($H245, 'photoroman') or contains($H245, 'roman-photo' or contains($H245, 'accordéon') or contains($H245, 'leporello') or contains($H245, 'Accordion')))"><p class="error">245$h : vermijd dit subveld : verplaats info naar een ander veld of schrijf een toegestane uitzondering met hoofdletter, zie de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">catalografierichtlijnen</a></u></p></xsl:if>
	</xsl:if>
	<xsl:if test="$G246 != ''">
		<xsl:if test="string-length($G246) = 3 "><p class="error">246$g : verplaats taalcode van het origineel naar 041$h</p></xsl:if>
	</xsl:if>
	<xsl:if test="$I246 != ''">
		<xsl:choose>
			<xsl:when test="contains($B040, 'fre')">
				<xsl:if test="contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke')"><p class="error">246$i : schrijf in de taal van 040$b 'Titre original'</p></xsl:if>
			</xsl:when>
			<xsl:when test="contains($B040, 'dut')">
				<xsl:if test="contains($I246, 'original') or contains($I246, 'Original')"><p class="error">246$i : schrijf in de taal van 040$b 'Oorspronkelijke titel'</p>
				</xsl:if>
			</xsl:when>		
			<!-- <xsl:when test="contains($B040, 'eng')">
				<xsl:if test="contains($I246, 'titre original') or contains($I246, 'Titre original') or contains($I246, 'oorspronkelijke') or contains($I246, 'Oorspronkelijke')">
				<p class="error">246$i : schrijf in de taal van 040$b 'Original title'</p>
				</xsl:if>
			</xsl:when>	-->
		</xsl:choose>
	</xsl:if>
	<xsl:if test="$A260 != ''"><p class="error">260 : te verwijderen, verplaats info naar 264</p></xsl:if>
	<xsl:for-each select="datafield[@tag='264']">
		<xsl:if test="@ind2 = ' '"><p class="error">264 : selecteer '1 - Publication' als tweede indicator</p></xsl:if>
		<xsl:if test="contains(subfield[@code='a'],'S.l.') or contains(subfield[@code='a'],'s.l.')"><p class="error">264$a : gebruik niet meer 'S.l.', zie de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">cataloguing guidelines</a></u></p></xsl:if>
	</xsl:for-each>	
	<xsl:if test="$C264 != ''">
		<xsl:variable name="vDigits" select="'0123456789'"/>
		<xsl:if test="string-length(translate($C264,$vDigits,'')) != 0 ">
			<xsl:choose>
			<xsl:when test="$CFLD008 != ''">
				<xsl:if test="substring($CFLD008, 8, 1) = '|' or substring($CFLD008, 8, 1) = ' '">
					<p class="error">264$c : bevat tekstinformatie, vul jaartal in in 008 pos. 07-10 en geef ook het type datum aan in 008 pos. 06 (zie de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">cataloguing guidelines</a></u>)</p>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>			
			<p class="error">264$c : bevat tekstinformatie, vul jaartal in in 008 pos. 07-10 en geef ook het type datum aan in 008 pos. 06 (zie de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">cataloguing guidelines</a></u>)</p>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:if>
	<xsl:if test="$A300 != ''">
		<xsl:if test="contains($A300, '=')"><p class="error">300$a : vertaling niet nodig, voer het aantal bladzijden in in de taal van 040$b</p></xsl:if>
		<xsl:if test="contains($A300, 'pagina') and contains($B040, 'fre')"><xsl:if test="not(contains($A300, 'pagination'))"><p class="error">300$a : voer het aantal bladzijden in in de taal van 040$b</p></xsl:if></xsl:if>
		<xsl:if test="contains($A300, 'pages') and contains($B040, 'dut')"><p class="error">300$a : voer het aantal bladzijden in in de taal van 040$b</p></xsl:if>
		<xsl:choose>
			<xsl:when test="contains($A300, '[')"><p class="error">300$a : niet meer '[ ]' gebruiken. Zo het document niet genummerd is en het aantal pagina’s op het eerste gezicht lager is dan 50 pagina’s, dan tellen we het aantal pagina’s met de hand en voeren het in als 'xx pages non numérotées' of 'xx ongenummerde pagina's' in de taal van 040$b</p></xsl:when>
			<xsl:when test="contains($A300, ' p.')"><p class="error">300$a : schrijf in de taal van 040$b voluit 'pagina's' of 'pages' in plaats van 'p.'</p></xsl:when>
		</xsl:choose>
		<xsl:if test="contains($A300, 'veelv.') or contains($A300, 'Veelv.') or contains($A300, 'mul.') or contains($A300, 'mult.')"><p class="error">300$a : in plaats van ‘Veelv. gepag.’, volg de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">cataloguing guidelines</a></u>. In geval van meer dan 3 verschillende reeksen van nummering, vermelden we deze meervoudige paginering als volgt: '1 volume (pagination multiple)' of '1 volume (meervoudige paginering)' in de taal van 040$b</p></xsl:if>
		<xsl:if test="contains($A300, 'Niet gepag.') or contains($A300, 'N. gepag.') or contains($A300, 'Non pag.') or contains($A300, 'N. pag.') or contains($A300, 'Non p.') or contains($A300, 'N.')"><p class="error">300$a : in plaats van 'Niet gepag.', volg de <u><a href="https://catalog.kbr.be/pro/default/cataloging-guidelines.aspx" target="_blank">cataloguing guidelines</a></u>. Zo het document niet genummerd is en het aantal pagina’s op het eerste gezicht hoger is dan 50 pagina’s, dan vermelden we: '1 volume (non paginé)' of '1 volume (zonder paginering)' in de taal van 040$b</p></xsl:if>
	</xsl:if>
	<xsl:if test="$B300 != ''">
		<xsl:if test="contains($B300, '.')">
		<p class="error">300$b : schrijf in de taal van 040$b 'illustraties' of 'illustrations' in plaats van 'ill.'</p></xsl:if>
		<xsl:if test="contains($B300, '=')"><p class="error">300$b : vertaling niet nodig, voer de illustratieve inhoud in in de taal van 040$b</p></xsl:if>
		<xsl:if test="contains($B300, 'illustratie') and contains($B040, 'fre')"><p class="error">300$b : voer de illustratieve inhoud in in de taal van 040$b</p></xsl:if>
		<xsl:if test="contains($B300, 'illustration') and contains($B040, 'dut')"><p class="error">300$b : voer de illustratieve inhoud in in de taal van 040$b</p></xsl:if>	
	</xsl:if>	
	<!-- <xsl:for-each select="datafield[@tag='336']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">336$2 : broncode ontbreekt, voeg $2 'rdacontent' toe</p></xsl:if>
	</xsl:for-each>	
	<xsl:for-each select="datafield[@tag='337']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">337$2 : broncode ontbreekt, voeg $2 'rdamedia' toe</p></xsl:if>
	</xsl:for-each>	
	<xsl:for-each select="datafield[@tag='338']">
		<xsl:if test="not(subfield[@code='2'] != '')"><p class="error">338$2 : broncode ontbreekt, voeg $2 'rdacarrier' toe</p></xsl:if>
	</xsl:for-each>	-->
	<xsl:if test="$A385 != ''">
		<p class="error">385$a : te verwijderen, verplaats info naar 521$a</p>
	</xsl:if>	
	<xsl:if test="$A490 != ''">
		<p class="error">490$a : te verwijderen, voeg link naar reeks toe in 773$t</p>
	</xsl:if>
	<xsl:if test="$X650 != ''">
		<p class="error">650$x : 650 dient voor de eenvoudige onderwerpen, verplaats het samengestelde onderwerp naar 654</p>
	</xsl:if>
	<xsl:for-each select="datafield[@tag='700']">
		<xsl:if test="not(subfield[@code='4'] != '')"><p class="error">700$4 : bij autoriteit <xsl:value-of select="subfield[@code='a']"/> ontbreekt functiecode, voeg $4 toe</p></xsl:if>
	</xsl:for-each>
	<xsl:for-each select="datafield[@tag='710']">
		<xsl:if test="not(subfield[@code='4'] != '')"><p class="error">710$4 : bij autoriteit <xsl:value-of select="subfield[@code='a']"/> ontbreekt functiecode, voeg $4 toe</p></xsl:if>
	</xsl:for-each>	
	<!-- <xsl:if test="$A700 != ''">
		<xsl:if test="not($A100 != '') and not($A110 != '')">
			<p class="error">100/700 : als er meerdere auteurs zijn, zet de eerste in 100 en de andere in 700</p>
		</xsl:if>
	</xsl:if> -->
	<xsl:if test="not($A100 != '') and not($A110 != '') and not($A700 != '') and not($A710 != '')">
		<xsl:choose>
			<xsl:when test="$C245 != ''"><p class="error">1XX/7XX : gelieve de autoriteiten toe te voegen</p></xsl:when>
			<xsl:when test="$B264 != ''"><xsl:if test="not(contains($B264, 's.n')) and not(contains($B264, 'S.n')) and not(contains($B264, 'sine nomine'))"><p class="error">1XX/7XX : gelieve de autoriteiten toe te voegen</p></xsl:if></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<xsl:if test="$C300 != ''">
		<xsl:if test="not($G997 != '')">
			<p class="error">Deze beschrijving heeft nog geen plaatskenmerk !</p>
		</xsl:if>
	</xsl:if>
</xsl:for-each>  
</xsl:template>
</xsl:stylesheet>
