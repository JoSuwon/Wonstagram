/**
 * 
 */

alert=function() {};
while(!(new Date().getMinutes() == 1)) {
	var nm = "";
	$.ajax({
		url : "/E200709/GetReseve",
		type : "POST",
		data : '{ nm : "' + nm + '"}',
		dataType : 'json',
		async : false,
		contentType : "application/json; charset=utf-8",
		success : function(resultData) {
			if (resultData.ResultCode == 1) {
				
			} else {
				
			}
		}
	});
}
location.reload(true);