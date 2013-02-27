function einladen(current, user){ // current, user
	$.ajax({
		type: "GET",
		url:  "/user/groups",
		dataType: "json",
		success: function(result){
			alert(result);
			if(result.length == 1){
				$.ajax({
					type: "GET",
					url:  "/message/create",
					dataType: "text",
					data: { sender: current, receiver: user, object: "Invitation", groupId: result[0].id},
					success: function(result){
						//TODO pops up, Einladung geschickt
					},
					error: function(xhr, status, err){
						alert(err);
					}
				});
			}else if(result.length > 1){
//				for(var i=0; i<result.length; i++){
//				$('select').append($('<option>', {
//				value: result[i].id,
//				text: ''+result[i].id
//				}));
//				}
				$("#dialog-group").dialog("open");
			}else{
				alert("Empty group");
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
			var select = this.element.show(),
			$('#combobox').show();
			selected = select.children(":selected"),
			tips = $(".validateTips"),
			value = selected.val() ? selected.text() : "";

			function updateTips(){
				tips.addClass("ui-state-highlight");
				setTimeout(function(){
					tips.removeClass("ui-state-highlight", 1500);
				}, 500);
			}

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
							$.ajax({
								type: "GET",
								url:  "/message/create",
								dataType: "text",
								data: { sender: current, receiver: user, object: "Invitation", groupId: selected.val() }, 
								success: function(result){
									$(this).dialog("close");
								},
								error: function(xhr, status, err){
									alert(err);
								}
							});
						}
					},
					Cancel: function(){
						$(this).dialog("close");
					}
				}, 
			});
		},
		_destroy: function() {
			this.element.show();
		}
	});
})(jQuery);
$("#combobox").combobox();  