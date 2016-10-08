$(document).ready(function(){
	$(".js-clicks").on("click", function(){
        window.location.href ="/dashboard"
		// console.log(second_array_names)
	})

    $(".js-impressions").on("click", function(){
        window.location.href ="/weekly-dashboard-impressions"
	})

    $(".js-cpc").on("click", function(){
        window.location.href ="/weekly-dashboard-cpc"
	})

    $(".js-cost").on("click", function(){
        window.location.href ="/weekly-dashboard-cost"
	})

    $(".js-ctr").on("click", function(){
        window.location.href ="/weekly-dashboard-ctr"
	})

    $(".js-conversions").on("click", function(){
        window.location.href ="/weekly-dashboard-conversions"
	})

    $(".js-conversion-rate").on("click", function(){
        window.location.href ="/weekly-dashboard-conversion-rate"
	})

    $(".js-cpa").on("click", function(){
            window.location.href ="/weekly-dashboard-cpa"
        })

    $("td:contains('Easy')").addClass("easy");
    $("td:contains('Medium')").addClass("medium");
    $("td:contains('Hard')").addClass("hard");


	
});