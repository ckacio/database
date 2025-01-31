DECLARE @xmldata XML
--SELECT @xmldata = CAST(CORPO AS XML) FROM AB_RCP..CORPO_MENSAGENS_RRC WHERE NSU_MENS = '62232889202108130031782R1'

--SELECT * FROM AB_RCP..CORPO_MENSAGENS_RRC WHERE NSU_MENS LIKE '62232889202108130031782%'

SELECT @xmldata =
'<DOC xmlns="http://www.cip-bancos.org.br/MES/RRC0019.xsd">
  <BCMSG>
    <IdentdEmissor>29011780</IdentdEmissor>
    <IdentdDestinatario>62232889</IdentdDestinatario>
    <Grupo_Seq>
      <NumSeq>1</NumSeq>
      <IndrCont>N</IndrCont>
    </Grupo_Seq>
    <DomSist>MES01</DomSist>
    <NUOp>62232889202108130031782</NUOp>
  </BCMSG>
  <SISMSG>
    <RRC0019R1>
      <CodMsg>RRC0019R1</CodMsg>
      <SitRetReq>002</SitRetReq>
      <IdentdPartPrincipal>62232889</IdentdPartPrincipal>
      <IdentdPartAdmtd>62232889</IdentdPartAdmtd>
      <IdentdNegcRecbvl>15377135</IdentdNegcRecbvl>
      <Grupo_RRC0019R1_NegcRecbvlRecsdo CodErro="ERRC0060">
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128000829</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128000829</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-13</DtPrevtLiquid>
          <VlrTot>23.39</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>23.39</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001124</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001124</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-13</DtPrevtLiquid>
          <VlrTot>26.84</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>26.84</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001124</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001124</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-21</DtPrevtLiquid>
          <VlrTot>595.78</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>595.78</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001124</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001124</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-10-11</DtPrevtLiquid>
          <VlrTot>26.83</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>26.83</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001124</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001124</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-10-21</DtPrevtLiquid>
          <VlrTot>390.08</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>390.08</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-08</DtPrevtLiquid>
          <VlrTot>246.24</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>246.24</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-09</DtPrevtLiquid>
          <VlrTot>2751.97</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>2751.97</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-10</DtPrevtLiquid>
          <VlrTot>523.57</VlrTot>
          <VlrComprtdOutrInst>25.42</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>498.15</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-13</DtPrevtLiquid>
          <VlrTot>153.82</VlrTot>
          <VlrComprtdOutrInst>145.39</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>8.43</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-16</DtPrevtLiquid>
          <VlrTot>141.99</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>141.99</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01027058000191</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128001205</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128001205</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2021-09-20</DtPrevtLiquid>
          <VlrTot>241.10</VlrTot>
          <VlrComprtdOutrInst>134.71</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>106.39</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01425787000104</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128002872</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128002872</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2022-03-17</DtPrevtLiquid>
          <VlrTot>225.57</VlrTot>
          <VlrComprtdOutrInst>126.41</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>99.16</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01425787000104</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128002872</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128002872</CNPJ_CPFTitular>
          <CodInstitdrArrajPgto>003</CodInstitdrArrajPgto>
          <DtPrevtLiquid>2022-04-18</DtPrevtLiquid>
          <VlrTot>99.16</VlrTot>
          <VlrComprtdOutrInst>0.00</VlrComprtdOutrInst>
          <VlrComprtdInst>0.00</VlrComprtdInst>
          <VlrLivreTot>99.16</VlrLivreTot>
        </Grupo_RRC0019R1_UniddRecbvlDisp>
        <Grupo_RRC0019R1_UniddRecbvlDisp>
          <CNPJCreddrSub>01425787000104</CNPJCreddrSub>
          <CNPJ_CPFUsuFinalRecbdr>31838128002872</CNPJ_CPFUsuFinalRecbdr>
          <CNPJ_CPFTitular>31838128002872</CNPJ_CPFTitular>
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
</DOC>'


DECLARE @hDoc INT  
DECLARE @PrepareXmlStatus INT  

EXEC @PrepareXmlStatus= sp_xml_preparedocument @hDoc OUTPUT, @xmldata,  N'<root xmlns:d="http://www.cip-bancos.org.br/MES/RRC0019.xsd" xmlns:e="http://www.cip-bancos.org.br/MES/RRC0019.xsd"/>';

SELECT  CNPJCreddrSub,
		CNPJ_CPFUsuFinalRecbdr,
		CNPJ_CPFTitular,
		CodInstitdrArrajPgto,
		DtPrevtLiquid,
		SUM(VlrTot) AS VlrTot,
		SUM(VlrComprtdOutrInst) AS VlrComprtdOutrInst,
		SUM(VlrComprtdInst) AS VlrComprtdInst,
		SUM(VlrLivreTot) AS VlrLivreTot
FROM    OPENXML(@hDoc,  N'/d:DOC/d:SISMSG/d:RRC0019R1/d:Grupo_RRC0019R1_NegcRecbvlRecsdo/d:Grupo_RRC0019R1_UniddRecbvlDisp')  
    WITH   (
	CNPJCreddrSub varchar(MAX) 'd:CNPJCreddrSub',
	CNPJ_CPFUsuFinalRecbdr varchar(MAX) 'd:CNPJ_CPFUsuFinalRecbdr',
    CNPJ_CPFTitular VARCHAR(MAX) 'd:CNPJ_CPFTitular',
    CodInstitdrArrajPgto VARCHAR(MAX) 'd:CodInstitdrArrajPgto',
    DtPrevtLiquid DATETIME 'd:DtPrevtLiquid',
    VlrTot NUMERIC(12,2) 'd:VlrTot',
	VlrComprtdOutrInst NUMERIC(12,2) 'd:VlrComprtdOutrInst',
	VlrComprtdInst  NUMERIC(12,2) 'd:VlrComprtdInst',
	VlrLivreTot NUMERIC(12,2) 'd:VlrLivreTot'
    )  
GROUP BY
	CNPJCreddrSub,
	CNPJ_CPFUsuFinalRecbdr,
    CNPJ_CPFTitular,
    CodInstitdrArrajPgto,
    DtPrevtLiquid
ORDER BY
	CNPJ_CPFUsuFinalRecbdr,
	DtPrevtLiquid

EXEC sp_xml_removedocument @hDoc
