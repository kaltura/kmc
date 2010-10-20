package com.kaltura.utils
{
	import com.kaltura.dataStructures.HashMap;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	
	/**
	 * Singleton class 
	 * This util class handles all issues related to Countries UI - flags(images) and Locale(names)
	 * 
	 * 
	 */
	public class KCountriesUtil
	{
		private static var _instance:KCountriesUtil = null;
		private var countriesArr:ArrayCollection = new ArrayCollection();
		private var countriesMap:HashMap = new HashMap();
		private var countriesFlagsMap:HashMap = new HashMap();
		private var countriesLocationInMap:HashMap = new HashMap();
		
		[ResourceBundle("countries")]
		private static var rb:ResourceBundle;

		/***
		 * Embedding the flags images
		 * 
		 */

		[Embed(source="/com/kaltura/assets/images/flags/af.gif")]
		private static const _af:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/al.gif")]
		private static const _al:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/dz.gif")]
		private static const _dz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/as.gif")]
		private static const _as:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ad.gif")]
		private static const _ad:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ao.gif")]
		private static const _ao:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ai.gif")]
		private static const _ai:Class;
		
	 	[Embed(source="/com/kaltura/assets/images/flags/aq.gif")]
		private static const _aq:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/ag.gif")]
		private static const _ag:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ar.gif")]
		private static const _ar:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/am.gif")]
		private static const _am:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/aw.gif")]
		private static const _aw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ac.gif")]
		private static const _ac:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/au.gif")]
		private static const _au:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/at.gif")]
		private static const _at:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/az.gif")]
		private static const _az:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bs.gif")]
		private static const _bs:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bh.gif")]
		private static const _bh:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bd.gif")]
		private static const _bd:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bb.gif")]
		private static const _bb:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/by.gif")]
		private static const _by:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/be.gif")]
		private static const _be:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bz.gif")]
		private static const _bz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bj.gif")]
		private static const _bj:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bm.gif")]
		private static const _bm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bt.gif")]
		private static const _bt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bo.gif")]
		private static const _bo:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ba.gif")]
		private static const _ba:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bw.gif")]
		private static const _bw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bv.gif")]
		private static const _bv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/br.gif")]
		private static const _br:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/io.gif")]
		private static const _io:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bn.gif")]
		private static const _bn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bg.gif")]
		private static const _bg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bf.gif")]
		private static const _bf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/bi.gif")]
		private static const _bi:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kh.gif")]
		private static const _kh:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cm.gif")]
		private static const _cm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ca.gif")]
		private static const _ca:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cv.gif")]
		private static const _cv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ky.gif")]
		private static const _ky:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cf.gif")]
		private static const _cf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/td.gif")]
		private static const _td:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cl.gif")]
		private static const _cl:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cn.gif")]
		private static const _cn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cx.gif")]
		private static const _cx:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cc.gif")]
		private static const _cc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/co.gif")]
		private static const _co:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/km.gif")]
		private static const _km:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cg.gif")]
		private static const _cg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cd.gif")]
		private static const _cd:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ck.gif")]
		private static const _ck:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cr.gif")]
		private static const _cr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ci.gif")]
		private static const _ci:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/hr.gif")]
		private static const _hr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cu.gif")]
		private static const _cu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cy.gif")]
		private static const _cy:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/cz.gif")]
		private static const _cz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/dk.gif")]
		private static const _dk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/dj.gif")]
		private static const _dj:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/dm.gif")]
		private static const _dm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/do.gif")]
		private static const _do:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ec.gif")]
		private static const _ec:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/eg.gif")]
		private static const _eg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sv.gif")]
		private static const _sv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gq.gif")]
		private static const _gq:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/er.gif")]
		private static const _er:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ee.gif")]
		private static const _ee:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/et.gif")]
		private static const _et:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fk.gif")]
		private static const _fk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fo.gif")]
		private static const _fo:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fj.gif")]
		private static const _fj:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fi.gif")]
		private static const _fi:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fr.gif")]
		private static const _fr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gf.gif")]
		private static const _gf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pf.gif")]
		private static const _pf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tf.gif")]
		private static const _tf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ga.gif")]
		private static const _ga:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gm.gif")]
		private static const _gm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ge.gif")]
		private static const _ge:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/de.gif")]
		private static const _de:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gh.gif")]
		private static const _gh:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gi.gif")]
		private static const _gi:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gr.gif")]
		private static const _gr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gl.gif")]
		private static const _gl:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gd.gif")]
		private static const _gd:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gp.gif")]
		private static const _gp:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gu.gif")]
		private static const _gu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gt.gif")]
		private static const _gt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gg.gif")]
		private static const _gg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gn.gif")]
		private static const _gn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gw.gif")]
		private static const _gw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gy.gif")]
		private static const _gy:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ht.gif")]
		private static const _ht:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/hm.gif")]
		private static const _hm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/hn.gif")]
		private static const _hn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/hk.gif")]
		private static const _hk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/hu.gif")]
		private static const _hu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/is.gif")]
		private static const _is:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/in.gif")]
		private static const _in:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/id.gif")]
		private static const _id:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ir.gif")]
		private static const _ir:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/iq.gif")]
		private static const _iq:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ie.gif")]
		private static const _ie:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/im.gif")]
		private static const _im:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/il.gif")]
		private static const _il:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/it.gif")]
		private static const _it:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/jm.gif")]
		private static const _jm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/jp.gif")]
		private static const _jp:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/je.gif")]
		private static const _je:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/jo.gif")]
		private static const _jo:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kz.gif")]
		private static const _kz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ke.gif")]
		private static const _ke:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ki.gif")]
		private static const _ki:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kr.gif")]
		private static const _kr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kw.gif")]
		private static const _kw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kg.gif")]
		private static const _kg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/la.gif")]
		private static const _la:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lv.gif")]
		private static const _lv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lb.gif")]
		private static const _lb:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ls.gif")]
		private static const _ls:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lr.gif")]
		private static const _lr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ly.gif")]
		private static const _ly:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/li.gif")]
		private static const _li:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lt.gif")]
		private static const _lt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lu.gif")]
		private static const _lu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mo.gif")]
		private static const _mo:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mk.gif")]
		private static const _mk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mg.gif")]
		private static const _mg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mw.gif")]
		private static const _mw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/my.gif")]
		private static const _my:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mv.gif")]
		private static const _mv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ml.gif")]
		private static const _ml:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mt.gif")]
		private static const _mt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mh.gif")]
		private static const _mh:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mq.gif")]
		private static const _mq:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mr.gif")]
		private static const _mr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mu.gif")]
		private static const _mu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/yt.gif")]
		private static const _yt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mx.gif")]
		private static const _mx:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/fm.gif")]
		private static const _fm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/md.gif")]
		private static const _md:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mc.gif")]
		private static const _mc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mn.gif")]
		private static const _mn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ms.gif")]
		private static const _ms:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ma.gif")]
		private static const _ma:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mz.gif")]
		private static const _mz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mm.gif")]
		private static const _mm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/na.gif")]
		private static const _na:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nr.gif")]
		private static const _nr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/np.gif")]
		private static const _np:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nl.gif")]
		private static const _nl:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/an.gif")]
		private static const _an:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nc.gif")]
		private static const _nc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nz.gif")]
		private static const _nz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ni.gif")]
		private static const _ni:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ne.gif")]
		private static const _ne:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ng.gif")]
		private static const _ng:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nu.gif")]
		private static const _nu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/nf.gif")]
		private static const _nf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kp.gif")]
		private static const _kp:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/mp.gif")]
		private static const _mp:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/no.gif")]
		private static const _no:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/om.gif")]
		private static const _om:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pk.gif")]
		private static const _pk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pw.gif")]
		private static const _pw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ps.gif")]
		private static const _ps:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pa.gif")]
		private static const _pa:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pg.gif")]
		private static const _pg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/py.gif")]
		private static const _py:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pe.gif")]
		private static const _pe:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ph.gif")]
		private static const _ph:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pn.gif")]
		private static const _pn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pl.gif")]
		private static const _pl:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pt.gif")]
		private static const _pt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pr.gif")]
		private static const _pr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/qa.gif")]
		private static const _qa:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/re.gif")]
		private static const _re:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ro.gif")]
		private static const _ro:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ru.gif")]
		private static const _ru:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/rw.gif")]
		private static const _rw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ws.gif")]
		private static const _ws:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sm.gif")]
		private static const _sm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/st.gif")]
		private static const _st:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sa.gif")]
		private static const _sa:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sn.gif")]
		private static const _sn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/yu.gif")]
		private static const _yu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sc.gif")]
		private static const _sc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sl.gif")]
		private static const _sl:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sg.gif")]
		private static const _sg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sk.gif")]
		private static const _sk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/si.gif")]
		private static const _si:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sb.gif")]
		private static const _sb:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/so.gif")]
		private static const _so:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/za.gif")]
		private static const _za:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/gs.gif")]
		private static const _gs:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/es.gif")]
		private static const _es:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lk.gif")]
		private static const _lk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sh.gif")]
		private static const _sh:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/kn.gif")]
		private static const _kn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/lc.gif")]
		private static const _lc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/pm.gif")]
		private static const _pm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/vc.gif")]
		private static const _vc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sd.gif")]
		private static const _sd:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sr.gif")]
		private static const _sr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sj.gif")]
		private static const _sj:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sz.gif")]
		private static const _sz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/se.gif")]
		private static const _se:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ch.gif")]
		private static const _ch:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/sy.gif")]
		private static const _sy:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tw.gif")]
		private static const _tw:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tj.gif")]
		private static const _tj:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tz.gif")]
		private static const _tz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/th.gif")]
		private static const _th:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tp.gif")]
		private static const _tp:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/tg.gif")]
		private static const _tg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tk.gif")]
		private static const _tk:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/to.gif")]
		private static const _to:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tt.gif")]
		private static const _tt:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ta.gif")]
		private static const _ta:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tn.gif")]
		private static const _tn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tr.gif")]
		private static const _tr:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tm.gif")]
		private static const _tm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tc.gif")]
		private static const _tc:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/tv.gif")]
		private static const _tv:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ug.gif")]
		private static const _ug:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ua.gif")]
		private static const _ua:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ae.gif")]
		private static const _ae:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/uk.gif")]
		private static const _uk:Class; 
		
		[Embed(source="/com/kaltura/assets/images/flags/us.gif")]
		private static const _us:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/um.gif")]
		private static const _um:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/uy.gif")]
		private static const _uy:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/uz.gif")]
		private static const _uz:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/vu.gif")]
		private static const _vu:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/va.gif")]
		private static const _va:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ve.gif")]
		private static const _ve:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/vn.gif")]
		private static const _vn:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/vi.gif")]
		private static const _vi:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/vg.gif")]
		private static const _vg:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/wf.gif")]
		private static const _wf:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/ye.gif")]
		private static const _ye:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/zm.gif")]
		private static const _zm:Class;
		
		[Embed(source="/com/kaltura/assets/images/flags/zw.gif")]
		private static const _zw:Class;

    	
		/**
		 * Constructor
		 */
		public function KCountriesUtil(enforcer:Enforcer)
		{
			initCountriesArray(countriesArr);
			initCountriesMaps();
			initCountriesFlagsMap();
		}
		
		/**
		 * Singleton instance
		 * 
		 */
		public static function get instance():KCountriesUtil
		{
			if(_instance == null)
			{
				_instance = new KCountriesUtil(new Enforcer());
			}
			
			return _instance;
		}
		
		/***
		 * Getting a copy of all countries, to use and modify
		 * 
		 */
		public function getAllCountriesForModificationUse():ArrayCollection
		{
			 var arrColForModificationUse:ArrayCollection = new ArrayCollection();
			 initCountriesArray(arrColForModificationUse);
			 
			 return arrColForModificationUse;
		}
		
		/***
		 * Init countries codes and locale
		 */
		private function initCountriesArray(arrCol:ArrayCollection):void
		{
			
			//---------------
			// Existing codes
			//---------------
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'af'), code:"AF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'al'), code:"AL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'dz'), code:"DZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'as'), code:"AS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ad'), code:"AD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ao'), code:"AO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ai'), code:"AI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'aq'), code:"AQ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ag'), code:"AG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ar'), code:"AR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'am'), code:"AM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'aw'), code:"AW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'au'), code:"AU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'at'), code:"AT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'az'), code:"AZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bs'), code:"BS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bh'), code:"BH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bd'), code:"BD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bb'), code:"BB"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'by'), code:"BY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'be'), code:"BE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bz'), code:"BZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bj'), code:"BJ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bm'), code:"BM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bt'), code:"BT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bo'), code:"BO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ba'), code:"BA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bw'), code:"BW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bv'), code:"BV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'br'), code:"BR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'io'), code:"IO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bn'), code:"BN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bg'), code:"BG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bf'), code:"BF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'bi'), code:"BI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kh'), code:"KH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cm'), code:"CM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ca'), code:"CA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cv'), code:"CV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ky'), code:"KY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cf'), code:"CF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'td'), code:"TD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cl'), code:"CL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cn'), code:"CN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'co'), code:"CO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'km'), code:"KM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cg'), code:"CG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cd'), code:"CD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ck'), code:"CK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cr'), code:"CR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ci'), code:"CI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'hr'), code:"HR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cu'), code:"CU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cy'), code:"CY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cz'), code:"CZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'dk'), code:"DK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'dj'), code:"DJ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'dm'), code:"DM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'do'), code:"DO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ec'), code:"EC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'eg'), code:"EG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sv'), code:"SV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gq'), code:"GQ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'er'), code:"ER"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ee'), code:"EE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'et'), code:"ET"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fk'), code:"FK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fo'), code:"FO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fj'), code:"FJ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fi'), code:"FI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fr'), code:"FR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gf'), code:"GF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pf'), code:"PF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tf'), code:"TF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ga'), code:"GA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gm'), code:"GM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ge'), code:"GE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'de'), code:"DE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gh'), code:"GH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gi'), code:"GI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gr'), code:"GR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gl'), code:"GL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gd'), code:"GD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gp'), code:"GP"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gu'), code:"GU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gt'), code:"GT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gg'), code:"GG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gn'), code:"GN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gw'), code:"GW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gy'), code:"GY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ht'), code:"HT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'hm'), code:"HM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'hn'), code:"HN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'hk'), code:"HK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'hu'), code:"HU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'is'), code:"IS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'in'), code:"IN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'id'), code:"ID"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ir'), code:"IR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'iq'), code:"IQ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ie'), code:"IE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'im'), code:"IM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'il'), code:"IL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'it'), code:"IT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'jm'), code:"JM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'jp'), code:"JP"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'je'), code:"JE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'jo'), code:"JO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kz'), code:"KZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ke'), code:"KE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ki'), code:"KI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kr'), code:"KR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kw'), code:"KW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kg'), code:"KG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'la'), code:"LA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lv'), code:"LV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lb'), code:"LB"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ls'), code:"LS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lr'), code:"LR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ly'), code:"LY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'li'), code:"LI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lt'), code:"LT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lu'), code:"LU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mo'), code:"MO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mk'), code:"MK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mg'), code:"MG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mw'), code:"MW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'my'), code:"MY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mv'), code:"MV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ml'), code:"ML"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mt'), code:"MT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mh'), code:"MH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mq'), code:"MQ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mr'), code:"MR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mu'), code:"MU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'yt'), code:"YT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mx'), code:"MX"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'fm'), code:"FM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'md'), code:"MD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mc'), code:"MC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mn'), code:"MN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ms'), code:"MS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ma'), code:"MA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mz'), code:"MZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mm'), code:"MM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'na'), code:"NA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nr'), code:"NR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'np'), code:"NP"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nl'), code:"NL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'an'), code:"AN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nc'), code:"NC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nz'), code:"NZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ni'), code:"NI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ne'), code:"NE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ng'), code:"NG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nu'), code:"NU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'nf'), code:"NF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kp'), code:"KP"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mp'), code:"MP"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'no'), code:"NO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'om'), code:"OM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pk'), code:"PK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pw'), code:"PW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pa'), code:"PA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pg'), code:"PG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'py'), code:"PY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pe'), code:"PE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ph'), code:"PH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pn'), code:"PN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pl'), code:"PL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pt'), code:"PT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pr'), code:"PR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'qa'), code:"QA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 're'), code:"RE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ro'), code:"RO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ru'), code:"RU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'rw'), code:"RW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ws'), code:"WS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sm'), code:"SM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'st'), code:"ST"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sa'), code:"SA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sn'), code:"SN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sc'), code:"SC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sl'), code:"SL"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sg'), code:"SG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sk'), code:"SK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'si'), code:"SI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sb'), code:"SB"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'so'), code:"SO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'za'), code:"ZA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'gs'), code:"GS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'es'), code:"ES"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lk'), code:"LK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'kn'), code:"KN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'lc'), code:"LC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'pm'), code:"PM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'vc'), code:"VC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sd'), code:"SD"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sr'), code:"SR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sz'), code:"SZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'se'), code:"SE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ch'), code:"CH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sy'), code:"SY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tw'), code:"TW"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tj'), code:"TJ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tz'), code:"TZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'th'), code:"TH"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tg'), code:"TG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tk'), code:"TK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'to'), code:"TO"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tt'), code:"TT"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tn'), code:"TN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tr'), code:"TR"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tm'), code:"TM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tc'), code:"TC"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tv'), code:"TV"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ug'), code:"UG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ua'), code:"UA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ae'), code:"AE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'uk'), code:"UK"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'us'), code:"US"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'um'), code:"UM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'uy'), code:"UY"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'uz'), code:"UZ"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'vu'), code:"VU"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'va'), code:"VA"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 've'), code:"VE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'vn'), code:"VN"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'vi'), code:"VI"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'vg'), code:"VG"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'wf'), code:"WF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ye'), code:"YE"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'zm'), code:"ZM"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'zw'), code:"ZW"});
			//-----------------------
			// New codes without flag
			// ----------------------
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ax'), code:"AX"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cs'), code:"CS"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'me'), code:"ME"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'mf'), code:"MF"});
			arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'rs'), code:"RS"});
			//----------------------
			// Deleted country codes
			//----------------------
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ps'), code:"PS"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ac'), code:"AC"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'ta'), code:"TA"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'tp'), code:"TP"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sj'), code:"SJ"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'sh'), code:"SH"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cx'), code:"CX"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'cc'), code:"CC"});*/
			//arrCol.addItem({name:ResourceManager.getInstance().getString('countries', 'yu'), code:"YU"});*/



		}
		
		/**
		 * INit countries map
		 * 
		 */
		private function initCountriesFlagsMap():void
		{
			//-----------------------
			// New codes without flag
			// ----------------------
			//countriesFlagsMap.put('ax', _ax);
			//countriesFlagsMap.put('cs', _cs);
			//countriesFlagsMap.put('me', _me);
			//countriesFlagsMap.put('mf', _mf);
			//countriesFlagsMap.put('rs', _rs);
			//--------------
			// Existing list
			//--------------
			countriesFlagsMap.put('af', _af);
			countriesFlagsMap.put('al', _al);			
			countriesFlagsMap.put('dz', _dz);			
			countriesFlagsMap.put('as', _as);			
			countriesFlagsMap.put('ad', _ad);			
			countriesFlagsMap.put('ao', _ao);			
			countriesFlagsMap.put('ai', _ai);			
			countriesFlagsMap.put('aq', _aq);
			countriesFlagsMap.put('ag', _ag);			
			countriesFlagsMap.put('ar', _ar);			
			countriesFlagsMap.put('am', _am);			
			countriesFlagsMap.put('aw', _aw);			
			countriesFlagsMap.put('au', _au);			
			countriesFlagsMap.put('at', _at);			
			countriesFlagsMap.put('az', _az);			
			countriesFlagsMap.put('bs', _bs);			
			countriesFlagsMap.put('bh', _bh);			
			countriesFlagsMap.put('bd', _bd);			
			countriesFlagsMap.put('bb', _bb);			
			countriesFlagsMap.put('by', _by);			
			countriesFlagsMap.put('be', _be);			
			countriesFlagsMap.put('bz', _bz);			
			countriesFlagsMap.put('bj', _bj);			
			countriesFlagsMap.put('bm', _bm);			
			countriesFlagsMap.put('bt', _bt);			
			countriesFlagsMap.put('bo', _bo);			
			countriesFlagsMap.put('ba', _ba);			
			countriesFlagsMap.put('bw', _bw);			
			countriesFlagsMap.put('bv', _bv);			
			countriesFlagsMap.put('br', _br);			
			countriesFlagsMap.put('io', _io);			
			countriesFlagsMap.put('bn', _bn);			
			countriesFlagsMap.put('bg', _bg);			
			countriesFlagsMap.put('bf', _bf);			
			countriesFlagsMap.put('bi', _bi);			
			countriesFlagsMap.put('kh', _kh);			
			countriesFlagsMap.put('cm', _cm);			
			countriesFlagsMap.put('ca', _ca);			
			countriesFlagsMap.put('cv', _cv);			
			countriesFlagsMap.put('ky', _ky);			
			countriesFlagsMap.put('cf', _cf);			
	 		countriesFlagsMap.put('td', _td);			 
			countriesFlagsMap.put('cl', _cl);
			countriesFlagsMap.put('cn', _cn);			
			countriesFlagsMap.put('co', _co);			
			countriesFlagsMap.put('km', _km);			
			countriesFlagsMap.put('cg', _cg);			
			countriesFlagsMap.put('cd', _cd);			
			countriesFlagsMap.put('ck', _ck);			
			countriesFlagsMap.put('cr', _cr);			
			countriesFlagsMap.put('ci', _ci);			
			countriesFlagsMap.put('hr', _hr);			
			countriesFlagsMap.put('cu', _cu);			
			countriesFlagsMap.put('cy', _cy);			
			countriesFlagsMap.put('cz', _cz);			
			countriesFlagsMap.put('dk', _dk);			
			countriesFlagsMap.put('dj', _dj);			
			countriesFlagsMap.put('dm', _dm);			
			countriesFlagsMap.put('do', _do);			
			countriesFlagsMap.put('ec', _ec);			
			countriesFlagsMap.put('eg', _eg);			
			countriesFlagsMap.put('sv', _sv);			
			countriesFlagsMap.put('gq', _gq);			
			countriesFlagsMap.put('er', _er);			
			countriesFlagsMap.put('ee', _ee);			
			countriesFlagsMap.put('et', _et);			
			countriesFlagsMap.put('fk', _fk);			
			countriesFlagsMap.put('fo', _fo);			
			countriesFlagsMap.put('fj', _fj);			
			countriesFlagsMap.put('fi', _fi);			
			countriesFlagsMap.put('fr', _fr);			
			countriesFlagsMap.put('gf', _gf);			
			countriesFlagsMap.put('pf', _pf);			
			countriesFlagsMap.put('tf', _tf);			
			countriesFlagsMap.put('ga', _ga);			
			countriesFlagsMap.put('gm', _gm);			
			countriesFlagsMap.put('ge', _ge);			
			countriesFlagsMap.put('de', _de);			
			countriesFlagsMap.put('gh', _gh);			
			countriesFlagsMap.put('gi', _gi);			
			countriesFlagsMap.put('gr', _gr);			
			countriesFlagsMap.put('gl', _gl);			
			countriesFlagsMap.put('gd', _gd);			
			countriesFlagsMap.put('gp', _gp);			
	 		countriesFlagsMap.put('gu', _gu);		 
			countriesFlagsMap.put('gt', _gt);			
			countriesFlagsMap.put('gg', _gg); 		
			countriesFlagsMap.put('gn', _gn);			
			countriesFlagsMap.put('gw', _gw);			
			countriesFlagsMap.put('gy', _gy);			
			countriesFlagsMap.put('ht', _ht);			
			countriesFlagsMap.put('hm', _hm);			
			countriesFlagsMap.put('hn', _hn);			
			countriesFlagsMap.put('hk', _hk);			
			countriesFlagsMap.put('hu', _hu);			
			countriesFlagsMap.put('is', _is);			
			countriesFlagsMap.put('in', _in);			
			countriesFlagsMap.put('id', _id);			
			countriesFlagsMap.put('ir', _ir);			
			countriesFlagsMap.put('iq', _iq);			
			countriesFlagsMap.put('ie', _ie);			
			countriesFlagsMap.put('im', _im); 		
			countriesFlagsMap.put('il', _il);			
			countriesFlagsMap.put('it', _it);			
			countriesFlagsMap.put('jm', _jm);			
			countriesFlagsMap.put('jp', _jp);			
			countriesFlagsMap.put('je', _je); 			
			countriesFlagsMap.put('jo', _jo);			
			countriesFlagsMap.put('kz', _kz);			
			countriesFlagsMap.put('ke', _ke);			
			countriesFlagsMap.put('ki', _ki);			
			countriesFlagsMap.put('kr', _kr);			
			countriesFlagsMap.put('kw', _kw);			
			countriesFlagsMap.put('kg', _kg);			
			countriesFlagsMap.put('la', _la);			
			countriesFlagsMap.put('lv', _lv);			
			countriesFlagsMap.put('lb', _lb);			
			countriesFlagsMap.put('ls', _ls);			
			countriesFlagsMap.put('lr', _lr);			
			countriesFlagsMap.put('ly', _ly);			
			countriesFlagsMap.put('li', _li);			
			countriesFlagsMap.put('lt', _lt);			
			countriesFlagsMap.put('lu', _lu);			
			countriesFlagsMap.put('mo', _mo);			
			countriesFlagsMap.put('mk', _mk);			
			countriesFlagsMap.put('mg', _mg);			
			countriesFlagsMap.put('mw', _mw);			
			countriesFlagsMap.put('my', _my);			
			countriesFlagsMap.put('mv', _mv);			
			countriesFlagsMap.put('ml', _ml);			
			countriesFlagsMap.put('mt', _mt);			
			countriesFlagsMap.put('mh', _mh);			
			countriesFlagsMap.put('mq', _mq);			
			countriesFlagsMap.put('mr', _mr);			
			countriesFlagsMap.put('mu', _mu);			
			countriesFlagsMap.put('yt', _yt);			
			countriesFlagsMap.put('mx', _mx);			
			countriesFlagsMap.put('fm', _fm);			
			countriesFlagsMap.put('md', _md);			
			countriesFlagsMap.put('mc', _mc);			
			countriesFlagsMap.put('mn', _mn);			
			countriesFlagsMap.put('ms', _ms);			
			countriesFlagsMap.put('ma', _ma);			
			countriesFlagsMap.put('mz', _mz);			
			countriesFlagsMap.put('mm', _mm);			
			countriesFlagsMap.put('na', _na);			
			countriesFlagsMap.put('nr', _nr);			
			countriesFlagsMap.put('np', _np);			
			countriesFlagsMap.put('nl', _nl);			
			countriesFlagsMap.put('an', _an);			
			countriesFlagsMap.put('nc', _nc);			
			countriesFlagsMap.put('nz', _nz);			
			countriesFlagsMap.put('ni', _ni);			
			countriesFlagsMap.put('ne', _ne);			
			countriesFlagsMap.put('ng', _ng);			
			countriesFlagsMap.put('nu', _nu);			
			countriesFlagsMap.put('nf', _nf);			
			countriesFlagsMap.put('kp', _kp);			
			countriesFlagsMap.put('mp', _mp);			
			countriesFlagsMap.put('no', _no);			
			countriesFlagsMap.put('om', _om);			
			countriesFlagsMap.put('pk', _pk);			
			countriesFlagsMap.put('pw', _pw);			
			countriesFlagsMap.put('pa', _pa);			
			countriesFlagsMap.put('pg', _pg);			
			countriesFlagsMap.put('py', _py);			
			countriesFlagsMap.put('pe', _pe);			
			countriesFlagsMap.put('ph', _ph);			
			countriesFlagsMap.put('pn', _pn);			
			countriesFlagsMap.put('pl', _pl);			
			countriesFlagsMap.put('pt', _pt);			
			countriesFlagsMap.put('pr', _pr);			
			countriesFlagsMap.put('qa', _qa);			
			countriesFlagsMap.put('re', _re);			
			countriesFlagsMap.put('ro', _ro);			
			countriesFlagsMap.put('ru', _ru);			
			countriesFlagsMap.put('rw', _rw);			
			countriesFlagsMap.put('ws', _ws);			
			countriesFlagsMap.put('sm', _sm);			
			countriesFlagsMap.put('st', _st);			
			countriesFlagsMap.put('sa', _sa);			
			countriesFlagsMap.put('sn', _sn);			
			countriesFlagsMap.put('sc', _sc);			
			countriesFlagsMap.put('sl', _sl);			
			countriesFlagsMap.put('sg', _sg);			
			countriesFlagsMap.put('sk', _sk);			
			countriesFlagsMap.put('si', _si);			
			countriesFlagsMap.put('sb', _sb);			
			countriesFlagsMap.put('so', _so);			
			countriesFlagsMap.put('za', _za);			
			countriesFlagsMap.put('gs', _gs);			
			countriesFlagsMap.put('es', _es);			
			countriesFlagsMap.put('lk', _lk);			
			countriesFlagsMap.put('kn', _kn);			
			countriesFlagsMap.put('lc', _lc);			
			countriesFlagsMap.put('pm', _pm);			
			countriesFlagsMap.put('vc', _vc);			
			countriesFlagsMap.put('sd', _sd);			
			countriesFlagsMap.put('sr', _sr);			
			countriesFlagsMap.put('sz', _sz);			
			countriesFlagsMap.put('se', _se);			
			countriesFlagsMap.put('ch', _ch);			
			countriesFlagsMap.put('sy', _sy);			
			countriesFlagsMap.put('tw', _tw);			
			countriesFlagsMap.put('tj', _tj);			
			countriesFlagsMap.put('tz', _tz);			
			countriesFlagsMap.put('th', _th);			
			countriesFlagsMap.put('tg', _tg);			
			countriesFlagsMap.put('tk', _tk);			
			countriesFlagsMap.put('to', _to);			
			countriesFlagsMap.put('tt', _tt);			
			countriesFlagsMap.put('tn', _tn);			
			countriesFlagsMap.put('tr', _tr);			
			countriesFlagsMap.put('tm', _tm);			
			countriesFlagsMap.put('tc', _tc);			
			countriesFlagsMap.put('tv', _tv);			
			countriesFlagsMap.put('ug', _ug);			
			countriesFlagsMap.put('ua', _ua);			
			countriesFlagsMap.put('ae', _ae);			
			countriesFlagsMap.put('uk', _uk); 			
			countriesFlagsMap.put('us', _us);			
			countriesFlagsMap.put('um', _um);			
			countriesFlagsMap.put('uy', _uy);			
			countriesFlagsMap.put('uz', _uz);			
			countriesFlagsMap.put('vu', _vu);			
			countriesFlagsMap.put('va', _va);			
			countriesFlagsMap.put('ve', _ve);			
			countriesFlagsMap.put('vn', _vn);			
			countriesFlagsMap.put('vi', _vi);			
			countriesFlagsMap.put('vg', _vg);			
			countriesFlagsMap.put('wf', _wf);			
			countriesFlagsMap.put('ye', _ye);			
			countriesFlagsMap.put('zm', _zm);			
			countriesFlagsMap.put('zw', _zw);
			/*----------------------
			/* Deleted country codes
			/*----------------------
			/*countriesFlagsMap.put('cx', _cx);			
			/*countriesFlagsMap.put('cc', _cc);			
			/*countriesFlagsMap.put('ta', _ta);
			/*countriesFlagsMap.put('tp', _tp); 
			/*countriesFlagsMap.put('sj', _sj);		
			/*countriesFlagsMap.put('sh', _sh);	
			/*countriesFlagsMap.put('yu', _yu); 
			/*countriesFlagsMap.put('ps', _ps);	
			countriesFlagsMap.put('ac', _ac);*/ 			
			
			
			
			
			
		}
		
		
		private function initCountriesMaps():void
		{
			var locationInMap:int = 0;
			for each(var country:Object in countriesArr)
			{
				countriesMap.put(country.code, country.name);
				countriesLocationInMap.put(country.code, locationInMap+'');
				locationInMap++;
			}
		}
		
		/***
		 * Get the index of the country in the countries map...saves the looping issues
		 */
		public function getLocationInCollection(countryCode:String):int
		{
			return int(countriesLocationInMap.getValue(countryCode));
		}

		/**
		 * Getting the image of the country flag of the given contry code
		 */
		public function getCountryFlag(countryCode:String):Class
		{
			var lcFlagCode:String = countryCode.toLowerCase();
			
			var flagSrc:Object = countriesFlagsMap.getValue(lcFlagCode);
			
			return flagSrc ? flagSrc as Class : null;
		}
		
		/**
		 * Getting the locale of the country of the given contry code
		 */
		public function getCountryName(countryCode:String):String
		{
			var lcFlagCode:String = countryCode.toLowerCase();
			
			var name:String = ResourceManager.getInstance().getString('countries', lcFlagCode);
			
			return name ? name : '';
		}
		
	}
}

class Enforcer
{
	
}