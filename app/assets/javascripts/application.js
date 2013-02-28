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

function anlegen(){ 
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

(function($){
	$.widget( "ui.combobox", {
		_create: function() {
			$('#dialog-project').hide();
			var select = this.element,
			selected = select.children(":selected"),
			tips = $(".validateTips"),
			errorTips = $(".error"),
			value = selected.val() ? selected.text() : "";

			function updateTips(tips){
				tips.addClass("ui-state-highlight");
				setTimeout(function(){
					tips.removeClass("ui-state-highlight", 1500);
				}, 500);
			}

			$("#warnung").dialog({
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
							var that = this;
							$.ajax({
								type: "POST",
								url:  '/projects/create',
								dataType: "text",
								data: { pName: $('#proj_name').val(), gNumber: $('#group_number').val() },
								success: function(result){
									$(that).dialog("close");
								},
								error: function(xhr, status, err){
									$(".error").html(err);
									updateTips(errorTips);
								}
							});
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
                            var that = this;
                            $.ajax({
                                type: "GET",
                                url:  "/message/create",
                                dataType: "text",
                                data: { sender: data.sender, receiver: data.receiver, object: "Invitation", groupId: selected.val() }, 
                                success: function(result){
                                    $(that).dialog("close");
                                },
                                error: function(xhr, status, err){
                                	$(".error").html(err);
                                	updateTips(errorTips);
                                }
                            });
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
$("#group_number").combobox();