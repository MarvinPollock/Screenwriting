//This is a manifest file that'll be compiled into application.js, which will include all the files
//listed below.

//Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
//or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.

//It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
//the compiled file.

//WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
//GO AFTER THE REQUIRES BELOW.

//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.ui.dialog
//= require_tree .

function getUserGroupsAsJson(){
	var result = doAjax("GET", "", "/user/groups", "json", null);
	$.ajax({
		type: "GET",
		url:  "/user/groups",
		dataType: "json",
		success: function(result){
			if (result.length > 0) {
				for (var i = 0; i < result.length; i++) {
					$('select').append($('<option>', {
						value: result[i].num,
						text: '' + result[i].num
					}));
				}
				$("#dialog-project").dialog("open");
			} else {
				$("#warnung").dialog("open");
			}
		},
		error: function(xhr, status, err){
			alert(err);
		}
	});
}

function doAjax(type, contentType, url, dataType, data){
	$.ajax({
		type: type,
		url:  url,
		contentType: contentType == "" ? "application/x-www-form-urlencoded; charset=UTF-8" : contentType,
		dataType: dataType,
		success: function(result){
			return {success: true, data: result};
		},
		error: function(xhr, status, err){
			return {success: false, data: err};
		}
	});
}

function einladen(current, user){
    var returnVal = doAjax("GET", "json; charset=UTF-8", "/user/groups", "json", null);    
    if(returnVal.success){
    	if(returnVal.data.length == 1){
    		returnVal = doAjax("GET", "", "/message/create", "text", {sender: current, receiver: user, object: "Invitation", groupId: result[0].id});
            if(!returnVal.success){
            	alert(returnVal.data)
            }
        }else if(returnVal.data.length > 1){
        	var result = returnVal.data;
            for(var i=0; i<result.length; i++){
                $('select').append($('<option>', {
                value: result[i].id,
                text: ''+result[i].id
                }));
            }
            $("#dialog-group").data("data", {sender: current, receiver: user}).dialog("open");
        }else{
            alert("Empty group");
        }
    }else{
    	alert(returnVal.data);
    }
}

function projectAnlegen(){ 
	var result = doAjax("GET", "", "/user/groups", "json", data)
	if(returnVal.success){
    	if(result.length > 0){
    		for (var i = 0; i < result.length; i++) {
				$('select').append($('<option>', {
					value: result[i].num,
					text: '' + result[i].num
				}));
			}
			$("#dialog-project").dialog("open");
        }else {
			$("#warnung").dialog("open");
		}
    }else{
    	alert(returnVal.data);
    }
}

(function($){
	$.widget( "ui.combobox", {
		_create: function() {
			$('#dialog-project').hide();
			var select = this.element,
			selected = select.children(":selected"),
			value = selected.val() ? selected.text() : "";

			function updateTips(tips){
				tips.addClass("ui-state-highlight");
				setTimeout(function(){
					tips.removeClass("ui-state-highlight", 1500);
				}, 500);
			}

			$(".proj_warnung").dialog({
				autoOpen: false,
				height: 300,
				width: 300,
				modal: true,
				buttons: {
					"Ok": function(){
						$(this).dialog("close");
					}
				}
			});
			
//___________________________________________________________
//          PROJEKT-ANLEGEN-POP-UP
//___________________________________________________________
			
			$("#dialog-project").dialog({
				autoOpen: false,
				height: 300,
				width: 350,
				modal: true,
				buttons: {
					"Ok": function(){
						if(selected.val() == ""){
							updateTips(tips);
							return;
						}else{
							var result = doAjax("POST", "", "/projects/create", "text", { pName: $('#proj_name').val(), gNumber: $('#group_number').val() })
							if(result.success){
								$(this).dialog("close");
							}else{
								$(".proj_error").html(result.data);
								updateTips($(".proj_tips"));
							}
						}
					},
					Cancel: function(){
						$(this).dialog("close");
					}
				}
			});
			
//___________________________________________________________
//             USER-EINLADEN-POP-UP
//___________________________________________________________

			$("#dialog-group").dialog({
                autoOpen: false,
                height: 300,
                width: 350,
                modal: true,
                buttons: {
                    "Ok": function(){
                        if(selected.val() == ""){
                            updateTips();
                            return;
                        }else{
                            var data = $(this).data("data");
                            var result = doAjax("GET", "", "/message/create", "text", { sender: data.sender, receiver: data.receiver, object: "Invitation", groupId: selected.val() })
                            if(result.success){
                            	$(this).dialog("close");
                            }else{
                            	$(".user_error").html(err);
                            	updateTips($(".user_tips"));
                            }
                        }
                    },
                    Cancel: function(){
                        $(this).dialog("close");
                    }
                }
            });			
			
//___________________________________________________________
			
		},
		_destroy: function() {
			this.element.show();
		}
	});
})(jQuery);