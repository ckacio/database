CREATE TABLE #tblTeste (

IDLOG INT,

IDTABELA INT,

SISTEMALOG XML)

 

INSERT INTO #tblTeste VALUES (1, 1,

'<Log><Insert Codigo="1" Descricao="Carro" Usuario="Marcos"/></Log>')

 

SELECT

IDLOG,

IDTABELA,

SISTEMALOG.value('(/Log/Insert/@Usuario)[1]','nvarchar(20)') As UsuarioXML

FROM #tblTeste

WHERE SISTEMALOG.exist('/Log[@Descricao="Carro"]') = 0

 

DROP TABLE #tblTeste

---------------------------------------------------------------------------------------------
--SQL Base de Conhecimento\Usar tipo XML como parâmetro para Procedure.sql

 DECLARE @xmlCampos xml = '<root><row><CodCliente>1</CodCliente><Mes>10</Mes><Ano>1975</Ano><NomeUsuario>ckacio</NomeUsuario></row>
										  <row><CodCliente>2</CodCliente><Mes>11</Mes><Ano>1976</Ano><NomeUsuario>ckacio1</NomeUsuario></row>
									</root>'
  
  		IF Object_id('tempdb..#tmp_dados', 'U') IS NOT NULL DROP TABLE #tmp_dados

		--Recuperando todos os dados que serão trabalhados
		select  
			col.value('data(CodCliente[1])', 'varchar(200)') as CodCliente
		   ,col.value('data(Mes[1])', 'int') as Mes
		   ,col.value('data(Ano[1])', 'int') as Ano
		   ,col.value('data(NomeUsuario[1])', 'varchar(200)') as NomeUsuario
		   ,CONVERT(varchar(10),null) as MesAno
		   ,CONVERT(varchar(20),null) as CPFCNPJ
		into #tmp_dados
		from    
			@XmlCampos.nodes('/root/row') tbl(col)

--		UPDATE A
--		   SET CPFCNPJ = B.CGC_CPF
--		  FROM #tmp_dados AS A
--		 INNER JOIN AB_INFOBANC..CLIENTES AS B ON(B.CodCliente = A.CodCliente)

		SELECT * FROM #tmp_dados
  

---------------------------------------------------------------------------------------------


DECLARE @XML XML
SET @XML = '
<note>
    <id>1</id>
    <to mail="maria@email.com">maria</to>
    <from mail="ana@email.com">ana</from>
    <heading>Reminder</heading>
    <body>Happy Birthday</body>
    <date>2011-01-01</date>
</note>
<note>
    <id>2</id>
    <to mail="ana@email.com">ana</to>
    <from mail="maria@email.com">maria</from>
    <heading>RE: Reminder</heading>
    <body>Thanks</body>
    <date>2011-01-01</date>
</note>
<note>
    <id>3</id>
    <to mail="maria@email.com">maria</to>
    <from mail="ana@email.com">ana</from>
    <heading>RE: RE: Reminder</heading>
    <body>Party?</body>
    <date>2011-01-02</date>
</note>'

SELECT @XML.value('(note/to)[1]/@mail', 'varchar(45)')


SELECT
 --C.value('id[1]', 'int'),
 --C.value('date[1]', 'date'),
 C.value('from[1]/@mail', 'varchar(25)') --,
 --C.query('to')
 
FROM @XML.nodes('note') AS T(C)


--------------------------------------------------

GO

declare @XML xml
set @XML=
'<ROOT>
	<Customers>
		<CustomerId>1111</CustomerId>
		<CompanyName>Sean Chai</CompanyName>
		<City>NY</City>
	</Customers>
	<Customers>
		<CustomerId>1112</CustomerId>
		<CompanyName>Tom Johnston</CompanyName>
		<City>LA</City>
	</Customers>
	<Customers>
		<CustomerId>1113</CustomerId>
		<CompanyName>Institute of Art</CompanyName>
	</Customers>
</ROOT>';




SELECT
R.Node.value('(CustomerId/.)[1]','varchar(100)') AS CustomerID,
R.Node.value('(CompanyName/.)[1]','varchar(100)') AS CompanyName,
R.Node.value('(City/.)[1]','varchar(100)') AS CityName
FROM @XML.nodes('/ROOT/Customers')  R(Node)


---------------------------------------------------------------
go

declare @XML xml

set @XML = 
'

<vItem>
    <jobScript>
        <node guid="7606bd90-98df-4572-accd-5b41ec5605dc">
            <subNodes>
                <node guid="17f8e275-d4f6-47c0-a5e4-80da658f4097">
                    <execute taskVersionGuid="5fc17d5c-7264-461f-ae38-        
753d703f3c99" />
                </node>
                <node guid="5fe2233c-9e3a-44be-aa20-aea2c8dcbd4a">
                    <execute taskVersionGuid="f55dc069-46ff-427e-920f-    
5f1c3fc3ad09" />
                </node>
                <node guid="ecd6a7b5-a3be-483c-acf8-64ba1c289088">
                    <execute taskVersionGuid="5220d97c-6e8f-400a-b814-
aa7d84942c20" />
                </node>
            </subNodes>
        </node>
    </jobScript>
</vItem>
'
select T.N.query('.')
from @XML.nodes('/vItem/jobScript/node/subNodes/node/execute') as T(N)


----------------------------------------------------------------

create table #temp (id int, name varchar(32), xml_data xml)

insert into #temp values
(1, 'one',   '<data><info x="42" y="99">Red</info><info x="43" y="100">Pink</info></data>'),
(2, 'two',   '<data><info x="27" y="72">Blue</info><info x="28" y="73">Light Blue</info></data>'),
(3, 'three', '<data><info x="16" y="51">Green</info><info x="17" y="52">Orange</info></data>'),
(4, 'four',  '<data><info x="12" y="37">Yellow</info><info x="13" y="38">Purple</info></data>')

select Name
      ,C.value('@x', 'int') as [Info.x]
      ,C.value('@y', 'int') as [Info.y]
      ,C.value('.', 'varchar(10)') as [Info]
from #temp cross apply
     #temp.xml_data.nodes('data/info') as X(C)

drop table #temp

-----------------------------------------------------------
go

DECLARE @xml xml = CONVERT(XML, '<?xml version="1.0" encoding="UTF-8"?>
<alert>
   <hits>
      <elem name="hit">
         <elem name="scoreFactors">
            <elem name="scoreFactors">
               <elem name="factorId">FactorID 1</elem>
               <elem name="factorDesc">FactorDesc 1</elem>
               <elem name="factorValue">FactorValue 1</elem>
               <elem name="factorScore">FactorScore 1</elem>
               <elem name="factorImpact">FactorImpact 1</elem>
            </elem>
            <elem name="scoreFactors">
               <elem name="factorId">FactorID 2</elem>
               <elem name="factorDesc">FactorDesc 2</elem>
               <elem name="factorValue">FactorValue 2</elem>
               <elem name="factorScore">FactorScore 2</elem>
               <elem name="factorImpact">FactorImpact 2</elem>
            </elem>
         </elem>
       </elem>
   </hits>
</alert>')

;WITH Shredded AS
(
    SELECT 
        ElemName = xc.value('@name', 'varchar(50)'),
        ElemValue = xc.value('.', 'varchar(50)') 
    FROM
        @xml.nodes('/alert/hits//elem') AS XT(XC)
)
SELECT *
FROM Shredded
WHERE Shredded.ElemName = 'factorDesc'


----------------------------------------


DECLARE @dadosxml xml = CONVERT(XML, '<DOC xmlns="http://www.cip-bancos.org.br/MES/RRC0019.xsd">
  <BCMSG>
    <IdentdEmissor>290180</IdentdEmissor>
    <IdentdDestinatario>622889</IdentdDestinatario>
    <Grupo_Seq>
      <NumSeq>1</NumSeq>
      <IndrCont>N</IndrCont>
    </Grupo_Seq>
    <DomSist>MES01</DomSist>
    <NUOp>6289108130031782</NUOp>
  </BCMSG>
  <SISMSG>
    <RRC0019R1>
      <CodMsg>RRC0019R1</CodMsg>
      <SitRetReq>002</SitRetReq>
      <IdentdPartPrincipal>622389</IdentdPartPrincipal>
      <IdentdPartAdmtd>622889</IdentdPartAdmtd>
      <IdentdNegcRecbvl>153135</IdentdNegcRecbvl>
      <Grupo_RRC0019R1_NegcRecbvlRecsdo CodErro="ERRC0060">
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01020580191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838000829</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31832800029</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-13</DtPrevtLiquid>
          <VlrTot>23.39</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>23.39</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>3183001124</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>3183001124</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-13</DtPrevtLiquid>
          <VlrTot>26.84</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>26.84</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>        
		<Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01257800104</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31802872</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31302872</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2022-05-17</DtPrevtLiquid>
          <VlrTot>99.16</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>99.16</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
      </Grupo_RRC0019R1_NegcRecbvlRecsdo>
    </RRC0019R1>
  </SISMSG>
</DOC>')


	select  
		x.y.value('local-name(..)', 'VARCHAR(MAX)') parentElementName,
		x.y.value('local-name(.)', 'VARCHAR(MAX)') attributeName,
		x.y.value('.', 'VARCHAR(MAX)') attributeValue 
	from @dadosxml.nodes('//@*') AS x(y)
	where x.y.value('local-name(.)', 'VARCHAR(MAX)')='CodErro'

---------------------------------------------------------------------------------------------

