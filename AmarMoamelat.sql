use auction;
--select count(*)
SELECT xContractShom,
	   [bCustomerContractId],
	   [xTalarMatchingTarSabt],
	   bcustomercontractarzesh,
	   [xVahedAndazehGiriSharh],
	   [xVahedAndazehGiriZarib],
	   txTalarReport.xTalarReportVaznKala / 1000 * xVahedAndazehGiriZarib As VaznTon,
	   [xContractMab],
	   xVahedArzSharh,
	   kharid.cBrokerSpcName As [BrokerKharidName],
	   Foroush.cBrokerSpcName As [BrokerForushName],
	   [bCustomerContractTedad],
	   buyerCustomer.cCustomerSpcNam,
	   dbo.tbCustomerContract.bCustomerContractTedad * dbo.txTalarMatching.xTalarMatchingVaznKala AS Hajm,
	   buyerCustomer.[cCustomerSpcNooSharh],
	   [bCustomerContractClearingKindSharh],
	   [bCustomerContractTarMohlatTasvieh] AS xContractTarMohlatTasvieh,
	   [bCustomerContractTarTasviehNahaei],
	   bCustomerContractTarTasviehNahaei As TakhirTasvieh,
	   txContractKind.[xContractKindSharh],
       ISNULL(txTolidKonandeh.xTolidKonandehSharh, N'نامشخص') AS ArzehKonandehSharh, 
	   buyerCustomer.cCustomerSpcCS2ShenaseMeli As ArzehKonandehCodeMeli,
	   [bHamlSharh],
	   [xTalarMatchingNooTahvilSharh],
	   [xMahalTahvilSharh],
	   [xTalarMatchingTarTahvil],
       txKala.xKalaNamTejari, 
	   [bCustomerContractTar],
       txNamad.xNamadNamadMoamelati, 
	   txGrouhKala.xGrouhKalaSharh,
	   txZirGrouhKala.xZirGrouhKalaSharh,
	   [xGrouhAsliKalaSharh],
	   [bCustomerContractZaribKarmozdKK],
	   [bCustomerContractZaribKarmozdKF],
	   [bCustomerContractZaribKarmozdBF] + [bCustomerContractZaribKarmozdBK] AS bCustomerContractZaribKarmozdB,
	   [bCustomerContractZaribKarmozdSF] + [bCustomerContractZaribKarmozdSK] As bCustomerContractZaribKarmozdS,
	   [bCustomerContractZaribMaliatBF] + [bCustomerContractZaribMaliatBK] AS Maliat,
	   [bCustomerContractZaribKarmozdHaqhDarj] AS HaghDarj,
	   [xCalendarRooz],
	   [bCustomerContractKanlamSharh],
	   sellerCustomer.[cCustomerSpcTar],
	   cArzehKonandehId As ArzehKonandehCode,
	   [tBranchSpcName],
	   '' AS bArzehKindSharh,
	   TenderInfoPK As bArzehRadifPK

FROM dbo.txTalarReport
  Inner JOIN dbo.tblTender WITH(NOLOCK) ON txTalarReport.xTalarReportPK = tblTender_xTalarReportPK
     LEFT  JOIN dbo.txTalarMatching WITH(NOLOCK) ON  (txTalarMatching.xTalarMatching_bArzehRadifPK * -1) = tblTender.TenderInfoPK 
     INNER JOIN dbo.txContractKind  WITH(NOLOCK) ON xTalarReport_xContractKindPK = txContractKind.xContractKindPK
  ----   LEFT OUTER JOIN dbo.txContractKind WITH(NOLOCK) ON txContractKind.xContractKindPK=tblTender.tblTender_xContractKindPK
     INNER JOIN dbo.txNamad WITH(NOLOCK) ON txTalarReport.xTalarReport_xNamadPK = txNamad.xNamadPK
     INNER JOIN dbo.txKala WITH(NOLOCK) ON txNamad.xNamad_xKalaPK = txKala.xKalaPK
     INNER JOIN dbo.txMahalTahvil WITH(NOLOCK) ON txNamad.xNamad_xMahalTahvilPK = txMahalTahvil.xMahalTahvilPK
     INNER JOIN dbo.txGrouhKala WITH(NOLOCK) ON txKala.xKala_xGrouhKalaPK = txGrouhKala.xGrouhKalaPK
     LEFT  JOIN dbo.txTolidKonandeh WITH(NOLOCK) ON txNamad.xNamad_xTolidKonandehPK = txTolidKonandeh.xTolidKonandehPK
     INNER JOIN dbo.txGrouhAsliKala WITH(NOLOCK) ON txKala.xKala_xGrouhAsliKalaPK = txGrouhAsliKala.xGrouhAsliKalaPK
     INNER JOIN dbo.txZirGrouhKala WITH(NOLOCK) ON txKala.xKala_xZirGrouhKalaPK = txZirGrouhKala.xZirGrouhKalaPK
     LEFT  JOIN vxAuctionBasketDetail WITH(NOLOCK) ON vxAuctionBasketDetail.xNamadRadif_xSabadKalaPK = txTalarReport.xTalarReport_xNamadPK
     LEFT  JOIN dbo.tcNerkhArz WITH(NOLOCK) ON tcNerkhArz.cNerkhArz_xVahedArzPK = txTalarReport.xTalarReport_xVahedArzPK
                                                    AND tcNerkhArz.cNerkhArzTarNerkh = txTalarReport.xTalarReportTar
     LEFT  JOIN dbo.txContract WITH(NOLOCK) ON txTalarMatching.xTalarMatchingPK = txContract.xContract_xTalarMatchingPK
     INNER JOIN dbo.txVahedAndazehGiri WITH(NOLOCK) ON txVahedAndazehGiri.xVahedAndazehGiriPK = txKala.xKala_xVahedAndazehGiriPK
     LEFT  JOIN dbo.tcArzehKonandeh WITH(NOLOCK) ON tblTender_cArzehKonandehPK = dbo.tcArzehKonandeh.cArzehKonandehPK
     LEFT  JOIN dbo.tcCustomerSpc as buyerCustomer WITH(NOLOCK) ON dbo.tcArzehKonandeh.cArzehKonandeh_cCustomerSpcPK = buyerCustomer.cCustomerSpcPK
     LEFT  JOIN dbo.txVahedArz WITH(NOLOCK) ON txContractKind.xContractKind_xVahedArzPK = xVahedArzPK
     INNER JOIN dbo.txRing WITH(NOLOCK) ON tblTender_xRingPK = xRingPK
	 INNER JOIN tbArzehKind with(nolock) on bArzehKindPK=tblTender.tblTender_bArzehKindPK
	 LEFT  JOIN tbCustomerContract on tbCustomerContract.bCustomerContract_xContractPK = txContract.xContractPK
	 LEFT  JOIN tcCustomerSpc as sellerCustomer on sellerCustomer.cCustomerSpcPK=tbCustomerContract.bCustomerContract_cCustomerSpcPK
	 INNER JOIN tcBrokerSpc As Kharid on kharid.cBrokerSpcPK = tblTender.tblTender_cBrokerSpcPK
	 LEFT JOIN tcBrokerSpc As Foroush on Foroush.cBrokerSpcPK = txTalarMatching.xTalarMatching_cBrokerForushPK
	 LEFT JOIN tbCustomerContractZarib on tbCustomerContractZarib.bCustomerContractZarib_bCustomerContractPK = tbCustomerContract.bCustomerContractPK
	 LEFT JOIN txBranchSpc on txBranchSpc.tBranchSpcPK = tbCustomerContract.bCustomerContract_BranchSpcPK
	 LEFT JOIN tbHaml on bHamlPK=bCustomerContract_bHamlPK
	 LEFT JOIN dbo.txCalendar ON dbo.tbCustomerContract.bCustomerContractTarTasviehNahaei = dbo.txCalendar.xCalendarTarShamsi
	 WHERE(txTalarReport.xTalarReportTar >= '1399/11/01')



  --   AND (txTalarReport.xTalarReportJamTedadKharid > 0)
  --   AND ISNULL(xTalarMatchingImport, 1) = 1
  --   AND dbo.txContractKind.xContractKindPK <> 29
	 --AND tblTender_xRingPK<>18

--UNION
--SELECT xContractShom,
--	   [bCustomerContractId],
--	   [xTalarMatchingTarSabt],
--	   bcustomercontractarzesh,
--	   [xVahedAndazehGiriSharh],
--	   [xVahedAndazehGiriZarib],
--	   txTalarReport.xTalarReportVaznKala / 1000 * xVahedAndazehGiriZarib As VaznTon,
--	   [xContractMab],
--	   xVahedArzSharh,
--	   kharid.cBrokerSpcName As [BrokerKharidName],
--	   Foroush.cBrokerSpcName As [BrokerForushName],
--	   [bCustomerContractTedad],
--	   buyerCustomer.cCustomerSpcNam,
--	   dbo.tbCustomerContract.bCustomerContractTedad * dbo.txTalarMatching.xTalarMatchingVaznKala AS Hajm,
--	   buyerCustomer.[cCustomerSpcNooSharh],
--	   [bCustomerContractClearingKindSharh],
--	   [bCustomerContractTarMohlatTasvieh] AS xContractTarMohlatTasvieh,
--	   [bCustomerContractTarTasviehNahaei],
--	   bCustomerContractTarTasviehNahaei As TakhirTasvieh,
--	   txContractKind.[xContractKindSharh],
--       ISNULL(txTolidKonandeh.xTolidKonandehSharh, N'نامشخص') AS ArzehKonandehSharh, 
--	   buyerCustomer.cCustomerSpcCS2ShenaseMeli As ArzehKonandehCodeMeli,
--	   [bHamlSharh],
--	   [xTalarMatchingNooTahvilSharh],
--	   [xMahalTahvilSharh],
--	   [xTalarMatchingTarTahvil],
--       txKala.xKalaNamTejari, 
--	   [bCustomerContractTar],
--       txNamad.xNamadNamadMoamelati,
--	   txGrouhKala.xGrouhKalaSharh,
--	   txZirGrouhKala.xZirGrouhKalaSharh,
--	   [xGrouhAsliKalaSharh],
--	   [bCustomerContractZaribKarmozdKK],
--	   [bCustomerContractZaribKarmozdKF],
--	   [bCustomerContractZaribKarmozdBF] + [bCustomerContractZaribKarmozdBK] AS bCustomerContractZaribKarmozdB,
--	   [bCustomerContractZaribKarmozdSF] + [bCustomerContractZaribKarmozdSK] As bCustomerContractZaribKarmozdS,
--	   [bCustomerContractZaribMaliatBF] + [bCustomerContractZaribMaliatBK] AS Maliat,
--	   [bCustomerContractZaribKarmozdHaqhDarj] AS HaghDarj,
--	   [xCalendarRooz],
--	   [bCustomerContractKanlamSharh],
--	   sellerCustomer.[cCustomerSpcTar],
--	   cArzehKonandehId As ArzehKonandehCode,
--	   [tBranchSpcName],
--	   '' AS bArzehKindSharh,
--	   TenderInfoPK As bArzehRadifPK
--	   --bArzehKindSharh,
--	   --bArzehRadifPK

--FROM dbo.txTalarMatching
--     --INNER JOIN dbo.txContractKind WITH(NOLOCK) ON txTalarMatching.xTalarMatching_xContractKindPK = txContractKind.xContractKindPK
--     INNER JOIN dbo.txNamad WITH(NOLOCK) ON txTalarMatching.xTalarMatching_xNamadPK = txNamad.xNamadPK
--     INNER JOIN dbo.txKala WITH(NOLOCK) ON txNamad.xNamad_xKalaPK = txKala.xKalaPK
--     INNER JOIN dbo.txMahalTahvil WITH(NOLOCK) ON txNamad.xNamad_xMahalTahvilPK = txMahalTahvil.xMahalTahvilPK
--     LEFT OUTER JOIN dbo.txTolidKonandeh WITH(NOLOCK) ON txNamad.xNamad_xTolidKonandehPK = txTolidKonandeh.xTolidKonandehPK
--     LEFT OUTER JOIN dbo.txContract WITH(NOLOCK) ON txTalarMatching.xTalarMatchingPK = txContract.xContract_xTalarMatchingPK
--     INNER JOIN dbo.txVahedAndazehGiri WITH(NOLOCK) ON txVahedAndazehGiri.xVahedAndazehGiriPK = txKala.xKala_xVahedAndazehGiriPK
--     INNER JOIN dbo.txGrouhAsliKala WITH(NOLOCK) ON txKala.xKala_xGrouhAsliKalaPK = txGrouhAsliKala.xGrouhAsliKalaPK
--     INNER JOIN dbo.txZirGrouhKala WITH(NOLOCK) ON txKala.xKala_xZirGrouhKalaPK = txZirGrouhKala.xZirGrouhKalaPK
--     INNER JOIN dbo.txGrouhKala WITH(NOLOCK) ON txKala.xKala_xGrouhKalaPK = txGrouhKala.xGrouhKalaPK
--     LEFT OUTER JOIN vxAuctionBasketDetail WITH(NOLOCK) ON vxAuctionBasketDetail.xNamadRadif_xSabadKalaPK = txTalarMatching.xTalarMatching_xNamadPK
--     INNER JOIN dbo.tblTender WITH(NOLOCK) ON txTalarMatching.xTalarMatching_bArzehRadifPK = (TenderInfoPK * -1)
--	 Left Join dbo.txTalarReport WITH(NOLOCK) ON txTalarReport.xTalarReportPK = tblTender_xTalarReportPK
--     LEFT OUTER JOIN dbo.tcArzehKonandeh WITH(NOLOCK) ON cArzehKonandehPK = tblTender_cArzehKonandehPK
--     LEFT OUTER JOIN dbo.tcCustomerSpc as buyerCustomer WITH(NOLOCK) ON dbo.tcArzehKonandeh.cArzehKonandeh_cCustomerSpcPK = buyerCustomer.cCustomerSpcPK
--	 inner join txContractKind on txContractKind.xContractKindPK=tblTender.tblTender_xContractKindPK
--     LEFT OUTER JOIN dbo.txVahedArz WITH(NOLOCK) ON txContractKind.xContractKind_xVahedArzPK = xVahedArzPK
--     LEFT OUTER JOIN dbo.tcNerkhArz WITH(NOLOCK) ON tcNerkhArz.cNerkhArz_xVahedArzPK = xContractKind_xVahedArzPK
--                                                    AND tcNerkhArz.cNerkhArzTarNerkh = txTalarMatching.xTalarMatchingTarSabt
--     INNER JOIN dbo.txRing WITH(NOLOCK) ON tblTender_xRingPK = xRingPK
--	 inner join tbArzehKind with(nolock) on bArzehKindPK=tblTender.tblTender_bArzehKindPK
--	 inner Join tbCustomerContract on tbCustomerContract.bCustomerContract_xContractPK = txContract.xContractPK
--	 inner join tcBrokerSpc As Kharid on kharid.cBrokerSpcPK = txTalarMatching.xTalarMatching_cBrokerKharidPK
--	 inner join tcBrokerSpc As Foroush on Foroush.cBrokerSpcPK = txTalarMatching.xTalarMatching_cBrokerForushPK
--	 inner join tbCustomerContractZarib on tbCustomerContractZarib.bCustomerContractZarib_bCustomerContractPK = tbCustomerContract.bCustomerContractPK
--	 inner join txBranchSpc on txBranchSpc.tBranchSpcPK = tbCustomerContract.bCustomerContract_BranchSpcPK
--	 inner join tcCustomerSpc as sellerCustomer on sellerCustomer.cCustomerSpcPK=tbCustomerContract.bCustomerContract_cCustomerSpcPK
--	 left join tbHaml on bHamlPK=bCustomerContract_bHamlPK
--	 LEFT OUTER JOIN dbo.txCalendar ON dbo.tbCustomerContract.bCustomerContractTarTasviehNahaei = dbo.txCalendar.xCalendarTarShamsi
--	 --left join tbArzeh on tbArzeh.bArzeh_cArzehKonandehPK = tcArzehKonandeh.cArzehKonandehPK
--	 --inner join tbArzehRadif on tbArzehRadif.bArzehRadif_bArzehPK = tbArzeh.bArzehPK
--WHERE(xTalarMatchingTarSabt >= '1399/11/01')
--     --AND (xContractKindGrouhId = 1)
--     AND (xTalarMatchingId IN(6,7))
--     AND ISNULL(xTalarMatchingImport, 1) = 1
--     AND dbo.txContractKind.xContractKindPK <> 29
--	 AND tblTender_xRingPK<>18



--SELECT * FROM tblTender WHERE tblTender_xTalarReportPK <=0
