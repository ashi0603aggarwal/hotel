<html>
<head>
    <asset:javascript src="application.js"></asset:javascript>
    <asset:stylesheet src="booking/guestList.css"></asset:stylesheet>
    <asset:javascript src="booking/guestList.js"></asset:javascript>
    <g:javascript library="jquery"/>
</head>
<body>
<div id="demo">
    <h1>Booking Details</h1>
    <h3 align="right"><a href="/default/dash" class="btn btn-lg" role="button">Dashboard</a></h3>
    <g:render template="searchBooking" />

    <div id="hotelbookings">
        <g:render template="bookingList" model="['booking1':booking1]" />
    </div>
</div>

<script>
    function greetName() {
        var name = document.getElementById('customerName').value
        var customerPhNo = document.getElementById('customerPhNo').value
        $.ajax({
            url:'${g.createLink( controller:'booking', action:'filterBookings' )}',
            data:{ name: name , customerPhNo: customerPhNo},
            success: function(data) {
                $("#hotelbookings").html(data.htmlContent);
            }
        });
    }
</script>
</body>
</html>
