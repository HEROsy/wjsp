var s = "";
if(navigator.userAgent.indexOf("MSIE")>0){
	//s = "<OBJECT id='WebOffice1' align='middle' style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT:100%'"
	//	+ "classid=clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5  codebase=/WebOffice/WebOffice.ocx"
    //	+ "</OBJECT>";
    s="<object id='WebOffice1' height='100%' width='100%' style='LEFT: 0px; TOP: 0px' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='/WebOffice/WebOffice.ocx'>"+
            "<param name='_ExtentX' value='6350' />"+
            "<param name='_ExtentY' value='6350' />"+
        "</object>"
}

if(navigator.userAgent.indexOf("Chrome")>0){
	s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
		+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'"
		+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}'"
        + "codebase='/WebOffice/WebOffice.ocx'"
		+ "event_NotifyCtrlReady='WebOffice1_NotifyCtrlReady'>"
		+ "</object>";	
}

if(navigator.userAgent.indexOf("Firefox")>0){
	s = "<object id='WebOffice1' type='application/x-itst-activex' align='baseline' border='0'"
		+ "style='LEFT: 0px; WIDTH: 100%; TOP: 0px; HEIGHT: 100%'" 
		+ "clsid='{E77E049B-23FC-4DB8-B756-60529A35FAD5}'"
        + "codebase='/WebOffice/WebOffice.ocx'"
		+ "event_NotifyCtrlReady='WebOffice1_NotifyCtrlReady'>"
		+ "</object>";	
}
document.write(s) 