CREATE OR REPLACE VIEW VIEW_WEIGHBRIDGE_ENGINE AS
SELECT
    v.entity_code,
    v.tcode,
    v.wslipno,
    trunc(v.indate) vrdate,
    v.indate,
    v.outdate,
    v.wb_flag,
    v.acc_code,
    v.acc_remark,
    v.trpt_code,
    v.trpt_remark,
    v.trucktype,
    v.vhcl_type,
    v.truckno,
    v.lrno,
    v.lrdate,
    v.from_place,
    v.to_place,
    v.challanno,
    v.challandate,
    v.rakeno,
    v.tp_book_no,
    v.tp_page_no,
    v.freight_adv,
    v.gate_tcode,
    v.gate_vrno,

 /* (CASE
  WHEN V.cntr_vhcl_no IS NOT NULL THEN NVL(V.NETWT, 0) * 75
  ELSE NVL(V.NETWT, 0) * 150
  END) VARAI,*/

/*  (CASE
    WHEN V.cntr_vhcl_no IS NOT NULL THEN NVL(V.NETWT, 0) * 75
    WHEN V.ITEM_CODE IN ('B01030001', 'B01040001') THEN NVL(V.NETWT, 0) * 40
    ELSE NVL(V.NETWT, 0) * 150
END) VARAI,*/
(CASE
        WHEN V.cntr_vhcl_no IS NOT NULL THEN NVL(V.NETWT, 0) * 80
        WHEN V.ITEM_CODE IN ('B01030001', 'B01040001','B01060001','R01050019') THEN NVL(V.NETWT, 0) * 160
        WHEN V.ACC_CODE = 'FOM04' THEN NVL(V.NETWT, 0) * 40
        WHEN V.ACC_CODE = 'DRA01' THEN NVL(V.NETWT, 0) * 40
        ELSE NVL(V.NETWT, 0) * 160
     END) VARAI,



----    NVL(V.NETWT*160,0) VARAI,
    (SELECT VRDATE FROM gatetran_head WHERE ENTITY_CODE = v.entity_code AND VRNO = v.gate_vrno) AS GATE_INDATE,
    (SELECT OUTDATE FROM gatetran_head WHERE ENTITY_CODE = v.entity_code AND VRNO = v.gate_vrno) AS GATE_OUTDATE,
    (SELECT CONTRACT_VRNO FROM ORDER_BODY WHERE ENTITY_CODE = v.entity_code AND TCODE = v.order_tcode
        AND VRNO = v.order_vrno AND AMENDNO = v.order_amendno AND SLNO = v.order_slno) AS CONTRACT_VRNO,
    NVL((SELECT SUM(NVL(l.qtyorder, 0)) FROM order_body l WHERE l.ENTITY_CODE = v.entity_code AND l.vrno = (SELECT CONTRACT_VRNO FROM ORDER_BODY WHERE ENTITY_CODE = v.entity_code AND TCODE = v.order_tcode
        AND VRNO = v.order_vrno AND AMENDNO = v.order_amendno AND SLNO = v.order_slno)), 0) AS CONTRACT_qty,
    v.approvedby,
    v.approveddate,
    v.ref_no1,
    v.ref_no2,
    v.ref_no3,
    v.slno,
    v.div_code,
    v.order_tcode,
    v.order_vrno,
    v.order_amendno,
    v.order_slno,
    v.item_catg,
    v.item_code,
    v.make_code,
    v.item_remark,
    v.firstwt,
    v.secondwt,
    v.netwt,
    v.partygrosswt,
    v.partytearwt,
    v.partynetwt,
    v.godown_code,
    v.cntr_code,
    v.cntr_remark,
    v.process_code,
    v.process_remark,
    v.qc_vrno,
    v.firstwt_wbno,
    v.secondwt_wbno,
    v.item_tcode,
    v.item_vrno,
    v.item_slno,
    v.user_code,
    v.user_code2,
    v.aqty,
    v.aum,
    v.book_initial,
    v.cntr_item_tcode,
    v.cntr_item_vrno,
    v.cntr_vhcl_no,
    v.container_tear_wt,
    v.flag,
    v.gate_lastupdate,
    v.gate_remark,
    v.gate_user_code,
    v.item_condition,
    v.lastupdate,
    v.lastupdate2,
    v.no_of_weights,
    v.process_qty,
    v.slip_no,
    m.item_nature,
    m.item_name,
    m.item_detail,
    m.shortname,
    m.item_status,
    m.item_sch,
    m.item_class,
    m.item_group,
    m.parent_code,
    m.excise_tariff_code,
    m.item_size,
    m.ssg_parent_code,
    m.sg_parent_code,
    m.g_parent_code,
    NVL((SELECT 'Y' FROM itemtran_head h WHERE h.entity_code = v.entity_code AND h.wslipno = v.wslipno AND ROWNUM = 1), 'N') AS used_flag,
    (SELECT acc_year FROM acc_year_mast WHERE entity_code = v.entity_code AND trunc(v.indate) BETWEEN yrbegdate AND yrenddate) AS acc_year,
    (SELECT w.tname FROM view_weighbridge_tcode w WHERE tcode = substr(v.wslipno, 1, 1)) AS bheading,
    (SELECT w.TCODE || ' - ' || w.TNAME FROM view_weighbridge_tcode w WHERE tcode = substr(v.wslipno, 1, 1)) AS WEIGHT_FOR
FROM
    view_weighbridge_tran v
    LEFT JOIN view_item_mast m ON v.item_code = m.item_code

